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
    Write-Warning "Set environment variables before running this script!"
    Write-Warning "Run xxx_Environment_Variables_SOFT_AHK_BAT.ps1 before this script!"
    Pause
    Exit
}

################################################################################

$file = ".\CONFIG\Environment_Variables_PATH.txt"

$systemPATH = [Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::Machine)
$newPATH = ""
foreach ($path in Get-Content $file) {
    $expandedPath = [System.Environment]::ExpandEnvironmentVariables($path.Trim())
    Write-Output "Adding folder to PATH: $expandedPath"
    # [regex]::Escape($needle) allows treat text inside it as raw text, no need
    #   escape special characters inside it.
    if (-not ($systemPATH -match "(^|;)$([regex]::Escape($expandedPath))(;|$)")) {
        $newPATH += ";$expandedPath"
    }
}
$systemPATH += $newPATH
# Collapse any run of semicolons (;;;;;;;) into a single one (;)
$systemPATH = $systemPATH -replace ";+", ";"
SetX "PATH" $systemPATH /M

"`n"
"Check results..."
$systemPATH = [Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::Machine)
Write-Output $systemPATH

"`n"
"Formatted results..."
$systemPATH -split ';' | ForEach-Object { Write-Output $_ }

Pause
