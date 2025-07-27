mkdir ($nu.data-dir | path join "vendor/autoload")

tv init nu | save -f ($nu.data-dir | path join "vendor/autoload/tv.nu")
oh-my-posh init nu --config ~/.config/ohmyposh/omp.json

source ./zoxide.nu