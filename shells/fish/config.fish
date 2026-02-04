if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
end

# cli tools
zoxide init fish | source
starship init fish | source
tv init fish | source

# alias
alias cls="clear"
alias f="fish"
alias gg="gitui"
alias lg="lazygit"
alias vim="nvim"
alias cd="z"
alias cat="bat"
