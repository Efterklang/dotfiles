$env.PATH = ($env.PATH 
    | split row (char esep) 
    | uniq 
    | prepend ["/opt/homebrew/bin", "/opt/homebrew/sbin", "/Applications/Docker.app/Contents/Resources/bin/", "/Users/gjx/.spicetify", "~/.local/bin", "/Users/gjx/.cargo/bin", "/Users/gjx/.local/share/nu/bin", "/Users/gjx/.local/share/nu/plugins", "/Users/gjx/.local/share/nu/completions", "/Users/gjx/.local/bin", "/Users/gjx/dotfiles/bin"]
)
$env.XDG_CONFIG_HOME = "/Users/gjx/.config"

alias rm = ^rm
alias open = ^open
alias kill = ^kill
alias clip = pbcopy
alias python = python3

