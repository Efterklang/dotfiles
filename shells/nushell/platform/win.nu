$env.YAZI_FILE_ONE = 'D:/envir_vars/scoop/apps/git/current/usr/bin/file.exe'

source ../aliases/scoop.nu
source ../completions/scoop.nu
source ../completions/winget.nu

def --env pwd [] {
  $env.PWD | str replace --all '\' '/'
}

alias su = scoop update
alias si = scoop install
alias sui = scoop uninstall
alias sse = scoop search
alias sst = scoop status
alias sl = scoop list
alias sbl = scoop bucket list
alias sba = scoop bucket add
alias sbr = scoop bucket rm
alias sui = scoop uninstall
alias vpwd = vim "E:\\OneDrive - 商业版\\home\\markdown\\notes\\Private\\key.md"
alias cdc = cd c://
alias cdd = cd d://
alias cde = cd e://
alias man = cheat
alias sync = pwsh -File E://projects/config/install.ps1

