# Optimise-Windows11.ps1
# Windows 11 AI/Bloat/Telemetry Optimisation Script
# Author: Adam Anderson
# SpaceNet-IT

Write-Host "Starting Windows 11 optimisation..." -ForegroundColor Cyan

# Confirm admin
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
)

if (-not $IsAdmin) {
    Write-Host "Please run this script as Administrator." -ForegroundColor Red
    exit
}

# Create restore point
Write-Host "Creating system restore point..." -ForegroundColor Yellow
try {
    Checkpoint-Computer -Description "Before Windows 11 Optimisation" -RestorePointType "MODIFY_SETTINGS"
} catch {
    Write-Host "Restore point skipped or unavailable." -ForegroundColor DarkYellow
}

# Disable Copilot
Write-Host "Disabling Copilot..." -ForegroundColor Yellow

$CopilotPolicies = @(
    "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot",
    "HKLM:\Software\Policies\Microsoft\Windows\WindowsCopilot"
)

foreach ($path in $CopilotPolicies) {
    New-Item -Path $path -Force | Out-Null
    New-ItemProperty -Path $path -Name "TurnOffWindowsCopilot" -Value 1 -PropertyType DWord -Force | Out-Null
}

Get-AppxPackage *Microsoft.Copilot* -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue

# Disable Recall / AI features
Write-Host "Disabling Recall and AI features..." -ForegroundColor Yellow

$AIPaths = @(
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI",
    "HKCU:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI"
)

foreach ($path in $AIPaths) {
    New-Item -Path $path -Force | Out-Null
    New-ItemProperty -Path $path -Name "DisableAIDataAnalysis" -Value 1 -PropertyType DWord -Force | Out-Null
    New-ItemProperty -Path $path -Name "AllowRecallEnablement" -Value 0 -PropertyType DWord -Force | Out-Null
}

# Disable Widgets
Write-Host "Disabling Widgets and News feeds..." -ForegroundColor Yellow

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Value 0 -PropertyType DWord -Force | Out-Null

# Remove Web Experience Pack
Get-AppxPackage *WebExperience* -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue

# Remove bloatware
Write-Host "Removing Windows bloatware..." -ForegroundColor Yellow

$BloatApps = @(
    "*Microsoft.BingNews*",
    "*Microsoft.BingWeather*",
    "*Microsoft.GetHelp*",
    "*Microsoft.Getstarted*",
    "*Microsoft.MicrosoftOfficeHub*",
    "*Microsoft.MicrosoftSolitaireCollection*",
    "*Microsoft.People*",
    "*Microsoft.PowerAutomateDesktop*",
    "*Microsoft.Todos*",
    "*Microsoft.WindowsFeedbackHub*",
    "*Microsoft.Xbox*",
    "*Microsoft.GamingApp*",
    "*Microsoft.ZuneMusic*",
    "*Microsoft.ZuneVideo*",
    "*MicrosoftTeams*",
    "*Clipchamp*"
)

foreach ($app in $BloatApps) {
    Get-AppxPackage $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
}

# Disable telemetry
Write-Host "Disabling telemetry..." -ForegroundColor Yellow

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -PropertyType DWord -Force | Out-Null

$TelemetryServices = @(
    "DiagTrack",
    "dmwappushservice"
)

foreach ($svc in $TelemetryServices) {
    Stop-Service $svc -Force -ErrorAction SilentlyContinue
    Set-Service $svc -StartupType Disabled -ErrorAction SilentlyContinue
}

# Disable Search indexing
Write-Host "Disabling Windows Search indexing..." -ForegroundColor Yellow

Stop-Service WSearch -Force -ErrorAction SilentlyContinue
Set-Service WSearch -StartupType Disabled -ErrorAction SilentlyContinue

# Optimise visual effects
Write-Host "Optimising visual effects..." -ForegroundColor Yellow

$VisualFX = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
New-Item -Path $VisualFX -Force | Out-Null
New-ItemProperty -Path $VisualFX -Name "VisualFXSetting" -Value 2 -PropertyType DWord -Force | Out-Null

# Disable transparency
$Personalize = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
New-Item -Path $Personalize -Force | Out-Null
New-ItemProperty -Path $Personalize -Name "EnableTransparency" -Value 0 -PropertyType DWord -Force | Out-Null

# Enable Ultimate Performance
Write-Host "Enabling Ultimate Performance power plan..." -ForegroundColor Yellow

powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61

# Disable hibernation
Write-Host "Disabling hibernation..." -ForegroundColor Yellow
powercfg /hibernate off

# Clean temp files
Write-Host "Cleaning temporary files..." -ForegroundColor Yellow

$TempFolders = @(
    "$env:TEMP\*",
    "C:\Windows\Temp\*"
)

foreach ($folder in $TempFolders) {
    Remove-Item $folder -Recurse -Force -ErrorAction SilentlyContinue
}

# Restart Explorer
Write-Host "Restarting Explorer..." -ForegroundColor Yellow
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Process explorer.exe

Write-Host ""
Write-Host "Windows 11 optimisation complete." -ForegroundColor Green
Write-Host "Restart your machine to apply all changes." -ForegroundColor Cyan
