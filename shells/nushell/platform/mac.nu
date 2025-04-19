$env.PATH = ($env.PATH 
    | split row (char esep) 
    | uniq 
    | prepend ["/opt/homebrew/bin", "/opt/homebrew/sbin"]
)
