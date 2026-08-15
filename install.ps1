# FluxNat Proxy Skill Windows 1-Line Installer
$ErrorActionPreference = "Stop"

Write-Host "⚡ Installing FluxNat Proxy Skill (/proxy) for AI Agents..." -ForegroundColor Cyan

$SkillUrl = "https://raw.githubusercontent.com/k4ran909/proxy/main/skills/proxy/SKILL.md"

$TargetDirs = @(
    "$HOME\.gemini\config\skills\proxy",
    "$HOME\.hermes\skills\proxy",
    "$((Get-Location).Path)\.agents\skills\proxy"
)

$InstalledCount = 0

foreach ($Dir in $TargetDirs) {
    try {
        if (!(Test-Path -Path $Dir)) {
            New-Item -ItemType Directory -Path $Dir -Force | Out-Null
        }
        $TargetFile = Join-Path $Dir "SKILL.md"
        Invoke-WebRequest -Uri $SkillUrl -OutFile $TargetFile -UseBasicParsing
        Write-Host "✅ Installed skill to: $TargetFile" -ForegroundColor Green
        $InstalledCount++
    } catch {
        Write-Warning "Could not write to $Dir : $_"
    }
}

if ($InstalledCount -gt 0) {
    Write-Host "`n🎉 Success! The /proxy skill is installed and ready." -ForegroundColor Cyan
    Write-Host "👉 You can now tell any agent: '/proxy' or 'use proxy skill to scrape X'" -ForegroundColor Yellow
} else {
    Write-Error "Installation failed. Please check internet access."
}
