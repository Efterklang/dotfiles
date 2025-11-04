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
zstyle ':completion:*' menu select=2  # 至少2项时显示菜单
zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# IDE风格补全设置
zstyle ':completion:*' use-cache on                  # 使用缓存加速补全
zstyle ':completion:*' group-name ''                 # 启用分组
zstyle ':completion:*' verbose yes                   # 显示详细信息
zstyle ':completion:*:descriptions' format $'\e[01;34m%d\e[0m'  # 描述信息样式
zstyle ':completion:*:messages' format $'\e[01;35m%d\e[0m'       # 消息样式
zstyle ':completion:*:warnings' format $'\e[01;31mNo matches for: %d\e[0m'  # 警告样式
zstyle ':completion:*:errors' format $'\e[01;31mError: %d\e[0m'   # 错误样式

# 高亮匹配部分
zstyle ':completion:*' match-original both
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# 补全排序和分组
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' file-sort name

# Git特定配置保持不变
zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'

# === Plugins ===
source <(carapace _carapace)
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
eval "$(tv init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

# === Bindkey ===
bindkey -e
