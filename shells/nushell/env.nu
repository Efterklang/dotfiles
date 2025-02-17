$env.EDITOR = 'nvim'
$env.YAZI_CONFIG_HOME = '~/.config/yazi/'
# fzf
$env.FZF_DEFAULT_OPTS = '
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
    --color=selected-bg:#45475a
    --multi
    --layout reverse
    
'
$env.FZF_DEFAULT_COMMAND = 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
