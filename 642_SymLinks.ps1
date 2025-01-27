############### Set working directory to the script's directory ################
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location -Path $scriptDir
################################################################################

$wpnUserService = Get-Service -Name "WpnUserService_*"
"Stop service [$($wpnUserService.ServiceName)] to get access to the folder [Notifications]..."
Stop-Service $wpnUserService -Force


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

"Start service [$($wpnUserService.ServiceName)]..."
Start-Service $wpnUserService

Pause
