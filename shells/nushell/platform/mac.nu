$env.PATH = ($env.PATH 
    | split row (char esep) 
    | uniq 
    | prepend ["/opt/homebrew/bin", "/opt/homebrew/sbin", "/Applications/Docker.app/Contents/Resources/bin/", "/Users/gjx/.spicetify", "~/.local/bin", "/Users/gjx/dotfiles/bin", "/opt/homebrew/opt/openjdk/bin", "~/.local/share/cargo/bin"]
)
$env.XDG_CONFIG_HOME = "/Users/gjx/.config"

alias rm = ^rm
alias open = ^open
alias kill = ^kill
alias clip = pbcopy
alias python = python3
alias bi = brew install
alias bu = brew upgrade

