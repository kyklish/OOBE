"Disable LMHOSTS lookup..."

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" -Name "EnableLMHOSTS" -Type "DWORD" -Value 0

"Disable LLMNR..."
# LLMNR (Link-Local Multicast Name Resolution) is a network protocol for devices
# to find each other's IP addresses on a local network without a DNS server,
# using multicast broadcasts. It's considered a major security risk in modern
# networks because attackers can use it for spoofing and credential theft.

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT" -Name "DNSClient" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMultiCast" -PropertyType "DWORD" -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "DisableSmartNameResolution" -PropertyType "DWORD" -Value 1 -Force

New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "EnableMultiCast" -PropertyType "DWORD" -Value 0 -Force
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "DisableSmartNameResolution" -PropertyType "DWORD" -Value 1 -Force


"Disable WPAD..."
# WPAD (Web Proxy Auto-Discovery Protocol) is a method for web browsers to
# automatically find a proxy server's configuration file (PAC file) on a network,
# eliminating manual setup, by using DHCP or DNS to locate it. It has security
# risks, as attackers can redirect traffic through malicious proxies.

New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "Wpad" -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -PropertyType "DWORD" -Value 1
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "Wpad" -Force
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -PropertyType "DWORD" -Value 1

New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "EnableAutoProxyResultCache" -PropertyType "DWORD" -Value 0 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "DisableAutoProxyDiscovery" -PropertyType "DWORD" -Value 1 -Force
New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "EnableAutoProxyResultCache" -PropertyType "DWORD" -Value 0 -Force
New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "DisableAutoProxyDiscovery" -PropertyType "DWORD" -Value 1 -Force


"Disable WDigest..."
# WDigest (Windows Digest) is a legacy Windows authentication protocol that,
# stores plaintext passwords in memory (LSASS), making them vulnerable to theft.

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\Wdigest" -Name "UseLogonCredential" -Type "DWORD" -Value 0


"Disable NetBIOS over TCP/IP on all network adapters with IP addresses..."

# SanLex Tweaks (Not Work)
# New-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\Dnscache\Parameters" -Name "EnableNetbios" -PropertyType "DWORD" -Value 0

# Edit registry for each network adapter
# HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces ==> Change the [NetbiosOptions] value to [2] for the corresponding interface.

# This one line do all job, but do not print adapter's name.
# (Get-WmiObject Win32_NetworkAdapterConfiguration -Filter IpEnabled="true").SetTcpipNetbios(2)

"Can't change NetBIOS setting for adapter without IP address!"
"Disable DHCP for default [Ethernet] network adapter..."
Set-NetIPInterface -InterfaceAlias "Ethernet" -Dhcp "Disabled"
Start-Sleep -Seconds 2
"Set a Static IP for default [Ethernet] network adapter..."
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.1.40 -PrefixLength 24
Start-Sleep -Seconds 2

"Disable NetBIOS..."
$adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object IPAddress
foreach ($adapter in $adapters) {
    Write-Output $adapter.Description
    $adapter.SetTcpipNetbios(2)
}
Start-Sleep -Seconds 2

"ReturnValue:"
"    0 == Successful completion. No reboot required."
"    1 == Successful completion. Reboot required."
"   72 == Can't access registry. Need admin rights."
"   84 == IP address not assigned to adapter."

"Set a Dynamic IP (DHCP) for default [Ethernet] network adapter..."
Set-NetIPInterface -InterfaceAlias "Ethernet" -Dhcp "Enabled"

Pause

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
