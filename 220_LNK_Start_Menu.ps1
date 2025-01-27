############### Set working directory to the script's directory ################
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location -Path $scriptDir
################################################################################

"Copy PORTABLE shortcuts to Start Menu..."

$dirSrc = ".\LNK_PORTABLE"
$dirDst = "$env:AppData\Microsoft\Windows\Start Menu\Programs\PORTABLE"
if (Test-Path -Path $dirDst -PathType "Container") {
    # Remove old folder
    Remove-Item -Path $dirDst -Recurse
}
New-Item -Path $dirDst -ItemType "Directory"
Get-ChildItem -Path $dirSrc | `
    Where-Object { $_.Extension -eq ".lnk" -or $_.Extension -eq ".url" } | `
    Copy-Item -Destination $dirDst
Pause
