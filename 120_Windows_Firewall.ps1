############### Set working directory to the script's directory ################
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location -Path $scriptDir
################################################################################

Write-Warning "[Windows Firewall Control] app must have disabled [Secure Profile] option!"
$response = Read-Host "Continue? (Y/n)"
if ($response -eq "N" -or $response -eq "n") {
    Exit
}

# Disable notifications for all firewall profiles: Domain, Private, Public.
"Disable [Windows Firewall] notifications..."
Set-NetFirewallProfile -NotifyOnListen "False"

"Import [Windows Firewall] rules..."
netsh advfirewall import ".\CONFIG\Windows_Firewall_Policy.wfw"

Pause
