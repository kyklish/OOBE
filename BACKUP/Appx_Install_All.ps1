"Install all .Appx and .AppxBundle in script's directory"

############### Set working directory to the script's directory ################
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location -Path $scriptDir
################################################################################

$files = Get-ChildItem -File -Filter "*.Appx*"

foreach ($file in $files) {
    Write-Output "Installing: $file"
    Add-AppxPackage -Path $file

    # Alternative variant, but need tune to make it work
    # Start-Process "PowerShell.exe" -ArgumentList "-NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass Add-AppxPackage -DeferRegistrationWhenPackagesAreInUse -ForceUpdateFromAnyVersion -Path `"$file`"" -Wait
}
Pause
