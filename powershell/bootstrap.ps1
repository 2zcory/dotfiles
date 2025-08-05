# Create symlink
$profileTarget = "$HOME\wp\dotfiles\powershell\Microsoft.PowerShell_profile.ps1"
New-Item -ItemType SymbolicLink -Path $PROFILE -Target $profileTarget -Force

# Install necessary module
Install-Module PSReadLine -Scope CurrentUser -Force