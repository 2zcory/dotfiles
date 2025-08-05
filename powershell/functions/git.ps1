function Invoke-IfGitRepo {
    param (
        [ScriptBlock]$Action,
        [ScriptBlock]$OnFail = { Write-Warning "❌ Not a Git repository in current directory." },
        [string]$Path = (Get-Location)
    )

    # Validate the provided path
    if (-not (Test-Path $Path)) {
        Write-Error "Path does not exist: $Path"
        return
    }

    # Change to the specified path and check if it's a Git repository
    Push-Location $Path

    try {
        if (-not (Test-Path ".git")) {
            & $OnFail
        } else {
            & $Action
        }
    }
    finally {
        Pop-Location
    }
}

function Git-CommitAndPush {
    param (
        [string]$Path = (Get-Location),
        [switch]$DryRun,
        [switch]$Silent
    )

    Invoke-IfGitRepo -Path $Path -Action {
        Push-Location $Path
        try {
            # Check for uncommitted changes
            $status = git status --porcelain
            if (-not $status) {
                if (-not $Silent) {
                    Write-Host "✅ No changes to commit in $Path"
                }
                return
            }

            # Generate commit message from timestamp
            $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

            if ($DryRun) {
                Write-Host "[DryRun] Would commit and push with message: '$timestamp'"
                return
            }

            # Add, commit, push
            git add -A
            git commit -m "$timestamp"
            git push origin HEAD

            if (-not $Silent) {
                Write-Host "✅ Changes committed and pushed with message: $timestamp"
            }
        }
        finally {
            Pop-Location
        }
    } -OnFail {
        if (-not $Silent) {
            Write-Warning "❌ Not a Git repository at path: $Path"
        }
    }
}

function Git-ConfigUser {
    param (
        [string]$Name = $env:GIT_NAME,
        [string]$Email = $env:GIT_EMAIL,
        [switch]$Global,
        [switch]$DryRun,
        [switch]$Silent,
        [switch]$Force,
        [switch]$UseFallbackIfUnset
    )

    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Error "Git is not installed or not found in PATH."
        return
    }

    # Nếu không có ENV và có chỉ định fallback, dùng mặc định cứng
    if ($UseFallbackIfUnset -and (-not $Name -or -not $Email)) {
        if (-not $Name)  { $Name  = "Default User" }
        if (-not $Email) { $Email = "user@example.com" }
        if (-not $Silent) {
            Write-Warning "⚠️ Using fallback Git identity: $Name <$Email>"
        }
    }

    # Nếu vẫn chưa có name/email thì cảnh báo
    if (-not $Name -or -not $Email) {
        Write-Error "Git user.name and user.email are required. Set via param or GIT_NAME / GIT_EMAIL env."
        return
    }

    $scope = if ($Global) { "--global" } else { "" }

    $currentName  = git config $scope user.name 2>$null
    $currentEmail = git config $scope user.email 2>$null

    if (-not $Force -and $currentName -eq $Name -and $currentEmail -eq $Email) {
        if (-not $Silent) {
            Write-Host "✅ Git user config already set:"
            Write-Host "   name:  $currentName"
            Write-Host "   email: $currentEmail"
        }
        return
    }

    if ($DryRun) {
        Write-Host "[DryRun] Would set git config $scope user.name  '$Name'"
        Write-Host "[DryRun] Would set git config $scope user.email '$Email'"
        return
    }

    git config $scope user.name "$Name"
    git config $scope user.email "$Email"

    if (-not $Silent) {
        Write-Host "✅ Git user config updated:"
        Write-Host "   name:  $Name"
        Write-Host "   email: $Email"
    }
}

