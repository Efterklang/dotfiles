# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles managed with [Dotbot](https://github.com/anishathalye/dotbot). Configurations are organized by tool category and symlinked into place via `install.conf.yaml`.

## Installation

```sh
# Run the installer (syncs git submodules then invokes Dotbot)
python3 install.py

# Pass Dotbot flags directly (e.g., preview without applying)
python3 install.py --dry-run

# Run only specific directive types
python3 install.py --only link
python3 install.py --except shell
```

After installation, `bat cache --build` runs automatically (defined as a shell directive in `install.conf.yaml`).

## Repository Structure

```
dotfiles/
├── install.py            # Installer: syncs submodules, invokes Dotbot
├── install.conf.yaml     # Dotbot directives: clean, link, shell
├── .dotbot/              # Dotbot framework (git submodule)
├── application/          # GUI app configs (ghostty, kitty, wezterm, vscode, karabiner, sketchybar, …)
├── shells/               # Shell configs (nushell, zsh, fish, pwsh7)
├── tui_cli/              # Terminal tool configs (nvim, helix, git, lazygit, yazi, bat, btop, …)
├── packages/             # Package lists (Brewfile, scoop, apt-get, cargo)
└── misc/                 # Miscellaneous (.wslconfig, env.xdg.plist, .markdownlint-cli2.yaml)
```

## How Dotbot Symlinks Work

`install.conf.yaml` maps repo paths → filesystem destinations. All configs go under `~/.config/` following XDG conventions. Platform-specific links use `if` guards:

- macOS: `"[ \`uname\` = Darwin ]"`
- Windows: `ver` (cmd built-in)

Adding a new tool's config: create the directory under the appropriate category (`tui_cli/`, `application/`, etc.), then add a `link` entry in `install.conf.yaml`.

## Key Tool Configurations

- **Shell**: Nushell is the default shell (`shells/nushell/` → `~/.config/nushell`)
- **Editor**: Neovim (`tui_cli/nvim/`) shares snippets with VSCode (`application/vscode/snippets`)
- **Git**: Config at `tui_cli/git/` → `~/.config/git`; UI via lazygit (`tui_cli/lazygit/`)
- **Status bars**: SketchyBar (macOS, external submodule at `application/sketchybar`), Yasb (Windows)
- **Terminal**: Ghostty (primary, with shader submodule), Kitty, WezTerm

## Git Submodules

Three submodules tracked in `.gitmodules`:
- `.dotbot` — Dotbot framework
- `application/ghostty/shaders` — Ghostty shader collection
- `application/sketchybar` — SketchyBar config (separate repo)

After cloning, run `git submodule update --init --recursive` before `install.py`.
