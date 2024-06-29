
# * Modules 
Import-Module PSReadLine
Import-Module posh-git
# Install Terminal-Icons module
# if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
#     Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -SkipPublisherCheck
# }
Import-Module -Name Terminal-Icons
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete

function reload-profile {
    . $profile
}

function exp {
    explorer .
}

function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}



# * alias
Set-Alias -Name grep -Value rg
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name cd -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force
Set-Alias -Name ci -Value code-insiders
Set-Alias -Name ff -Value fastfetch
Set-Alias -Name vim -Value nvim

function Get-ChildItemForce {
    Get-ChildItem -Force @args
}
Set-Alias -Name la -Value Get-ChildItemForce
Invoke-Expression (& { (zoxide init powershell | Out-String) })
<<<<<<< HEAD
oh-my-posh init pwsh --config 'C:/Users/24138/AppData/Local/Programs/oh-my-posh/themes/tokyo-night.omp.json' | Invoke-Expression
=======
oh-my-posh init pwsh --config '~/AppData/Local/Programs/oh-my-posh/themes/tokyo-night.omp.json' | Invoke-Expression
>>>>>>> 7c9e02e (rebase)
