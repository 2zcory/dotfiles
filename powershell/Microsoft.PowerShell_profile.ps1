# Import aliases and functions
. "$HOME\wp\dotfiles\powershell\aliases.ps1"
. "$HOME\wp\dotfiles\powershell\env.ps1"
. "$HOME\wp\dotfiles\powershell\functions\git.ps1"

# Load external tools
Import-Module PSReadLine

# Set theme or prompt
Set-PSReadLineOption -EditMode Emacs

# init oh-my-posh
oh-my-posh init pwsh | Invoke-Expression