---
name: gum-nushell
description: Use Gum from Nushell scripts to build interactive CLI/TUI flows. Trigger when writing, reviewing, or debugging Nu scripts that call `gum` commands such as choose, filter, confirm, input, write, file, table, spin, style, format, join, pager, log, or version-check, especially when handling Nushell pipelines, lists, multi-select output, exit codes, cancellations, or Gum style environment variables.
---

# Gum in Nushell

Use this skill when implementing shell interaction with `gum` in `.nu` scripts. Prefer small, composable Gum calls and keep Nushell's structured pipeline model explicit.

## Core Rules

- Prefix Gum calls with `^gum` when writing reusable Nu scripts. This avoids collisions with Nushell commands, aliases, or custom definitions.
- Treat Gum input and output as text. Convert Nushell lists/tables into delimited text before piping into Gum; parse Gum's text output back into Nu values after capture.
- Do not pipe structured Nushell lists directly into Gum. Nu will render a table, and Gum will receive box-drawing/table text instead of one option per line.
- Check `$env.LAST_EXIT_CODE` after commands where cancel/no/timeout matters. `confirm` communicates the user's answer primarily through the exit code.
- Use `--` before command arguments for `gum spin`, and before formatted content that could be parsed as flags.
- Prefer Gum environment variables for global/default styling and command flags for call-site-specific behavior.

Useful helpers:

```nu
def to-gum-lines []: list<any> -> string {
    $in | each { |item| $item | into string } | str join "\n"
}

def gum-success [] {
    $env.LAST_EXIT_CODE == 0
}

def gum-confirm [prompt: string] {
    ^gum confirm $prompt
    $env.LAST_EXIT_CODE == 0
}
```

## Text And Pipeline Boundaries

Capture simple output directly:

```nu
let name = (^gum input --placeholder "Project name")
if not (gum-success) { return }

print $"Creating ($name)"
```

Convert Nu lists to newline-delimited text before Gum:

```nu
let items = ["feat" "fix" "docs" "chore"]
let choice = ($items | to-gum-lines | ^gum choose --header "Commit type")
if not (gum-success) { return }
```

Convert multi-select output back into a Nu list:

```nu
let languages = (
    ["Rust" "Go" "TypeScript" "Python"]
    | to-gum-lines
    | ^gum choose --no-limit --header "Languages"
)
if not (gum-success) { return }

let language_list = ($languages | lines)
```

Use `--input-delimiter` and `--output-delimiter` when the item separator is not a newline:

```nu
let picked = (
    "red,green,blue"
    | ^gum choose --input-delimiter "," --output-delimiter ","
)
let picked_list = ($picked | split row ",")
```

## Confirmation And Exit Codes

Use `confirm` for branching. Do not expect a useful stdout value unless `--show-output` is explicitly requested.

```nu
if (^gum confirm "Delete generated files?"; $env.LAST_EXIT_CODE == 0) {
    print "Deleting..."
}
```

For repeated confirmation logic, wrap it:

```nu
def confirm-or-return [prompt: string] {
    ^gum confirm $prompt --affirmative "Yes" --negative "No"
    if $env.LAST_EXIT_CODE != 0 { return false }
    true
}

if not (confirm-or-return "Publish release?") { return }
```

Use `--default` and `--timeout` when non-interactive or slow-response sessions are possible:

```nu
^gum confirm "Continue?" --default --timeout 10s
if $env.LAST_EXIT_CODE != 0 { return }
```

## Choosing And Filtering

Use `choose` for short fixed lists:

```nu
let branch = (
    ["main" "develop" "release"]
    | to-gum-lines
    | ^gum choose --header "Target branch" --select-if-one
)
if not (gum-success) { return }
```

Use `filter` for searchable lists:

```nu
let file = (
    glob "**/*.nu"
    | each { |path| $path | into string }
    | str join "\n"
    | ^gum filter --placeholder "Search Nu files" --height 15
)
if not (gum-success) { return }
```

Use multi-select with `--no-limit` or `--limit N`, then parse with `lines`:

```nu
let selected = (
    ["lint" "test" "build" "release"]
    | to-gum-lines
    | ^gum filter --no-limit --header "Tasks"
)
if not (gum-success) { return }

for task in ($selected | lines) {
    print $"Run ($task)"
}
```

Use `--label-delimiter` when display labels should map to machine values:

```nu
let type = (
    ["Feature:feat" "Bug fix:fix" "Documentation:docs"]
    | to-gum-lines
    | ^gum choose --label-delimiter ":" --header "Commit type"
)
```

## Inputs

Use `input` for one-line values:

```nu
let token = (^gum input --password --placeholder "API token")
if not (gum-success) { return }
```

Use `write` for long-form text:

```nu
let body = (
    ^gum write
        --header "Release notes"
        --placeholder "Describe user-visible changes..."
        --show-line-numbers
)
if not (gum-success) { return }
```

Pass initial values via `--value` or stdin:

```nu
let edited = ("Initial text" | ^gum write --height 8)
```

## Files And Tables

Use `file` when the user should browse the filesystem:

```nu
let selected_file = (^gum file . --file --all --header "Select config")
if not (gum-success) { return }

open $selected_file
```

For directories:

```nu
let selected_dir = (^gum file . --directory --header "Select destination")
if not (gum-success) { return }
```

Use `table` for tabular choices. Convert Nu records to CSV first:

```nu
let rows = [
    [name path];
    ["Nushell config" "shells/nushell/config.nu"]
    ["Zsh config" "shells/zsh/.zshrc"]
]

let picked_path = (
    $rows
    | to csv
    | ^gum table --separator "," --return-column 2
)
if not (gum-success) { return }
```

Use `gum table --print` for non-interactive table rendering:

```nu
$rows | to csv | ^gum table --separator "," --print
```

## Output Formatting

Use `style` for boxes, colors, spacing, and alignment:

```nu
^gum style --foreground 212 --border-foreground 212 --border rounded --padding "1 2" --margin "1 0" "Build complete"
```

Use `format` for Markdown, code, templates, and emoji:

```nu
^gum format -- "# Release" "- Added Gum-driven prompts"
^gum format --type code --language nu "let choice = (^gum choose 'yes' 'no')"
^gum format --type emoji "Ship it :rocket:"
```

Use `join` for composing multi-line styled blocks:

```nu
let left = (^gum style --border rounded --padding "1 3" "Build")
let right = (^gum style --border rounded --padding "1 3" "Test")

^gum join --horizontal --align center $left $right
```

Use `pager` for long output:

```nu
open README.md --raw | ^gum pager --show-line-numbers --soft-wrap
```

## Spinners, Logs, And Version Checks

Use `spin` for long-running external commands. Place `--` before the command:

```nu
^gum spin --spinner dot --title "Running tests..." -- nu -c "go test ./..."
if not (gum-success) { return }
```

Use `--show-output`, `--show-stdout`, `--show-stderr`, or `--show-error` depending on how noisy the command should be:

```nu
^gum spin --title "Building..." --show-error -- nu -c "cargo build"
if not (gum-success) { return }
```

Use `log` for structured script messages:

```nu
^gum log --time rfc822 --level info --structured "Created file" path $selected_file
^gum log --level error "Build failed"
```

Gate newer Gum features with `version-check`:

```nu
^gum version-check ">=0.14.0"
if $env.LAST_EXIT_CODE != 0 {
    error make { msg: "gum >=0.14.0 is required" }
}
```

## Styling With Environment Variables

Most Gum flags map to `GUM_*` variables, such as `GUM_CHOOSE_HEIGHT`, `GUM_FILTER_PLACEHOLDER`, `GUM_INPUT_WIDTH`, and `GUM_SPIN_TITLE`. In Nushell, set them locally with `with-env`:

```nu
with-env {
    GUM_CHOOSE_CURSOR_FOREGROUND: "212"
    GUM_CHOOSE_SELECTED_FOREGROUND: "212"
    GUM_FILTER_MATCH_FOREGROUND: "212"
    GUM_CONFIRM_SELECTED_BACKGROUND: "212"
} {
    let choice = (["apply" "skip"] | to-gum-lines | ^gum choose)
    if not (gum-success) { return }
    print $choice
}
```

Set global defaults only in shell startup files or at the top of a dedicated script:

```nu
$env.GUM_SPIN_SPINNER = "dot"
$env.GUM_CONFIRM_AFFIRMATIVE = "Yes"
$env.GUM_CONFIRM_NEGATIVE = "No"
```

## Implementation Checklist

When writing a Nu script with Gum:

1. Verify `gum` exists or document the dependency.
2. Convert structured Nu values to text before Gum.
3. Capture stdout into variables only for commands that intentionally return values.
4. Check `$env.LAST_EXIT_CODE` after `confirm`, `choose`, `filter`, `input`, `write`, `file`, `table`, and `spin`.
5. Parse multi-line output with `lines`.
6. Keep style defaults in `GUM_*` variables when reused across many calls.
