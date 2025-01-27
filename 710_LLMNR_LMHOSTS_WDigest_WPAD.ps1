"Disable LMHOSTS lookup..."

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" -Name "EnableLMHOSTS" -Type "DWORD" -Value 0

"Disable LLMNR..."
# LLMNR (Link-Local Multicast Name Resolution) is a network protocol for devices
# to find each other's IP addresses on a local network without a DNS server,
# using multicast broadcasts. It's considered a major security risk in modern
# networks because attackers can use it for spoofing and credential theft.

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT" -Name "DNSClient" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMultiCast" -PropertyType "DWORD" -Value 0 -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "DisableSmartNameResolution" -PropertyType "DWORD" -Value 1 -Force | Out-Null

New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "EnableMultiCast" -PropertyType "DWORD" -Value 0 -Force | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" -Name "DisableSmartNameResolution" -PropertyType "DWORD" -Value 1 -Force | Out-Null


"Disable WPAD..."
# WPAD (Web Proxy Auto-Discovery Protocol) is a method for web browsers to
# automatically find a proxy server's configuration file (PAC file) on a network,
# eliminating manual setup, by using DHCP or DNS to locate it. It has security
# risks, as attackers can redirect traffic through malicious proxies.

New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "Wpad" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -PropertyType "DWORD" -Value 1 | Out-Null
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "Wpad" -Force | Out-Null
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Wpad" -Name "WpadOverride" -PropertyType "DWORD" -Value 1 | Out-Null

New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "EnableAutoProxyResultCache" -PropertyType "DWORD" -Value 0 -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "DisableAutoProxyDiscovery" -PropertyType "DWORD" -Value 1 -Force | Out-Null
New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "EnableAutoProxyResultCache" -PropertyType "DWORD" -Value 0 -Force | Out-Null
New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" -Name "DisableAutoProxyDiscovery" -PropertyType "DWORD" -Value 1 -Force | Out-Null


"Disable WDigest..."
# WDigest (Windows Digest) is a legacy Windows authentication protocol that,
# stores plaintext passwords in memory (LSASS), making them vulnerable to theft.

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\Wdigest" -Name "UseLogonCredential" -Type "DWORD" -Value 0
Pause
