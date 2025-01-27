"Showing enabled optional features..."
Get-WindowsOptionalFeature -Online | Where-Object { $_.State -eq "Enabled" }
Pause
