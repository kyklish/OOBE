############### Set working directory to the script's directory ################
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location -Path $scriptDir
################################################################################

"Copy THEME file and switch Windows Theme..."

$file = ".\THEMES\Windows_(Dark)_Red.theme"
$dirDst = "$env:LocalAppData\Microsoft\Windows\Themes"

Copy-Item -Path $file -Destination $dirDst -Force

Start-Process `
    -FilePath "$env:SOFT\Winaero_Theme_Switcher\ThemeSwitcherWin8.exe" `
    -ArgumentList $file

Pause
