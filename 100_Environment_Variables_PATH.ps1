############### Set working directory to the script's directory ################
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location -Path $scriptDir
################################################################################

$file = ".\CONFIG\Environment_Variables_PATH.txt"

$newPath = ""
foreach ($path in Get-Content $file) {
    $expandedPath = [System.Environment]::ExpandEnvironmentVariables($path.Trim())
    Write-Output "Adding folder to PATH: $expandedPath"
    $newPath += ";$expandedPath"
}
$systemPATH = [Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::Machine)
$systemPATH += $newPath
SetX "PATH" $systemPATH /M
Pause
