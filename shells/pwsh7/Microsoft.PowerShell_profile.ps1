# * Modules 
function exp {
    explorer .
}

# * alias
Set-Alias -Name grep -Value rg
Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name cd -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force
Set-Alias -Name ci -Value code-insiders
Set-Alias -Name ff -Value fastfetch
Set-Alias -Name vim -Value nvim
Set-Alias -Name la -Value Get-ChildItemForce

function Get-ChildItemForce {
    Get-ChildItem -Force @args
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (&starship init powershell)
