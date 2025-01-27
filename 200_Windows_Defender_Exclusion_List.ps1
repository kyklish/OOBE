"Set environment variables before running this script!"
"Run 100_Environment_Variables_SOFT_AHK_BAT.ps1 before this script!"
Pause

################################################################################

$file = ".\CONFIG\Windows_Defender_Exclusion_List.txt"

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
