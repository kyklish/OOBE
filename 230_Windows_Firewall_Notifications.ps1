# This command will disable notifications for all firewall profiles
#   (Domain, Private, and Public)
"Disable Windows Firewall Notifications..."
"Make sure [Windows Firewall Control] app has disabled [Secure Profile] option (if it's installed already)!"
Pause
Set-NetFirewallProfile -NotifyOnListen "False"
Pause
