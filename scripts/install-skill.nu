#! /usr/bin/env nu

const SCRIPT_PATH = path self
const REPO_ROOT = ($SCRIPT_PATH | path dirname | path dirname)
const SKILLS_ROOT = ([$REPO_ROOT "skills"] | path join)
const DEFAULT_MAP = ([$SKILLS_ROOT "macOS_install_map.json"] | path join)
const GLOBAL_TARGETS = {
  agents: "~/.agents/skills"
  claude: "~/.claude/skills"
  codex: "~/.codex/skills"
  opencode: "~/.config/opencode/skills"
}

def _is-symlink [path: string] {
  ((^test -L $path | complete).exit_code == 0)
}

def _resolve-map-path [map_path: string] {
  if $map_path == "" {
    $DEFAULT_MAP
  } else if ($map_path | str starts-with "/") or ($map_path | str starts-with "~") {
    $map_path | path expand
  } else {
    [$REPO_ROOT $map_path] | path join | path expand
  }
}

def _resolve-target [target: string] {
  let key = ($target | str lowercase)

  if $key in ($GLOBAL_TARGETS | columns) {
    $GLOBAL_TARGETS | get $key
  } else {
    $target
  }
}

def _install-root [target: string] {
  let expanded = (_resolve-target $target | path expand)
  let basename = ($expanded | path basename)

  if $basename == "skills" {
    $expanded
  } else if $basename == ".agents" {
    [$expanded "skills"] | path join
  } else {
    [$expanded ".agents" "skills"] | path join
  }
}

def _targets-as-list [targets: any] {
  let kind = ($targets | describe)

  if $kind == "string" {
    [$targets]
  } else if ($kind | str starts-with "list") {
    $targets
  } else {
    error make {msg: $"install map values must be a string or list<string>, got ($kind)"}
  }
}

def _backup-existing [dest: string dry_run: bool] {
  let stamp = (date now | format date "%Y%m%d%H%M%S")
  let backup = $"($dest).backup-($stamp)"

  if $dry_run {
    print $"Would move existing ($dest) to ($backup)"
  } else {
    mv $dest $backup
    print $"Backed up existing install: ($backup)"
  }
}

def _install-one [skill_name: string source: string target: string copy_mode: bool dry_run: bool] {
  let install_root = (_install-root $target)
  let dest = ([$install_root $skill_name] | path join)

  print $"Installing ($skill_name) -> ($dest)"

  if not ($source | path exists) {
    error make {msg: $"skill source not found: ($source)"}
  }

  if not (([$source "SKILL.md"] | path join) | path exists) {
    error make {msg: $"skill source has no SKILL.md: ($source)"}
  }

  if ($dest | path exists) {
    if (_is-symlink $dest) {
      let current = (^readlink $dest | str trim)
      if $current == $source and not $copy_mode {
        print "Already installed"
        return
      }
    }
    _backup-existing $dest $dry_run
  }

  if $dry_run {
    print $"Would create directory ($install_root)"
    if $copy_mode {
      print $"Would copy ($source) to ($dest)"
    } else {
      print $"Would symlink ($dest) -> ($source)"
    }
    return
  }

  mkdir $install_root
  if $copy_mode {
    cp -r $source $dest
  } else {
    ^ln -s $source $dest
  }
}

def main [
  --map: string = ""
  --copy
  --dry-run
  ...skill_names: string
] {
  let map_path = (_resolve-map-path $map)

  if not ($map_path | path exists) {
    error make {msg: $"install map not found: ($map_path)"}
  }

  let install_map = (open $map_path)
  let known_skills = ($install_map | columns)
  let selected_skills = if ($skill_names | is-empty) { $known_skills } else { $skill_names }

  for skill_name in $selected_skills {
    if not ($known_skills | any {|known| $known == $skill_name }) {
      error make {msg: $"skill not found in install map: ($skill_name)"}
    }

    let source = ([$SKILLS_ROOT $skill_name] | path join | path expand)
    let targets = (_targets-as-list ($install_map | get $skill_name))

    for target in $targets {
      _install-one $skill_name $source $target $copy $dry_run
    }
  }
}
