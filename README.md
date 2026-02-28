<h1 align="center">
  <img alt="dotfiles" src="https://github.com/user-attachments/assets/b5f6fdaa-37c2-4bb4-9cc4-d5df0086b82f" width="60%"/>
  <br>
  Dotfiles
  <br>
  <img src="https://img.shields.io/github/commit-activity/y/Efterklang/dotfiles?style=for-the-badge&labelColor=%23222436&color=%235771AA" alt="Commit Frequency">
  <img src="https://img.shields.io/github/license/Efterklang/dotfiles?style=for-the-badge&labelColor=%23222436&color=%235771AA" alt="License">
</h1>

<p align="center">
  Personal development environment configurations for Windows, macOS, and Linux
</p>

---

## Table of Contents

- [Installation](#installation)
- [VSCode](#vscode)
- [Music Player](#music-player)
- [Status Bar](#status-bar)
- [Browser](#browser)
- [Terminal](#terminal)
  - [Shell](#shell)
  - [Terminal Multiplexer](#terminal-multiplexer)
  - [Fuzzy Finders](#fuzzy-finders)
  - [TUI/CLI Tools](#tuicli-tools)

---

## Installation

For detailed installation instructions, please refer to [docs/INSTALL.md](docs/INSTALL.md).

---

## VSCode

| Setting | Value |
|---------|-------|
| Theme | Catppuccin Mocha |
| Icon | Catppuccin Noctis Icons |

| File/Directory | Description |
|----------------|-------------|
| `custom.css` | Custom CSS styling for VSCode |
| `keybindings.json` | Keyboard shortcuts configuration |
| `settings.json` | VSCode global settings |
| `snippets/` | Code snippets (markdown, python, java, etc.) |

![VSCode](assets/vscode.png)

---

## Music Player

| TauonMusicBox | mpd + rmpc + cava |
|:-------------:|:----------------:|
| ![tauon](assets/tauon.webp) | ![mpd](assets/rmpc.webp) |

---

## Status Bar

| Platform | Application |
|----------|-------------|
| Windows | Yasb |
| macOS | SketchyBar |

| Yasb (Windows) | SketchyBar (macOS) |
|:--------------:|:------------------:|
| ![yasb](assets/yasb.webp) | ![sketchybar](assets/sketchybar.webp) |

> **Note:** For Windows, alternative options include GlazeWM and Zebar. For macOS configuration details, see [SketchyBar config](https://github.com/Efterklang/sketchybar).

---

## Browser

### Extensions

| Extension | Description |
|-----------|-------------|
| [Stylus](https://add0n.com/stylus.html) | User styles manager for customizing website appearance |
| [Vimium C](https://github.com/gdh1995/vimium-c) | Keyboard-based navigation and tab operations with advanced omnibar functionality |

| Stylus | Vimium C |
|:------:|:---------:|
| ![stylus](assets/stylus.webp) | ![vimium-c](assets/vimium_c.webp) |

---

## Terminal

### Shell

Nushell serves as the primary shell, providing a modern and powerful command-line experience with excellent aesthetics.

![Nushell](assets/nushell.png)

### Terminal Multiplexer

| Zellij | Tmux |
|:------:|:----:|
| ![zellij](assets/zellij.webp) | ![tmux](assets/tmux.webp) |

### Fuzzy Finders

| fzf | Television |
|:---:|:----------:|
| ![fzf](assets/fzf.webp) | ![television](assets/television.webp) |

### TUI/CLI Tools

#### Command Replacements

| Original Command | Replacement |
|-----------------|-------------|
| `diff` | delta |
| `cd` | zoxide |
| `ls` | eza, lla |
| `cat` | bat |
| `grep` | ripgrep |
| `vim` | nvim |
| `git` | lazygit |
| `top` | btop |
| `ps` | procs |
| `ranger` | yazi |

#### Tool Screenshots

| Delta | Zoxide |
|:-----:|:------:|
| ![delta](assets/delta.webp) | ![zoxide](assets/zoxide.webp) |

| eza & lla | bat |
|:---------:|:---:|
| ![eza](assets/eza_lla.webp) | ![bat](assets/bat.webp) |

| NeoVim | LazyGit |
|:------:|:-------:|
| ![nvim](assets/nvim.webp) | ![lazygit](assets/lazygit.webp) |

| btop | Procs |
|:----:|:-----:|
| ![btop](assets/btop.webp) | ![procs](assets/procs.webp) |

| Yazi | Scooter |
|:----:|:-------:|
| ![yazi](assets/yazi.webp) | ![scooter](assets/scooter.webp) |

---

## License

This project is licensed under the MIT License.
