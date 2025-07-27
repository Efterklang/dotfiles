# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

# Autocomplete
autoload -U compinit
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/compinit
_comp_options+=(globdots)

# Load aliases
[ -f "$XDG_CONFIG_HOME/zsh/aliasrc" ] && source "$XDG_CONFIG_HOME/zsh/aliasrc"

# Completion Styles
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:hist-complete:*' completer _history
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'
zstyle ':zim:completion' dumpfile ${XDG_CACHE_HOME}/zsh/dumpfile
zstyle ':completion::complete:*' cache-path ${XDG_CACHE_HOME}/zsh/zcompcache

# === Plugins ===
source <(carapace _carapace)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# === Bindkey ===
bindkey '^ ' autosuggest-accept
bindkey -e

# Prompt theme
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/catppuccin.omp.json)"
