# Here even bigger instruction with disabling [Credential Guard (Local Security Authority)]:
#   [INSTALL\...\VirtualBox\_Hyper-V_Disable_] ==>
#       [Disable Hyper-V to run virtualization software.rar] ==>
#           [FULL INSTRUCTION - Windows 11 24H2 - how to disable Virtual Based Security _ VMware Workstation.mht]
"Win10: [Core Isolation] is disabled by default."
"Win10: [Hyper-V] [Optional Features] are not installed by default."
"Win10: [VirtualBox] works just fine."
Write-Warning "Win11 only!"
Write-Warning "BIOS setup only!"
Write-Warning "UEFI setup: look for instruction here [INSTALL\...\VirtualBox\_Hyper-V_Disable_]."

"`n"
"Disable [Hypervisor] (Hyper-V, Core Isolation, Credential Guard, Windows Hello)..."
"Disable [Core Isolation]. Its so slow on my PC..."
"Disable [Hyper-V] for VirtualBox..."

"`n"
"Disabling [Memory Integrity (Core Isolation)]..."
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios" -Name "HypervisorEnforcedCodeIntegrity" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -PropertyType "DWORD" -Value 0 -Force | Out-Null

"Disabling [Hyper-V] [Optional Features]..."
# Microsoft Official: disable only Hypervisor, not all Hyper-V (but they will not work)
# Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Hypervisor"
Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" | Out-Null

# TRY THIS FIRST
"Disabling [Hypervisor Launch] on boot..."
bcdedit /set hypervisorlaunchtype off | Out-Null

# TRY THIS SECOND
"Disabling [Virtualization Based Security]:`n`t[Core Isolation], [Credential Guard], [Windows Hello]..."
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "EnableVirtualizationBasedSecurity" -PropertyType "DWORD" -Value 0 -Force | Out-Null

Pause
