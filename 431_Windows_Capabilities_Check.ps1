"Showing installed [Windows Capabilities]..."

# Alternative
# DISM /Online /Get-Capabilities /Format:Table

# [Out-Host] forces PowerShell to finish writing output before moving on to the
#   interactive command. Without it [Pause] or [Read-Host] executes before results
#   of the previous command show up.
Get-WindowsCapability -Online -LimitAccess -Source "$env:SystemRoot\WinSxS" | `
    Where-Object { $_.State -eq "Installed" } | `
    Select-Object Name, State | Out-Host

Pause
