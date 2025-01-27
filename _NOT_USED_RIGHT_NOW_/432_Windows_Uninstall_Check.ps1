"Showing installed [MSI] packages..."
Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Out-Host

Pause
