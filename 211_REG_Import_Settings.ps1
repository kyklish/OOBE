############### Set working directory to the script's directory ################
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location -Path $scriptDir
################################################################################

$directoryPath = ".\REG_IMPORT"
$files = Get-ChildItem -Path $directoryPath -File -Filter "*.reg"

foreach ($file in $files) {
    Write-Output "Importing file to registry: `"$($file)`""
    Start-Process "reg.exe" -ArgumentList "import", "`"$($file.FullName)`"" -Wait
}
Pause
