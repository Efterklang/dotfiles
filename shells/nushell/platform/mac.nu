$env.PATH = ($env.PATH
    | split row (char esep)
    | uniq
    | prepend ["/opt/homebrew/bin", "/opt/homebrew/sbin", "/Applications/Docker.app/Contents/Resources/bin/", "/Users/gjx/.spicetify", "/opt/homebrew/opt/openjdk/bin", "~/.local/share/cargo/bin"]
)
$env.HOMEBREW_BAT = 1
$env.HOMEBREW_NO_AUTO_UPDATE = true

alias rm = ^rm
alias open = ^open
alias kill = ^kill
alias clip = pbcopy
alias python = python3
alias bi = brew install
alias bu = brew upgrade
