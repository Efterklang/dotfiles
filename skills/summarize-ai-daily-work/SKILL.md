---
name: summarize-ai-daily-work
description: Summarize today's AI assistant/Codex work from local session logs and record it in the diary. Use when the user asks in Chinese or English to summarize AI/Codex work for today, asks what work they asked the assistant to do today, asks to write today's AI work into the diary, or mentions summarizing today's sessions under a project directory.
---

# Summarize AI Daily Work

## Workflow

1. Determine the target date.
   - Default to today in the local timezone.
   - If the user gives a date, use that date.

2. Resolve the diary file.
   - In this diary repo, first try `just today`.
   - If `just today` fails, fall back to `YYYY/M/YYYY-MM-DD.md`, then `YYYY/M/YYYY-MM-DD`.
   - Read the existing diary before editing, and update an existing AI/Codex work record instead of appending a duplicate contradictory block.

3. Determine the session scope.
   - If the user names one or more project directories, filter Codex sessions by `turn_context.payload.cwd` under those paths.
   - If no directory is provided, summarize all Codex sessions for the date, but do not count a trivial diary-only summary request as substantive work unless it is the only activity.

4. Extract session evidence with the bundled script:

   ```bash
   python3 ./.agents/skills/summarize-ai-daily-work/scripts/extract_codex_daily_work.py --date YYYY-MM-DD
   ```

   Add one `--cwd-prefix /absolute/project/path` per requested project directory.

5. Synthesize the diary entry from evidence.
   - Prefer user requests and final assistant summaries over intermediate progress messages.
   - Group repeated turns from the same task into one bullet.
   - Mark interrupted or unfinished work explicitly when the log shows `<turn_aborted>` or no final completion.
   - Do not overclaim: say "分析/尝试/中途被打断" when completion is uncertain.
   - Avoid leaking secrets, subscription URLs, tokens, raw proxy node details, or private config contents.

6. Write the diary entry.
   - Use a timestamp from `date +%H:%M`.
   - Recommended heading text: `Codex 工作记录`.
   - Include the evidence source briefly, for example `从 ~/.codex/sessions/YYYY/MM/DD/ 筛出 N 个会话`.
   - Keep the summary concise and useful for future recall.

7. Verify.
   - Read the edited diary tail.
   - In the final response, mention the diary file path and the main categories recorded.

## Script Notes

The script reads JSONL files from `~/.codex/sessions/YYYY/MM/DD/`, extracts non-boilerplate user requests, assistant messages, cwd values, and interruption markers, then prints a Markdown-style evidence report. It is an extraction aid, not the final diary prose; review its output before writing.
