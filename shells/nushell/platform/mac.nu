source ../aliases/lla.nu

$env.PATH = (
  $env.PATH
  | split row (char esep)
  | uniq
  | prepend ["/Applications/Docker.app/Contents/Resources/bin/" "/Users/gjx/.spicetify" "/opt/homebrew/opt/openjdk/bin" "/opt/homebrew/bin" "/opt/homebrew/sbin"]
)

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

def brew-backup [] {
  let brewfile_path = "~/Projects/dotfiles/packages/homebrew/Brewfile"
  print $"==> 📦 Creating Homebrew backup to ($brewfile_path)..."
  # Ensure the directory exists
  mkdir ($brewfile_path | path dirname)
  # Generate the Brewfile with all installed packages and casks
  brew bundle dump --file ($brewfile_path | path expand) --force
  print $"==> ✅ Brewfile backup completed at ($brewfile_path)"
}

alias nu-kill = kill
alias kill = ^kill
alias clip = pbcopy
# homebrew
alias bi = brew install
alias bu = brew-update-all
alias rm_brewlock = rm -rf $"(brew --prefix)/var/homebrew/locks"
# python
alias python = python3
alias pip = pip3
