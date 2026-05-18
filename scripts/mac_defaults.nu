#! /usr/bin/env nu

def _set-finder-defaults [] {
  print "Setting Finder default to home directory"
  try {
    defaults write com.apple.finder NewWindowTarget -string "PfHm"
    killall Finder
    print "Finder default set"
  } catch {|err|
    print $"Failed to set Finder default: ($err.msg)"
  }
}

def _set-dock-defaults [] {
  print "Setting Dock autohide delay to 0"
  try {
    defaults write http://com.apple.dock autohide-delay -float 0
    defaults write http://com.apple.dock autohide-time-modifier -float 0.2
    killall Dock
    print "Dock default set"
  } catch {|err|
    print $"Failed to set Dock default: ($err.msg)"
  }
}

def _set-default-apps [] {
  if (which duti | length) == 0 {
    print "duti not found, installing via Homebrew..."
    if (which brew | length) == 0 {
      print "Homebrew is not installed. Cannot install duti."
      return 1
    }
    brew install duti
  } else {
    print "duti already installed"
  }

  print "Setting default applications"
  duti -s dev.zed.Zed css all
  duti -s com.microsoft.edgemac.dev pdf all
  print "Default applications set"
}

def main [] {
  print "Setting macOS defaults..."

  _set-finder-defaults
  _set-dock-defaults
  _set-default-apps

  print "macOS defaults configured"
}
