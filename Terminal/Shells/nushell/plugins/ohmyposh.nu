$env.config = ($env.config | upsert render_right_prompt_on_last_line true)

$env.POWERLINE_COMMAND = 'oh-my-posh'
$env.POSH_THEME = "C:\\Users\\24138\\AppData\\Local\\Programs\\oh-my-posh\\themes\\tokyo-night.omp.json"
# $env.POSH_THEME = "C:\\Users\\24138\\AppData\\Local\\Programs\\oh-my-posh\\themes\\1_shell.omp.json"
$env.PROMPT_INDICATOR = ""
$env.POSH_PID = (random uuid)
$env.POSH_SHELL_VERSION = (version | get version)

def posh_cmd_duration [] {
    # We have to do this because the initial value of `$env.CMD_DURATION_MS` is always `0823`,
    # which is an official setting.
    # See https://github.com/nushell/nushell/discussions/6402#discussioncomment-3466687.
    if $env.CMD_DURATION_MS == "0823" { 0 } else { $env.CMD_DURATION_MS }
}

def posh_width [] {
    (term size).columns | into string
}

# PROMPTS
$env.PROMPT_MULTILINE_INDICATOR = (^"C:/Users/24138/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe" print secondary $"--config=($env.POSH_THEME)" --shell=nu $"--shell-version=($env.POSH_SHELL_VERSION)")

$env.PROMPT_COMMAND = { ||
    # hack to set the cursor line to 1 when the user clears the screen
    # this obviously isn't bulletproof, but it's a start
    let clear = (history | is-empty) or ((history | last 1 | get 0.command) == "clear")

    ^"C:/Users/24138/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe" print primary $"--config=($env.POSH_THEME)" --shell=nu $"--shell-version=($env.POSH_SHELL_VERSION)" $"--execution-time=(posh_cmd_duration)" $"--status=($env.LAST_EXIT_CODE)" $"--terminal-width=(posh_width)" $"--cleared=($clear)"
}

$env.PROMPT_COMMAND_RIGHT = { ||    
    ^"C:/Users/24138/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe" print right $"--config=($env.POSH_THEME)" --shell=nu $"--shell-version=($env.POSH_SHELL_VERSION)" $"--execution-time=(posh_cmd_duration)" $"--status=($env.LAST_EXIT_CODE)" $"--terminal-width=(posh_width)"
}

if "false" == "true" {
    $env.TRANSIENT_PROMPT_COMMAND = { ||
        ^"C:/Users/24138/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe" print transient $"--config=($env.POSH_THEME)" --shell=nu $"--shell-version=($env.POSH_SHELL_VERSION)" $"--execution-time=(posh_cmd_duration)" $"--status=($env.LAST_EXIT_CODE)" $"--terminal-width=(posh_width)"
    }
}

if "false" == "true" {
    echo ""
}
