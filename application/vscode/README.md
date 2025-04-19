```shell
# Using Nushell
# Save the list of extensions to a file
code --list-extensions | save extensions.txt
# Install the extensions from the file
open extensions.txt | lines | each { |ext| code --install-extension $ext }

# Using Powershell
# Save the list of extensions to a file
code --list-extensions | Out-File -FilePath extensions.txt
# Install the extensions from the file
Get-Content extensions.txt | ForEach-Object { code --install-extension $_ }
```