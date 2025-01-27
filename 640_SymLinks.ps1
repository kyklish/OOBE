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
    "Run xxx_Environment_Variables_SOFT_AHK_BAT.ps1 before this script!"
    Pause
    Exit
}

if (-Not (Test-Path "R:\TEMP")) {
    Write-Warning "RAM DISK not ready!"
    Write-Warning "Can't access [R:\TEMP]!"
    Pause
    Exit
}

################################################################################

Write-Warning "New [TEMP] and [TMP] env vars that points out to RAM DISK are applied"
Write-Warning "for new processes only! Script may fails to make link for system [TEMP]"
Write-Warning "folders because they used by old processes and can't be deleted."
Write-Warning "Reboot PC and try again."

$wpnUserService = Get-Service -Name "WpnUserService_*"
"Stopping service [$($wpnUserService.ServiceName)] to get access to the [Notifications] folder..."
Stop-Service $wpnUserService -Force

"Stopping process [MicrosoftEdgeUpdate.exe] to get access to the [EdgeUpdate\Log] folder..."
Stop-Process -ProcessName "MicrosoftEdgeUpdate" -Force

# "SymLinks.CSV" example:
# "Source","Destination"
# "D:\Data\Reports,2025","C:\Links\Reports2025"
# "D:\Projects\Alpha","C:\Links\Alpha"


# Import as CSV
# $links = Get-Content -Path ".\CONFIG\SymLinks.csv" | Where-Object { $_ -notmatch '^#' } | ConvertFrom-Csv
$links = Import-Csv -Path ".\CONFIG\SymLinks.csv" | Where-Object { $_.Source -notlike '#*' }

# Trim input data and expand environment variables
foreach ($link in $links) {
    $link.Source = [System.Environment]::ExpandEnvironmentVariables($link.Source.Trim())
    $link.Destination = [System.Environment]::ExpandEnvironmentVariables($link.Destination.Trim())
}


foreach ($link in $links) {
    $source = $link.Source
    $destination = $link.Destination

    if (Test-Path $source) {
        if (Test-Path $destination) {
            try {
                Remove-Item -Path $destination -Recurse -Force -ErrorAction "Stop"
                Write-Host "Item removed successfully: `"$destination`"" -F "DarkGray"
            }
            catch {
                Write-Warning "Failed to remove item: `"$destination`""
                Write-Warning "Exception type: $($_.Exception.GetType().FullName)"
                Write-Warning "Message: $($_.Exception.Message)"
                Write-Warning "HResult (error code): $($_.Exception.HResult)"
            }
        }
        New-Item -ItemType SymbolicLink -Path $destination -Target $source -Force | Out-Null
        Write-Host "Created symlink: `"$destination`" -> `"$source`"" -F "DarkGray"
    }
    else {
        Write-Warning "Source folder does not exist: `"$source`""
    }
}


"`n"
"Check results..."
foreach ($link in $links) {
    $destination = $link.Destination
    $item = Get-Item $destination

    switch ($item.LinkType) {
        "SymbolicLink" { "Symbolic Link        ==> `"$destination`"" }
        "Junction"     { "Junction             ==> `"$destination`"" }
        $null          { "File/Folder/NotExist ==> `"$destination`"" }
    }
}

"Starting service [$($wpnUserService.ServiceName)]..."
Start-Service $wpnUserService

Pause
