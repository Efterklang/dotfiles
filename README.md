1. [Usage](#usage)
2. [📦Packages](#packages)
3. [🔣Fonts](#fonts)
4. [🐚Shells](#shells)
   1. [Nushell](#nushell)
   2. [Oh My Posh](#oh-my-posh)
   3. [Carapace](#carapace)


## Usage

```shell
$ git clone https://github.com/Efterklang/config.git --depth 1 ~/.dotfiles 
$ cd ~/.dotfiles
# For Windows，Run This👇
$ pwsh -File ./install.ps1
# For Linux，Run This👇
$ ./install.sh
```

## 📦Packages

```shell
$ mkdir D:\\envir_vars\\scoop
$ cd ~/.dotfiles/misc/scoop
$ scoop import ./scoop-packages.json
```

## 🔣Fonts

- Maple Mono NF CN
- Maple Hand
- Jetbrains Mono
- Monaspace Radon

## 💻Terminal

- Windows Terminal
- Wezterm

### Workflow

- Completion
    - [Carapace](https://carapace.sh/): A multi-shell completion library and binary.
- CLI Tools
    - [fd](https://github.com/sharkdp/fd): A simple, fast and user-friendly alternative to 'find'
    - [fzf>=0.59.0](https://github.com/junegunn/fzf): 🌸 A command-line fuzzy finder
    - [bat](https://github.com/sharkdp/bat): A cat(1) clone with wings.
    - [zoxide](https://github.com/ajeetdsouza/zoxide): A smarter cd command. Supports all major shells.
    - [delta](https://dandavison.github.io/delta/installation.html): A syntax-highlighting pager for git, diff, and grep output
    - [tailspin](https://github.com/bensadeh/tailspin): 🌀 A log file highlighter
- TUI Tools
    - [helix](https://github.com/helix-eiditor/helix): A post-modern modal text editor.
    - [lazygit](https://github.com/jesseduffield/lazygit): simple terminal UI for git commands
    - [yazi](https://github.com/sxyazi/yazi): 💥 Blazing fast terminal file manager written in Rust, based on async I/O.


## 🐚Shell

- Shell Prompt Theme
    - [oh-my-posh](https://ohmyposh.dev/): A prompt theme engine for any shell.
- Shells
    - Nushell
    - Fish
    - Powershell7

### Nushell

Check `./shells/nushell` for more infomation

### Oh My Posh

**Installation**

- Windows: `winget install JanDeDobbeleer.OhMyPosh -s winget`
- Linux: `curl -s https://ohmyposh.dev/install.sh | bash -s`

**Configuration**

- Nushell: `oh-my-posh init nu --config ~/.config/ohmyposh/omp.json --print | save ./shells/nushell/plugins/omp.nu --force`
- Fish: `oh-my-posh init fish --config ~/.config/ohmyposh/omp.json | source`
- Bash: `oh-my-posh init fish --config ~/.config/ohmyposh/omp.json | source`

### Carapace

**Installation**

- Windows: `scoop install extras/carapace-bin`
- Linux: 
    - Arch: `yay -S carapace-bin`
    - Others: check [carapace-sh.github.io/carapace-bin/install.html](https://carapace-sh.github.io/carapace-bin/install.html)
