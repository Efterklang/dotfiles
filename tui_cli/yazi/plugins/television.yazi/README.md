# television.yazi

This is a customizable plugin that allows you to integrate [Television](https://alexpasmantier.github.io/television/) into [Yazi](https://yazi-rs.github.io/).

## Options

Support custom regex pattern parsing output with the `--pattern` option and a comma-separated list of capture variable names using the `--pattern-keys` option to accommodate various channel outputs. Also provide a `--cd` option for entering directories, or use the `--shell` option to execute a given script, and use the `--reveal` option to position the cursor on a file or directory. Except for `--cd`, which can be either a boolean option or a string option, all other options must be string options. `--cd`, `--shell`, and `--reveal` can be templates that reference variable names captured in `--pattern-keys`, and there are two convenient optional flag markers, `$` and `%` that can be used. `%` indicates expanding the filename to an absolute path, while `$` indicates using `ya.quote()` to make the name safe for use in the shell. However, `$` must come before `%` to imply their order requirement, like `quote(expand(key))`.

Additionally, there is a `--tv` string option to specify the path to the `tv` command (default to "tv"). Other options starting with `--tv-` (boolean or string) will be passed to the `tv` command without prefixes (`--tv-keybindings=...` -> `--keybindings=...`). Due to technical limitations, shorthands are not supported.

In practice, the `--shell` option provided by this plugin overlaps in functionality with the actions configuration of certain cables in Television v0.15.2. We respect your preference — use whichever you find more convenient. You can temporarily override the keybindings in your cable via options like `--tv-keybindings='enter="confirm_selection"'` (see blow).

## Quick Start

Just install it via:

```sh
ya pkg add moxuze/television
```

Add this to your `~/.config/yazi/keymap.toml`:

```toml
[[mgr.prepend_keymap]]
on = "e"
run = "plugin television -- text --text"
# Equivalent to:
#run = """plugin television -- \
#  text \
#  --tv-no-remote \
#  --tv-keybindings='enter="confirm_selection"' \
#  --pattern='^(.+):(%d+)$' \
#  --pattern-keys='file,line' \
#  --reveal='{{%file}}' \
#  --shell='"$EDITOR" {{$%file}}'"""
# Or:
#run = """plugin television -- \
#  text \
#  --tv-no-remote \
#  --tv-keybindings='enter="confirm_selection"' \
#  --pattern='^(.+):(%d+)$' \
#  --pattern-keys='file,line' \
#  --reveal='{{%file}}' \
#  --shell='hx {{$%file}}:{{line}}'"""
#run = """plugin television -- \
#  text \
#  --tv-no-remote \
#  --tv-keybindings='enter="confirm_selection"' \
#  --pattern='^(.+):(%d+)$' \
#  --pattern-keys='file,line' \
#  --reveal='{{%file}}' \
#  --shell='nvim {{$%file}} +:{{line}}'"""
desc = "Edit a file via television text"

[[mgr.prepend_keymap]]
on = "z"
run = "plugin television -- files"
desc = "Jump to a file via television files"

[[mgr.prepend_keymap]]
on = "Z"
run = """plugin television -- \
  zoxide \
  --tv-no-remote \
  --tv-keybindings='enter="confirm_selection"' \
  --cd"""
desc = "Jump to a file via television zoxide"
```

ENJOY IT.
