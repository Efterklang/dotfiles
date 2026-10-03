source ./cd.nu

let carapace_completer = {|place|
    CARAPACE_LENIENT=1 carapace $place.command.0 nushell ...$place.command | from json
}

$env.config.completions = {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "prefix"
    external: {
        enable: true
        completer: $carapace_completer
    }
    use_ls_colors: true
}
