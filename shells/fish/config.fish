if status is-interactive
    # Commands to run in interactive sessions can go here
end

# envirment variables
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx VISUAL helix  # or nvim
# cli tools
zoxide init fish | source
oh-my-posh init fish --config ~/.config/ohmyposh/omp.json | source

# alias
alias cls="clear"
alias f="fish"
alias gg="gitui"
alias lg="lazygit"
alias vim="nvim"
alias cd="z"
alias cat="bat"