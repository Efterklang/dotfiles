## Clone the repository

Run `git clone --depth=1 https://github.com/Efterklang/dotfiles && cd dotfiles` to clone the repository and enter the directory.

## Install packages

Install the necessary packages, depending on your package manager

| Pkg Manager | Export                                                                      | Import                                                                     | Description                                            |
| ----------- | --------------------------------------------------------------------------- | -------------------------------------------------------------------------- | ------------------------------------------------------ |
| Homebrew    | `brew bundle dump --describe --force --file="./packages/homebrew/Brewfile"` | `brew bundle --file="./packages/homebrew/Brewfile"`                        | Homebrew package manager for macOS and Linux.          |
| Pacman      | `pacman -Qqe > ./packages/pacman/packages.txt`                              | `pacman -S --needed - < ./packages/pacman/packages.txt`                    | Pacman package manager for Arch Linux and derivatives. |
| Scoop       | `scoop export > ./packages/scoop/scoop-packages.json`                       | `scoop import "./packages/scoop/scoop-packages.json"`                      | Scoop package manager for Windows.                     |
| Apt-get     | `apt-mark showmanual > ./packages/apt-get/apt-packages.txt`                 | `cat ./packages/apt-get/apt-packages.txt \| xargs sudo apt-get install -y` | Apt package manager for Debian-based systems.          |

### Recommended packages

#### Terminal emulators

- **Ghostty**: A fast, feature-rich, and cross-platform terminal emulator that uses platform-native UI and GPU acceleration.
- **[Kitty](https://sw.kovidgoyal.net/kitty/)**: A fast, feature-rich, and highly customizable terminal emulator
- **WezTerm**: Cross-platform terminal emulator
- **Windows Terminal**: For Windows systems

#### CLI Tools

| Tools                                                   | Description                                                                                  |
| ------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| [bat](https://github.com/sharkdp/bat)                   | A `cat(1)` clone with wings.                                                                 |
| [delta](https://dandavison.github.io/delta/)            | A syntax-highlighting pager for git, diff, and grep output                                   |
| [eza](https://github.com/eza-community/eza)             | A modern replacement for `ls`.                                                               |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | A maintained, feature-rich and performance oriented, neofetch like system information tool.  |
| [fd](https://github.com/sharkdp/fd)                     | A simple, fast and user-friendly alternative to 'find'                                       |
| [lla](https://github.com/chaqchase/lla)                 | blazing fast `ls` replacement with superpowers                                               |
| [ripgrep](https://github.com/BurntSushi/ripgrep)        | ripgrep recursively searches directories for a regex pattern while respecting your gitignore |
| [tailspin](https://github.com/bensadeh/tailspin)        | 🌀 A log file highlighter                                                                     |
| [zoxide](https://github.com/ajeetdsouza/zoxide)         | A smarter cd command. Supports all major shells.                                             |

#### TUI Tools

| Tool                                                   | Description                                                               |
| ------------------------------------------------------ | ------------------------------------------------------------------------- |
| [btop4win](https://github.com/aristocratos/btop4win)   | btop++ for windows                                                        |
| [fzf](https://github.com/junegunn/fzf)                 | 🌸 A command-line fuzzy finder                                             |
| [gitui](https://github.com/extrawurst/gitui)           | Blazing fast terminal-ui for git written in rust.                         |
| [gping](https://github.com/orf/gping)                  | Ping, but with a graph                                                    |
| [helix](https://github.com/helix-editor/helix)         | A post-modern modal text editor.                                          |
| [lazygit](https://github.com/jesseduffield/lazygit)    | simple terminal UI for git commands                                       |
| [lazyvim](https://github.com/LazyVim/LazyVim)          | Neovim config for the lazy                                                |
| [procs](https://github.com/dalance/procs)              | A modern replacement for ps written in Rust.                              |
| [scooter](https://github.com/thomasschafer/scooter)    | Interactive find-and-replace in the terminal Resources                    |
| [television](https://github.com/alexhallam/television) | A cross-platform, fast and extensible general purpose fuzzy finder 📺      |
| [tig](https://github.com/jonas/tig)                    | Text-mode interface for git.                                              |
| [yazi](https://github.com/sxyazi/yazi)                 | 💥 Blazing fast terminal file manager written in Rust, based on async I/O. |

#### Shells

- Prompt Theme
  - [oh-my-posh](https://ohmyposh.dev): A prompt theme engine for any shell.
  - [starship](https://starship.rs): The minimal, blazing-fast, and infinitely customizable prompt for any shell.
- Completion:
  - [Carapace](https://carapace.sh/): A multi-shell completion library and binary.
  - [Inshellisense](https://github.com/microsoft/inshellisense): IDE style command line auto complete
- Shells
  - Fish
  - Nushell
  - Powershell 7
  - Zsh

#### Other applications

| Application                                                       | Description                                  |
| ----------------------------------------------------------------- | -------------------------------------------- |
| [AutoHotkey](https://www.autohotkey.com/)                         | Windows automation scripts                   |
| [Chrome](https://www.google.com/chrome/)                          | Browser extensions and settings              |
| [Clash Verge](https://github.com/clash-verge-rev/clash-verge-rev) | A Clash GUI based on Tauri                   |
| [Karabiner-Elements](https://karabiner-elements.pqrs.org/)        | Keyboard customizer for macOS                |
| [SketchyBar](https://github.com/FelixKratz/SketchyBar)            | A flexible macOS status bar                  |
| [VSCode](https://code.visualstudio.com/)                          | Code editor settings and snippets            |
| [Yasb](https://github.com/denBot/yasb)                            | A highly customizable status bar for Windows |


### Additional Manual Installations

**MacOS**

| Package    | Installation Command                                        |
| ---------- | ----------------------------------------------------------- |
| rclone[^1] | `sudo -v ; curl https://rclone.org/install.sh \| sudo bash` |


## Set up your environment(Optional)

Run `./bin/envs`, this will set-up `XDG_` and other environment variables.

Some app settings may depend on these environment variables to locate configuration files.

For example, setting `XDG_CONFIG_HOME` to `~/.config` will make applications look for their config files in `~/.config` instead of the default locations.

## Create symlinks

Run `install.py`, this will create symlinks from the dotfiles to your home directory according to `install.conf.yaml`

> [!WARNING]
>
> Back up the folder before installation, or run `./install.py --dry-run` (uses dotbot under the hood) to preview changes before applying.

[^1]: `rclone mount` is not supported on MacOS when rclone is installed via Homebrew, `rclone mount` is not supported on macOS when installed via Homebrew, so manual installation is recommended for full functionality.
