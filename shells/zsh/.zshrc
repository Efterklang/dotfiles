# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Autocomplete
autoload -U compinit
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/compinit
_comp_options+=(globdots)

# Load aliases
[ -f "$XDG_CONFIG_HOME/zsh/aliasrc" ] && source "$XDG_CONFIG_HOME/zsh/aliasrc"

# Completion

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'

# === Plugins ===
source <(carapace _carapace)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
eval "$(tv init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# === Bindkey ===
bindkey -e
