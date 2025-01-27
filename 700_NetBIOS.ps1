"Disable NetBIOS over TCP/IP on all network adapters with IP addresses..."
Write-Warning "If cable not connected or IP not assigned results undefined!"

# SanLex Tweaks (Not Work)
# New-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\Dnscache\Parameters" -Name "EnableNetbios" -PropertyType "DWORD" -Value 0

# Edit registry for each network adapter
# HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces ==> Change the [NetbiosOptions] value to [2] for the corresponding interface.

# This one line do all job, but do not print adapter's name.
# (Get-WmiObject Win32_NetworkAdapterConfiguration -Filter IpEnabled="true").SetTcpipNetbios(2)

################################ SET STATIC IP #################################

# PowerShell [Static IP]
# "Can't change NetBIOS setting for adapter without IP address!"
# "Disable DHCP for default [Ethernet] network adapter..."
# Set-NetIPInterface -InterfaceAlias "Ethernet" -Dhcp "Disabled"
# Start-Sleep -Seconds 5
# "Set a Static IP for default [Ethernet] network adapter..."
# New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.1.40 -PrefixLength 24

# Regular [Static IP]
# "Can't change NetBIOS setting for adapter without IP address!"
# "Set a Static IP for default [Ethernet] network adapter..."
# netsh interface ipv4 set address name="Ethernet" static 10.1.1.2 255.255.255.0 10.1.1.1
# netsh interface ipv4 set dns     name="Ethernet" static 8.8.8.8
# netsh interface ipv4 add dns     name="Ethernet" 1.1.1.1 index=2

# "Sleep 5sec..."
# Start-Sleep -Seconds 5
# ipconfig

############################### DISABLE NetBIOS ################################

"`n"
"Disable NetBIOS..."
$adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object IPAddress
foreach ($adapter in $adapters) {
    Write-Output $adapter.Description
    $adapter.SetTcpipNetbios(2)
}

"ReturnValue:"
"    0 == Successful completion. No reboot required."
"    1 == Successful completion. Reboot required."
"   72 == Can't access registry. Need admin rights."
"   84 == IP address not assigned to adapter."

# "Sleep 5sec..."
# Start-Sleep -Seconds 5

################################ SET DYNAMIC IP ################################

# PowerShell [Dynamic IP]
# "Set a Dynamic IP (DHCP) for default [Ethernet] network adapter..."
# Set-NetIPInterface -InterfaceAlias "Ethernet" -Dhcp "Enabled"

# Regular [Dynamic IP]
# "Set a [Dynamic IP] (DHCP) for default [Ethernet] network adapter..."
# netsh interface ipv4 set address name="Ethernet" source=dhcp
# netsh interface ipv4 set dns     name="Ethernet" source=dhcp
# If cable not connected DHCP update command hangs
# ipconfig /renew "Ethernet"

# "Sleep 5sec..."
# Start-Sleep -Seconds 5
# ipconfig
Pause

################################################################################

# Official errors codes:
# 0        {'Successful completion, no reboot required'}
# 1        {'Successful completion, reboot required'}
# 64       {'Method not supported on this platform'}
# 65       {'Unknown failure'}
# 66       {'Invalid subnet mask'}
# 67       {'An error occurred while processing an Instance that was returned'}
# 68       {'Invalid input parameter'}
# 69       {'More than 5 gateways specified'}
# 70       {'Invalid IP  address'}
# 71       {'Invalid gateway IP address'}
# 72       {'An error occurred while accessing the Registry for the requested information'}
# 73       {'Invalid domain name'}
# 74       {'Invalid host name'}
# 75       {'No primary/secondary WINS server defined'}
# 76       {'Invalid file'}
# 77       {'Invalid system path'}
# 78       {'File copy failed'}
# 79       {'Invalid security parameter'}
# 80       {'Unable to configure TCP/IP service'}
# 81       {'Unable to configure DHCP service'}
# 82       {'Unable to renew DHCP lease'}
# 83       {'Unable to release DHCP lease'}
# 84       {'IP not enabled on adapter'}
# 85       {'IPX not enabled on adapter'}
# 86       {'Frame/network number bounds error'}
# 87       {'Invalid frame type'}
# 88       {'Invalid network number'}
# 89       {'Duplicate network number'}
# 90       {'Parameter out of bounds'}
# 91       {'Access denied'}
# 92       {'Out of memory'}
# 93       {'Already exists'}
# 94       {'Path, file or object not found'}
# 95       {'Unable to notify service'}
# 96       {'Unable to notify DNS service'}
# 97       {'Interface not configurable'}
# 98       {'Not all DHCP leases could be released/renewed'}
# 100      {'DHCP not enabled on adapter'}
# default  {'Unknown Error'}
