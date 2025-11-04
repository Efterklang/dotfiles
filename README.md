<h1 align="center">
  <img alt="image" src="https://github.com/user-attachments/assets/b5f6fdaa-37c2-4bb4-9cc4-d5df0086b82f" width="60%"/>
  <br>
  Dotfiles
  <br>
  <img src="https://img.shields.io/github/commit-activity/y/Efterklang/dotfiles?style=for-the-badge&labelColor=%23222436&color=%235771AA" alt="Commit Frequency">
  <img src="https://img.shields.io/github/license/Efterklang/dotfiles?style=for-the-badge&labelColor=%23222436&color=%235771AA" alt="License">
</h1>

For installation instructions, refer to [docs/INSTALL.md](docs/INSTALL.md)

- [VSCode](#vscode)
- [Music Player](#music-player)
- [Bar](#bar)
- [Browser](#browser)
- [Terminal](#terminal)
  - [Shell](#shell)
  - [Terminal Multiplexer](#terminal-multiplexer)
  - [Fuzzy finders](#fuzzy-finders)
  - [TUI/CLI Tools](#tuicli-tools)

## VSCode

- Theme: Catppuccin Mocha
- Icon: Catppuccin Noctis Icons
- Custom CSS: check [this file](https://github.com/Efterklang/dotfiles/blob/main/application/vscode/custom.css)
- Settings.json: check [this file](https://github.com/Efterklang/dotfiles/blob/main/application/vscode/settings.json)

| File/Directory     | Description                                  |
| ------------------ | -------------------------------------------- |
| `custom.css`       | Custom CSS styling for VSCode                |
| `keybindings.json` | Keyboard shortcuts configuration             |
| `settings.json`    | VSCode global settings                       |
| `snippets`         | Code snippets (markdown, python, java, etc.) |

![1761896833616](assets/vscode.png)

## Music Player

|            Tauon            | mpd + rmpc + cava        |
| :-------------------------: | ------------------------ |
| ![tauon](assets/tauon.webp) | ![mpd](assets/rmpc.webp) |

## Bar

- Windows: Yasb, other options: glazewm, zebar
- MacOS: SketchyBar, read [config](https://github.com/Efterklang/sketchybar)

| Yasb(Windows)             | SketchyBar(Mac)                       |
| ------------------------- | ------------------------------------- |
| ![yasb](assets/yasb.webp) | ![sketchybar](assets/sketchybar.webp) |

## Browser

Extension List

- [**Stylus**](https://add0n.com/stylus.html)
  - User styles manager for customizing website appearance
- [**Vimium C**](https://github.com/gdh1995/vimium-c)
  - Keyboard-based navigation and tab operations
  - Features advanced omnibar functionality

|                Stylus                |             Vimium C              |
| :----------------------------------: | :-------------------------------: |
| ![Stylus Github](assets/stylus.webp) | ![vimium-c](assets/vimium_c.webp) |

## Terminal

### Shell

I use nushell as my default shell. It has aesthetic and powerful features.

![nushell](assets/nushell.png)

### Terminal Multiplexer

|            Zellij             |           Tmux            |
| :---------------------------: | :-----------------------: |
| ![zellij](assets/zellij.webp) | ![Tmux](assets/tmux.webp) |

### Fuzzy finders

|           Fzf           |              Television               |
| :---------------------: | :-----------------------------------: |
| ![Fzf](assets/fzf.webp) | ![Television](assets/television.webp) |

### TUI/CLI Tools


| Command | Replacement |
| ------- | ----------- |
| diff    | delta       |
| cd      | zoxide      |
| ls      | eza, lla    |
| cat     | bat         |
| grep    | ripgrep     |
| vim     | nvim        |
| git     | lazygit     |
| top     | btop        |
| ps      | procs       |
| ranger  | yazi        |


|            Delta             |             Zoxide              |
| :--------------------------: | :-----------------------------: |
| ![Delta](assets/delta.webp)  |  ![Zoxide](assets/zoxide.webp)  |
|          eza & lla           |               Bat               |
| ![eza](assets/eza_lla.webp)  |     ![Bat](assets/bat.webp)     |
|            NeoVim            |             LazyGit             |
| ![LazyVim](assets/nvim.webp) | ![LazyGit](assets/lazygit.webp) |
|             btop             |              Procs              |
|  ![btop](assets/btop.webp)   |   ![Procs](assets/procs.webp)   |
|             Yazi             |             Scooter             |
|  ![Yazi](assets/yazi.webp)   | ![Scooter](assets/scooter.webp) |
