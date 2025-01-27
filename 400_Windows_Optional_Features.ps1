"Disable/Enable [Windows Optional Features]..."

# Alternative
# DISM /Online /Get-Features /Format:Table
# DISM /Online /Disable-Feature /FeatureName:WindowsMediaPlayer /NoRestart
# DISM /Online  /Enable-Feature /FeatureName:WindowsMediaPlayer /NoRestart

function Set-WindowsOptionalFeature {
    param (
        [string]$Action,
        [string]$FeatureName
    )

    if ($Action -ne "Disable" -and $Action -ne "Enable") {
        Write-Error "Wrong action param: $Action"
        return
    }

    if ($script:features) {
        $feature = $script:features | Where-Object { $_.FeatureName -eq $FeatureName }
    } else {
        Write-Error "Populate `$features variable before calling this function!"
        return
    }

    if ($feature) {
        switch ($feature.State) {
            "Enabled" {
                if ($Action -eq "Disable") {
                    Write-Output "Disabling $FeatureName..."
                    Disable-WindowsOptionalFeature -Online -FeatureName $FeatureName -NoRestart | Out-Null
                }
            }
            "Disabled" {
                if ($Action -eq "Enable") {
                    Write-Output "Enabling $FeatureName..."
                    Enable-WindowsOptionalFeature -All -Online -FeatureName $FeatureName -NoRestart | Out-Null
                }
            }
            default { Write-Warning "No action: $FeatureName state is $($feature.State)." }
        }
    }
    else {
        Write-Warning "Feature $FeatureName not found."
    }
}

# Show enabled optional features:
# Get-WindowsOptionalFeature -Online | Where-Object { $_.State -eq "Enabled" } | Select-Object FeatureName, State > R:\OptionalFeatures.txt

# [$features] is global variable used in [Set-WindowsOptionalFeature] function.
# Populate it before using function.
$features = Get-WindowsOptionalFeature -Online

# Essential
# [Windows Media Player] and [MS Paint] does not allow set custom file associations.
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "Internet-Explorer-Optional-amd64"            # Win10
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "Internet-Explorer-Optional-x86"              # Win10
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "MediaPlayback"
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "WindowsMediaPlayer"

# Legacy
# Set-WindowsOptionalFeature -Action "Enable" -FeatureName "DirectPlay"                                 #       [DirectPlay] is an outdated Microsoft networking API that allowed computers to communicate for multiplayer gaming. It was phased out in favor of modern services (like Xbox Live) but is still required to run or play multiplayer in classic PC games released between 1995 and the early 2000s. Many older games (such as Age of Empires II, Diablo II, or old Battlefield titles) rely on DirectPlay to establish peer-to-peer or LAN multiplayer connections.
# Set-WindowsOptionalFeature -Action "Enable" -FeatureName "NetFx3"                                     #       [OnlyUseLatestCLR] registry property replacement: [.\REG_Import\!.NET_Framework.reg]

# Optional
# Set-WindowsOptionalFeature -Action "Disable" -FeatureName "Microsoft-RemoteDesktopConnection"           #       RDP Server (Control your PC from RDP client.) [Settings > System > Remote Desktop > On/Off]
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "MicrosoftWindowsPowerShellV2"                # Win10 Windows PowerShell 2.0 ==> Windows PowerShell 2.0 Engine
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "MicrosoftWindowsPowerShellV2Root"            # Win10 Windows PowerShell 2.0
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "MSRDC-Infrastructure"                        #       Remote Differential Compression API Support [Server Stuff: client-server backup]
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "NetFx4-AdvSrvs"                              #       .NET Framework 4.x Advanced Services [Server Stuff: provides extra functionalities for applications requiring complex networking, web hosting, and enhanced (Windows Communication Foundation [WCF]) features.]
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "WCF-Services45"                              #       .NET Framework 4.x Advanced Services ==> Windows Communication Foundation (WCF Services) [Enterprise/Server Stuff: legacy developer framework required mainly for specialized enterprise software.]
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "WCF-TCP-PortSharing45"                       #       .NET Framework 4.x Advanced Services ==> Windows Communication Foundation (WCF Services) ==> TCP Port Sharing [This feature is designed for enterprise servers running multiple distinct background services on a shared port to conserve network resources.]
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "Printing-Foundation-Features"                #       Print and Document Services
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "Printing-Foundation-InternetPrinting-Client" #       Print and Document Services ==> Internet Printing Client
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "Printing-PrintToPDFServices-Features"        #       Microsoft Print to PDF
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "Printing-XPSServices-Features"               # Win10 Microsoft XPS Document Writer (Virtual "print-to-file" driver. Saves any document as an [XML Paper Specification] (XPS) file: Microsoft's version of a PDF.)
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "SearchEngine-Client-Package"                 #       Search Engine (Indexing and the [Start Menu] search functionality.)
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "SmbDirect"                                   #       SMB Direct
Set-WindowsOptionalFeature -Action "Disable" -FeatureName "WorkFolders-Client"                          #       Work Folders Client [Corporate Stuff: access working files from corporate's server.]

Pause
