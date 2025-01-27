############### Set working directory to the script's directory ################
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location -Path $scriptDir
################################################################################

"Add applications to [Open with] & [Select the app to open this file]..."

# "Open_With_Applications.CSV" example:
# "Application","Parameters"
# "%SOFT%\1by1\1by1.exe","%1"

# Import as CSV
# $apps = Get-Content -Path ".\CONFIG\Open_With_Applications.csv" | Where-Object { $_ -notmatch '^#' } | ConvertFrom-Csv
$apps = Import-Csv -Path ".\CONFIG\Open_With_Applications.csv" | Where-Object { $_.Path -notlike '#*' }

# Trim input data and expand environment variables
foreach ($app in $apps) {
    $app.Path = [System.Environment]::ExpandEnvironmentVariables($app.Path.Trim())
    $app.Params = [System.Environment]::ExpandEnvironmentVariables($app.Params.Trim())
}

foreach ($app in $apps) {
    # Get FileName.exe without double quotes
    $name = Split-Path -Path $app.Path.Trim('"') -Leaf
    $commandPath = "Registry::HKEY_CLASSES_ROOT\Applications\$name\shell\open\command"
    $commandValue = $app.Path + " " + $app.Params

    New-Item -Path $commandPath -Force
    Set-Item -Path $commandPath -Value $commandValue
}
Pause
