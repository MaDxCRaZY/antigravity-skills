<#
.SYNOPSIS
    Installs Antigravity custom extension skills (/owl, /battle, /benchmark, /compaction).
.DESCRIPTION
    Copies the skill definitions into the user's global Antigravity configuration directory (~/.gemini/config/skills).
#>

[CmdletBinding()]
param(
    [switch]$LocalWorkspace
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$skillsSourceDir = Join-Path $scriptDir "skills"

if ($LocalWorkspace) {
    $targetDir = Join-Path (Get-Location) ".agents\skills"
} else {
    $targetDir = Join-Path $HOME ".gemini\config\skills"
}

Write-Host "==> Installing Antigravity Skills to: $targetDir" -ForegroundColor Cyan

if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
}

$skills = @("owl", "battle", "benchmark", "compaction")
foreach ($skill in $skills) {
    $src = Join-Path $skillsSourceDir $skill
    $dest = Join-Path $targetDir $skill
    if (Test-Path $src) {
        Copy-Item -Path $src -Destination $targetDir -Recurse -Force
        Write-Host "  [OK] Installed skill: /$skill" -ForegroundColor Green
    } else {
        Write-Warning "Source directory not found for skill: $skill"
    }
}

Write-Host "`nAll skills installed successfully!" -ForegroundColor Green
Write-Host "Restart your Antigravity session or reload your IDE window to see the new commands." -ForegroundColor Yellow
