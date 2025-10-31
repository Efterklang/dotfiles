if status is-interactive
    # Commands to run in interactive sessions can go here
end

# cli tools
zoxide init fish | source
oh-my-posh init fish --config ~/.config/ohmyposh/omp.json | source
tv init fish | source

# alias
alias cls="clear"
alias f="fish"
alias gg="gitui"
alias lg="lazygit"
alias vim="nvim"
alias cd="z"
alias cat="bat"
