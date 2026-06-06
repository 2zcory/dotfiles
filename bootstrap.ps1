$NvimWinPath = "$env:LOCALAPPDATA\nvim"
if (!(Test-Path $NvimWinPath)) {
    # Tạo liên kết mềm sử dụng Cmdlet PowerShell Native (Yêu cầu đặc quyền Admin)
    New-Item -ItemType SymbolicLink -Path $NvimWinPath -Value "$REPO_DIR\.config\nvim" -Force
}