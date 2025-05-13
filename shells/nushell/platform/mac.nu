$env.PATH = ($env.PATH 
    | split row (char esep) 
    | uniq 
    | prepend ["/opt/homebrew/bin", "/opt/homebrew/sbin", "/Applications/Docker.app/Contents/Resources/bin/", "/Users/gjx/.spicetify"]
)

alias kill = /bin/kill
