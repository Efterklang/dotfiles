let carapace_completer = {|spans: list<string>|
    CARAPACE_LENIENT=1 carapace $spans.0 nushell ...$spans | from json
}

let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -o 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        _ => $carapace_completer
    } | do $in $spans
}

$env.config.completions = {
  case_sensitive: false
  quick: true # set this to false to prevent auto-selecting completions when only one remains
  partial: true # set this to false to prevent partial filling of the prompt
  algorithm: "prefix" # prefix or fuzzy
  external: {
    enable: true
    completer: $external_completer
  }
  use_ls_colors: true
}
