$env.EDITOR = 'nvim'
$env.MANPAGER = 'nvim +Man!'
$env.YAZI_CONFIG_HOME = '~/.config/yazi/'
# nushell vi mode
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
# fzf
$env.FZF_DEFAULT_OPTS = '
    --info right
    --prompt "󰥨 Search: "
    --pointer ">"
    --marker "󰄲"
    --border "rounded"
    --border-label=" 󱉭 FZF " 
    --border-label-pos center
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#b4befe,pointer:#f38ba8
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#b4befe,hl+:#f38ba8
    --color=selected-bg:#45475a
    --multi
    --layout reverse
'
$env.FZF_DEFAULT_COMMAND = 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
