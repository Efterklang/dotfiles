source ../aliases/lla.nu

$env.PATH = ($env.PATH
    | split row (char esep)
    | uniq
    | prepend ["/opt/homebrew/bin", "/opt/homebrew/sbin", "/Applications/Docker.app/Contents/Resources/bin/", "/Users/gjx/.spicetify", "/opt/homebrew/opt/openjdk/bin", "~/.local/share/cargo/bin"]
)
$env.HOMEBREW_BAT = 1
$env.HOMEBREW_NO_AUTO_UPDATE = true

def brew-update-all [] {
    print "==> 🚀 Starting Homebrew update process..."

    # Step 1: Update Homebrew recipes
    print "==> 1/4: Running brew update..."
    brew update

    # Step 2: Upgrade all installed packages
    print "==> 2/4: Running brew upgrade..."
    brew upgrade

    # Step 3: Upgrade all cask applications
    # The `brew cu` command is from an external tap `buo/cask-upgrade`
    print "==> 3/4: Running brew cu -ay..."
    brew cu -ay

    # Step 4: Clean up old versions
    print "==> 4/4: Running brew cleanup..."
    brew cleanup

    print "==> ✅ Homebrew update process finished!"
}

alias rm = ^rm
alias kill = ^kill
alias clip = pbcopy
alias python = python3
alias bi = brew install
alias bu = brew-update-all
