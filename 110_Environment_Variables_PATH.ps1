$file = ".\CONFIG\Environment_Variables_PATH.txt"

################################################################################

# Get the directory of the script
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
# Set the working directory to the script's directory
Set-Location -Path $scriptDir

$newPath = ""
# Read the file line by line
foreach ($path in Get-Content $file) {
    $expandedPath = [System.Environment]::ExpandEnvironmentVariables($path.Trim())
    Write-Output "Adding folder to PATH: $expandedPath"
    $newPath += ";$expandedPath"
}
$systemPATH = [Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::Machine)
$systemPATH += $newPath
SetX "PATH" $systemPATH /M
Pause
