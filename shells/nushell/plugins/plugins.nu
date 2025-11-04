mkdir ($nu.data-dir | path join "vendor/autoload")

# Prompt Theme, use oh-my-posh or starship
let ohmyposh_autoload = $nu.data-dir | path join "vendor/autoload/oh-my-posh.nu"
let starship_autoload = $nu.data-dir | path join "vendor/autoload/starship.nu"

let PROMPT_THEME = "starship"
let OH_MY_POSH_THEME = "zen.toml"

match $PROMPT_THEME {
  "oh-my-posh" => {
    rm --force $starship_autoload
    oh-my-posh init nu --config $"~/.config/ohmyposh/($OH_MY_POSH_THEME)"
  }
  "starship" => {
    rm --force $ohmyposh_autoload
    starship init nu | save -f $starship_autoload
  }
}

source ./tv.nu
source ./atuin.nu
source ./zoxide.nu
