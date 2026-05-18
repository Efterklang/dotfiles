"""Dotfiles quick-open menu for kitty (custom kitten)."""

from __future__ import annotations

import sys
import termios
import tty

from kitty.boss import Boss

_RESET = "\x1b[0m"
_BOLD = "\x1b[1m"
_DIM = "\x1b[2m"
_MAUVE = "\x1b[38;2;203;166;247m"
_GREEN = "\x1b[38;2;166;227;161m"
_RED = "\x1b[38;2;243;139;168m"
_TEXT = "\x1b[38;2;205;214;244m"
_SUBTEXT = "\x1b[38;2;166;173;200m"
_OVERLAY = "\x1b[38;2;108;112;134m"

ITEMS: list[tuple[str, str, str, tuple[str, str]]] = [
    (
        "a",
        "",
        "aliases.nu",
        ("/opt/homebrew/bin/nvim", "/Users/gjx/.config/nushell/aliases/alias.nu"),
    ),
    (
        "n",
        "",
        "config.nu",
        ("/opt/homebrew/bin/nvim", "/Users/gjx/.config/nushell/config.nu"),
    ),
    (
        "g",
        "\U000f02e6",
        "ghostty",
        ("/opt/homebrew/bin/nvim", "/Users/gjx/.config/ghostty"),
    ),
    (
        "t",
        "",
        "tmux.conf",
        ("/opt/homebrew/bin/nvim", "/Users/gjx/.config/tmux/tmux.conf"),
    ),
    (
        "p",
        "",
        "key.md",
        ("/opt/homebrew/bin/nvim", "/Users/gjx/OneDrive/Documents/diary/key.md"),
    ),
    ("d", "", "diary", ("/Users/gjx/.local/bin/diary", "edit")),
]

TARGETS = {key: target for key, _icon, _label, target in ITEMS}


def _read_key() -> str:
    fd = sys.stdin.fileno()
    saved = termios.tcgetattr(fd)
    try:
        tty.setraw(fd)
        return sys.stdin.read(1)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, saved)


def main(args: list[str]) -> str:
    print()
    print(f"   {_MAUVE}{_BOLD}  Dotfiles{_RESET}")
    print(f"   {_OVERLAY}{'─' * 24}{_RESET}")
    print()
    for key, icon, label, _target in ITEMS:
        print(
            f"     {_GREEN}{_BOLD}{key}{_RESET}   {_SUBTEXT}{icon}{_RESET}   {_TEXT}{label}{_RESET}"
        )
    print()
    print(f"     {_RED}{_BOLD}q{_RESET}   {_SUBTEXT}{_RESET}   {_DIM}quit{_RESET}")
    print()
    print(f"   {_MAUVE}{_BOLD}❯{_RESET} ", end="", flush=True)

    try:
        ch = _read_key()
    except (KeyboardInterrupt, EOFError, OSError):
        print()
        return ""

    print(ch if ch.isprintable() else "")

    if ch in ("\x03", "\x04", "\x1b", "\r", "\n", "q", "Q", "e", "E"):
        return ""
    return ch.lower()


def handle_result(
    args: list[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    choice = answer.strip().lower()
    if not choice:
        return

    target = TARGETS.get(choice)
    if target is None:
        return

    w = boss.window_id_map.get(target_window_id)
    if w is None:
        return

    boss.call_remote_control(
        w,
        (
            "launch",
            "--copy-env",
            "--type=overlay-main",
            "--cwd=current",
            *target,
        ),
    )
