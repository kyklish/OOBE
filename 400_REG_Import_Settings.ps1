# Get the directory of the script
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
# Set the working directory to the script's directory
Set-Location -Path $scriptDir

$directoryPath = "$scriptDir\REG_IMPORT"
$files = Get-ChildItem -Path $directoryPath -File -Filter "*.reg"

foreach ($file in $files) {
    Write-Output "Importing file to registry: `"$($file)`""
    Start-Process "reg.exe" -ArgumentList "import", "`"$($file.FullName)`"" -Wait
}
Pause
