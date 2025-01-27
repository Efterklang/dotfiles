
#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "D:\envir_vars\scoop\apps\miniconda3\current\Scripts\conda.exe") {
    (& "D:\envir_vars\scoop\apps\miniconda3\current\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
}
#endregion
