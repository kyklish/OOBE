############### Set working directory to the script's directory ################
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location -Path $scriptDir
################################################################################

# Test-Path env:SOFT is correct call!
#   Test-Path  env:VARIABLE_EXIST     ==> true / false
#   Test-Path  env:VARIABLE_NOT_EXIST ==> false
#   Test-Path $env:VARIABLE_EXIST     ==> true / false
#   Test-Path $env:VARIABLE_NOT_EXIST ==> ERROR
if (-Not (Test-Path env:SOFT)) {
    "Set environment variables before running this script!"
    "Run XXX_Environment_Variables_SOFT_AHK_BAT.ps1 before this script!"
    Pause
    Exit
}

################################################################################

$file = ".\CONFIG\Windows_Defender_Exclusion.txt"

################################################################################

# Get the directory of the script
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
# Set the working directory to the script's directory
Set-Location -Path $scriptDir

# Read the file line by line
foreach ($path in Get-Content $file) {
    $expandedPath = [System.Environment]::ExpandEnvironmentVariables($path.Trim())
    Write-Output "Adding folder to exclusion: $expandedPath"
    # Add folder to exclusion in Windows Defender
    Add-MpPreference -ExclusionPath $expandedPath -Force
}
Pause

################################################################################

# Tutorial

# Expand variable in string (double de-ref):

# $path = '$env:USERPROFILE\Documents'
# $expandedPath = Invoke-Expression "`"$path`""
# Write-Output $expandedPath

# Expand the %USERPROFILE% environment variable in a string in PowerShell:

# $path = "%USERPROFILE%\Documents"
# $expandedPath = [System.Environment]::ExpandEnvironmentVariables($path)
# Write-Output $expandedPath
