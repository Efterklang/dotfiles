source ../aliases/lla.nu
source ../aliases/brew.nu

$env.PATH = (
  $env.PATH
  | split row (char esep)
  | uniq
  | prepend ["/Applications/Docker.app/Contents/Resources/bin/" "/Users/gjx/.spicetify" "/opt/homebrew/opt/openjdk/bin" "/opt/homebrew/bin" "/opt/homebrew/sbin"]
)

alias nu-kill = kill
alias kill = ^kill
# python
alias python = python3
alias pip = pip3
