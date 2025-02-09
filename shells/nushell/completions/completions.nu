source ./scoop.nu
source ./vscode.nu

let carapace_completer = {|spans|
    carapace $spans.0 nushell ...$spans | from json
}

let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

let multiple_completers = {|spans|
    match $spans.0 {
        # cd => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config.completions = {
    case_sensitive: true # set to true to enable case-sensitive completions
    quick: true    # set this to false to prevent auto-selecting completions when only one remains
    partial: true    # set this to false to prevent partial filling of the prompt
    algorithm: "prefix"    # prefix or fuzzy
    external: {
        enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
        max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
        completer: $multiple_completers
    }
    use_ls_colors: true 
}