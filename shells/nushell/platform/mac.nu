$env.PATH = ($env.PATH 
    | split row (char esep) 
    | uniq 
    | prepend ["/opt/homebrew/bin", "/opt/homebrew/sbin", "/Applications/Docker.app/Contents/Resources/bin/", "/Users/gjx/.spicetify"]
)
$env.XDG_CONFIG_HOME = "/Users/gjx/.config"

alias rm = ^rm
alias open = ^open
alias kill = ^kill
