#!/usr/bin/env python3
"""Extract daily Codex session evidence for diary summaries."""

from __future__ import annotations

import argparse
import json
import os
from dataclasses import dataclass, field
from datetime import date, datetime
from pathlib import Path
from typing import Any


BOILERPLATE_PREFIXES = (
    "# AGENTS.md instructions",
    "<environment_context>",
    "<turn_context",
)


@dataclass
class SessionSummary:
    path: Path
    session_id: str = ""
    started_at: str = ""
    cwd_values: set[str] = field(default_factory=set)
    user_requests: list[str] = field(default_factory=list)
    assistant_messages: list[str] = field(default_factory=list)
    aborted_turns: int = 0
    parse_errors: int = 0


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Extract Codex session evidence for a daily AI work diary entry."
    )
    parser.add_argument(
        "--date",
        default=date.today().isoformat(),
        help="Target local date in YYYY-MM-DD format. Defaults to today.",
    )
    parser.add_argument(
        "--sessions-root",
        default="~/.codex/sessions",
        help="Codex sessions root. Defaults to ~/.codex/sessions.",
    )
    parser.add_argument(
        "--cwd-prefix",
        action="append",
        default=[],
        help="Only include sessions whose cwd starts with this path. Repeatable.",
    )
    parser.add_argument(
        "--max-items",
        type=int,
        default=8,
        help="Maximum user and assistant snippets to show per session.",
    )
    parser.add_argument(
        "--max-chars",
        type=int,
        default=320,
        help="Maximum characters per snippet.",
    )
    parser.add_argument(
        "--json",
        action="store_true",
        help="Emit JSON instead of Markdown-style text.",
    )
    return parser.parse_args()


def session_dir(sessions_root: str, target_date: str) -> Path:
    year, month, day = target_date.split("-")
    return Path(os.path.expanduser(sessions_root)) / year / month / day


def text_from_content(content: Any, text_type: str) -> str:
    if isinstance(content, str):
        return content
    if not isinstance(content, list):
        return ""
    parts: list[str] = []
    for item in content:
        if isinstance(item, dict) and item.get("type") == text_type:
            text = item.get("text", "")
            if isinstance(text, str):
                parts.append(text)
    return "\n".join(parts)


def clean_snippet(text: str, max_chars: int) -> str:
    snippet = " ".join(text.split())
    if len(snippet) <= max_chars:
        return snippet
    return snippet[: max_chars - 1].rstrip() + "..."


def is_boilerplate(text: str) -> bool:
    stripped = text.lstrip()
    return not stripped or any(stripped.startswith(prefix) for prefix in BOILERPLATE_PREFIXES)


def read_session(path: Path, max_chars: int) -> SessionSummary:
    summary = SessionSummary(path=path)
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        try:
            item = json.loads(line)
        except json.JSONDecodeError:
            summary.parse_errors += 1
            continue

        item_type = item.get("type")
        payload = item.get("payload", {})
        if item_type == "session_meta":
            summary.session_id = str(payload.get("id") or summary.session_id)
            summary.started_at = str(payload.get("timestamp") or item.get("timestamp") or "")
        elif item_type == "turn_context":
            cwd = payload.get("cwd")
            if isinstance(cwd, str) and cwd:
                summary.cwd_values.add(cwd)
        elif item_type == "response_item" and isinstance(payload, dict):
            if payload.get("role") == "user":
                text = text_from_content(payload.get("content"), "input_text")
                if "<turn_aborted>" in text:
                    summary.aborted_turns += 1
                    continue
                if not is_boilerplate(text):
                    summary.user_requests.append(clean_snippet(text, max_chars))
            elif payload.get("role") == "assistant":
                text = text_from_content(payload.get("content"), "output_text")
                if not is_boilerplate(text):
                    summary.assistant_messages.append(clean_snippet(text, max_chars))
    return summary


def cwd_matches(summary: SessionSummary, prefixes: list[str]) -> bool:
    if not prefixes:
        return True
    normalized = [str(Path(os.path.expanduser(prefix)).resolve()) for prefix in prefixes]
    for cwd in summary.cwd_values:
        try:
            resolved = str(Path(cwd).resolve())
        except OSError:
            resolved = cwd
        if any(resolved == prefix or resolved.startswith(prefix + os.sep) for prefix in normalized):
            return True
    return False


def local_time_label(timestamp: str) -> str:
    if not timestamp:
        return ""
    try:
        dt = datetime.fromisoformat(timestamp.replace("Z", "+00:00"))
    except ValueError:
        return timestamp
    return dt.astimezone().strftime("%H:%M")


def collect(args: argparse.Namespace) -> list[SessionSummary]:
    directory = session_dir(args.sessions_root, args.date)
    if not directory.is_dir():
        return []
    sessions = [read_session(path, args.max_chars) for path in sorted(directory.glob("*.jsonl"))]
    return [summary for summary in sessions if cwd_matches(summary, args.cwd_prefix)]


def as_dict(summary: SessionSummary, max_items: int) -> dict[str, Any]:
    return {
        "path": str(summary.path),
        "session_id": summary.session_id,
        "started_at": summary.started_at,
        "local_start_time": local_time_label(summary.started_at),
        "cwd_values": sorted(summary.cwd_values),
        "user_requests": summary.user_requests[:max_items],
        "assistant_messages": summary.assistant_messages[-max_items:],
        "aborted_turns": summary.aborted_turns,
        "parse_errors": summary.parse_errors,
    }


def print_markdown(target_date: str, sessions: list[SessionSummary], max_items: int) -> None:
    print(f"# Codex daily work evidence for {target_date}")
    print()
    print(f"Sessions matched: {len(sessions)}")
    for summary in sessions:
        print()
        print(f"## {summary.path.name}")
        if summary.session_id:
            print(f"- Session: `{summary.session_id}`")
        if summary.started_at:
            print(f"- Started: {summary.started_at} ({local_time_label(summary.started_at)} local)")
        if summary.cwd_values:
            print("- CWD:")
            for cwd in sorted(summary.cwd_values):
                print(f"  - `{cwd}`")
        if summary.aborted_turns:
            print(f"- Interrupted turns: {summary.aborted_turns}")
        if summary.parse_errors:
            print(f"- Parse errors: {summary.parse_errors}")
        if summary.user_requests:
            print("- User requests:")
            for text in summary.user_requests[:max_items]:
                print(f"  - {text}")
        if summary.assistant_messages:
            print("- Assistant evidence:")
            for text in summary.assistant_messages[-max_items:]:
                print(f"  - {text}")


def main() -> int:
    args = parse_args()
    sessions = collect(args)
    if args.json:
        print(json.dumps([as_dict(summary, args.max_items) for summary in sessions], ensure_ascii=False, indent=2))
    else:
        print_markdown(args.date, sessions, args.max_items)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
