"Showing enabled [Windows Optional Features]..."

# Alternative
# DISM /Online /Get-Features /Format:Table

# [Out-Host] forces PowerShell to finish writing output before moving on to the
#   interactive command. Without it [Pause] or [Read-Host] executes before results
#   of the previous command show up.
Get-WindowsOptionalFeature -Online | `
    Where-Object { $_.State -eq "Enabled" } | `
    Select-Object FeatureName, State | Out-Host

Pause
