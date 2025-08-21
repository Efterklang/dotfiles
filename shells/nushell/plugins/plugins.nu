mkdir ($nu.data-dir | path join "vendor/autoload")

tv init nu | save -f ($nu.data-dir | path join "vendor/autoload/tv.nu")

# Prompt Theme, use oh-my-posh or starship
oh-my-posh init nu --config ~/.config/ohmyposh/omp.json
# starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source ./zoxide.nu
