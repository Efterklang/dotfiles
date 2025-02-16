1. [Usage](#usage)
2. [Packages](#packages)
3. [🐚Shells](#shells)
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

## Packages

```shell
$ mkdir D:\\envir_vars\\scoop
$ cd ~/.dotfiles/misc/scoop
$ scoop import ./scoop-packages.json
```

## 🐚Shells

### Nushell

针对Nushell个人有一套Workflow，推荐下载以下依赖。对于Windows平台，以下依赖均在`scoop-package.json`中，直接import即可。

- Shell Prompt Theme
    - [oh-my-posh](https://ohmyposh.dev/)
- Completion
    - [Carapace](https://carapace.sh/)
- CLI Tools
    - [fd](https://github.com/sharkdp/fd#installation)
    - [fzf>=0.59.0](https://github.com/junegunn/fzf)
    - [bat](https://github.com/sharkdp/bat)
    - [zoxide](https://github.com/ajeetdsouza/zoxide)
- TUI Tools
    - [helix](https://github.com/helix-editor/helix)
    - [lazygit](https://github.com/jesseduffield/lazygit)
    - [yazi](https://github.com/sxyazi/yazi)

### Oh My Posh

**Installation**

- Windows: `winget install JanDeDobbeleer.OhMyPosh -s winget`
- Linux: `curl -s https://ohmyposh.dev/install.sh | bash -s`

**Configuration**

- Nushell: `oh-my-posh init nu --config ~/.config/ohmyposh/omp.json --print | save ./shells/nushell/plugins/omp.nu --force`
- 针对Nushell个人有一套Workflow To be continued...

### Carapace

**Installation**

- Windows: `scoop install extras/carapace-bin`
- Linux: 
    - Arch: `yay -S carapace-bin`
    - Others: check [carapace-sh.github.io/carapace-bin/install.html](https://carapace-sh.github.io/carapace-bin/install.html)
