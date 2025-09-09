let carapace_completer = {|spans|
  # if the current command is an alias, get it's expansion
  let expanded_alias = (scope aliases | where name == $spans.0 | $in.0?.expansion?)

  # overwrite
  let spans = (if $expanded_alias != null  {
    # put the first word of the expanded alias first in the span
    $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
  } else {
    $spans | skip 1 | prepend ($spans.0)
  })

  carapace $spans.0 nushell ...$spans
  | from json
}

let zoxide_completer = {|spans|
  $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD }
}

let multiple_completers = {|spans|
  match $spans.0 {
    z => $zoxide_completer
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
    max_results: 100
    completer: $multiple_completers
  }
  use_ls_colors: true
}
