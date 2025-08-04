# Load aliases
. "$PSScriptRoot/aliases.ps1"

# Load functions
Get-ChildItem "$PSScriptRoot/functions/*.ps1" | ForEach-Object { . $_.FullName }


