Write-Warning "[Add] action ends with error. Needs internet access???"
"Add/Remove [Windows Capabilities]..."

# Alternative
# DISM /Online /Get-Capabilities /Format:Table
# DISM /Online    /Add-Capability /CapabilityName:Media.WindowsMediaPlayer~~~~0.0.12.0 /NoRestart
# DISM /Online /Remove-Capability /CapabilityName:Media.WindowsMediaPlayer~~~~0.0.12.0 /NoRestart

function Set-WindowsCapability {
    param (
        [string]$Action,
        [string]$Name
    )

    if ($Action -ne "Add" -and $Action -ne "Remove") {
        Write-Error "Wrong action param: $Action"
        return
    }

    if ($script:capabilities) {
        $capability = $script:capabilities | Where-Object { $_.Name -like "$Name*" }
    } else {
        Write-Error "Populate `$capabilities variable before calling this function!"
        return
    }

    if ($capability) {
        switch ($capability.State) {
            "Installed" {
                if ($Action -eq "Remove") {
                    Write-Output "Removing $Name..."
                    Remove-WindowsCapability -Online -Name $capability.Name | Out-Null
                }
            }
            "NotPresent" {
                if ($Action -eq "Add") {
                    Write-Output "Adding $capability.Name..."
                    Add-WindowsCapability -Online -Name $capability.Name -LimitAccess -Source "$env:SystemRoot\WinSxS" | Out-Null
                }
            }
            default { Write-Warning "No action: $Name state is $($capability.State)." }
        }
    }
    else {
        Write-Warning "Capability $Name not found."
    }
}

# Show installed capabilities:
# Get-WindowsCapability -Online | Where-Object { $_.State -eq "Installed" } | Select-Object Name, State > R:\Capabilities.txt

# [$capabilities] is global variable used in [Set-WindowsCapability] function.
# Populate it before using function.
$capabilities = Get-WindowsCapability -Online

# Essential
# [Windows Media Player] and [MS Paint] does not allow set custom file associations.
Set-WindowsCapability -Action "Remove" -Name "Browser.InternetExplorer"
Set-WindowsCapability -Action "Remove" -Name "Media.WindowsMediaPlayer"
Set-WindowsCapability -Action "Remove" -Name "Microsoft.Windows.MSPaint"

# Optional
Set-WindowsCapability -Action "Remove" -Name "App.Support.QuickAssist"  # Win10
# This command returns array my function fails, because it finds two capabilities:
#   ["Hello.Face.18967","Hello.Face.Migration.18967"]. Use more precise name to
#   avoid multiple search results.
# Set-WindowsCapability -Action "Remove" -Name "Hello.Face"
Set-WindowsCapability -Action "Remove" -Name "Hello.Face.18967"         # Win10
Set-WindowsCapability -Action "Remove" -Name "Hello.Face.20134"         # Win11
Set-WindowsCapability -Action "Remove" -Name "MathRecognizer"
Set-WindowsCapability -Action "Remove" -Name "Print.Fax.Scan"
Set-WindowsCapability -Action "Remove" -Name "Print.Management.Console"

Pause
