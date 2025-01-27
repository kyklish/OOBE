"Disable all [ms_*] protocols on ethernet adapters except IPv4..."

$adapters = Get-NetAdapter
foreach ($adapter in $adapters) {
    # Write-Output "Name: $($adapter.Name), Status: $($adapter.Status)"
    $bindings = Get-NetAdapterBinding -Name $adapter.Name | `
        Where-Object { $_.ComponentID -like "ms_*" -and $_.ComponentID -ne "ms_tcpip" }
    foreach ($binding in $bindings) {
        # Write-Output $binding
        Disable-NetAdapterBinding -Name $adapter.Name -ComponentID $binding.ComponentID
    }
}

"Check results..."
Write-Warning "You must see column [Enabled] with values True/False."
Write-Warning "If PowerShell windows is not wide enough it will be not visible!"
Get-NetAdapterBinding
Pause


# List of the network adapters
# Get-NetAdapter

# List of the protocols: visible in GUI or all of them
# Get-NetAdapterBinding -Name "MyAdapter"
# OR
# Get-NetAdapterBinding -Name "MyAdapter" -AllBindings

# Enable/Disable "ms_tcpip" (IPv4) for example
#  Enable-NetAdapterBinding -Name "MyAdapter" -ComponentID "ms_tcpip"
# Disable-NetAdapterBinding -Name "MyAdapter" -ComponentID "ms_tcpip"
# OR
# Set-NetAdapterBinding -Name "MyAdapter" -ComponentID "ms_tcpip" -Enabled $true
