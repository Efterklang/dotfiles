# Activate conda environment
export def --env activate [
    env_name?: string@'nu-complete conda envs' # name of the environment
] {
    let conda_info = (conda info --envs --json | from json)

    let env_name = if $env_name == null {
        "base"
    } else {
        $env_name
    }

    let env_dir = if $env_name != "base" {
        if ($env_name | path exists) and (($env_name | path expand) in $conda_info.envs ) {
            ($env_name | path expand)
        } else {
            ((check-if-env-exists $env_name $conda_info) | into string)
        }
    } else {
        $conda_info.root_prefix
    }

    let old_path = (system-path | str join (char esep))

    let new_path = if (windows?) {
        conda-create-path-windows $env_dir
    } else {
        conda-create-path-unix $env_dir
    }

    let virtual_prompt = $'[($env_name)] '

    let new_env = ({
        CONDA_DEFAULT_ENV: $env_name
        CONDA_PREFIX: $env_dir
        CONDA_PROMPT_MODIFIER: $virtual_prompt
        CONDA_SHLVL: "1"
        CONDA_OLD_PATH: $old_path
    } | merge $new_path)



    load-env $new_env
}

# Deactivate currently active conda environment
export def --env deactivate [] {
    let path_name = if "PATH" in $env { "PATH" } else { "Path" }
    $env.$path_name = $env.CONDA_OLD_PATH

    hide-env CONDA_PROMPT_MODIFIER
    hide-env CONDA_PREFIX
    hide-env CONDA_SHLVL
    hide-env CONDA_DEFAULT_ENV
    hide-env CONDA_OLD_PATH
}

def check-if-env-exists [ env_name: string, conda_info: record ] {
    let env_dirs = (
        $conda_info.envs_dirs |
        each { || path join $env_name }
    )

    let en = ($env_dirs | each {|en| $conda_info.envs | where $it == $en } | where ($it | length) == 1 | flatten)
    if ($en | length) > 1 {
        error make --unspanned {msg: $"You have environments in multiple locations: ($en)"}
    }
    if ($en | length) == 0 {
        error make --unspanned {msg: $"Could not find given environment: ($env_name)"}
    }
    $en.0
}

def 'nu-complete conda envs' [] {
    conda info --envs
    | lines
    | where not ($it | str starts-with '#')
    | where not ($it | is-empty)
    | each {|entry| $entry | split row ' ' | get 0 }
}

def conda-create-path-windows [env_dir: path] {
    # Conda on Windows needs a few additional Path elements
    let env_path = [
        $env_dir
        ([$env_dir "Scripts"] | path join)
        ([$env_dir "Library" "mingw-w64"] | path join)
        ([$env_dir "Library" "bin"] | path join)
        ([$env_dir "Library" "usr" "bin"] | path join)
    ]

    let new_path = ([$env_path (system-path)]
        | flatten
        | str join (char esep))

    { Path: $new_path }
}

def conda-create-path-unix [env_dir: path] {
    let env_path = [
        ([$env_dir "bin"] | path join)
    ]

    let new_path = ([$env_path $env.PATH]
        | flatten
        | str join (char esep))

    { PATH: $new_path }
}

def windows? [] {
    ($nu.os-info.name | str downcase) == "windows"
}

def system-path [] {
    if "PATH" in $env { $env.PATH } else { $env.Path }
}

def has-env [name: string] {
    $name in $env
}
