# Here even bigger instruction with disabling [Credential Guard (Local Security Authority)]: "FULL INSTRUCTION - Windows 11 24h2 hsot - how to disable Virtual Based Security _ VMware Workstation.mht"
"Win10: [Core Isolation] is disabled by default."
"Win10: [Hyper-V] features are not installed by default."
"Only for Win11!"
"Only for BIOS setup!"
"For UEFI (Secure Boot) look in [INSTALL\...\VirtualBox\_Hyper-V_Disable_] folder for instructions."
"Disable [Hypervisor] (Hyper-V, Core Isolation, Credential Guard, Windows Hello)..."
"Disable [Core Isolation]. Its so slow on my PC..."
"Disable [Hyper-V] for VirtualBox..."

"`n"
"Disable Memory Integrity (Core Isolation)..."
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios" -Name "HypervisorEnforcedCodeIntegrity" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" -Name "Enabled" -PropertyType "DWORD" -Value 0 -Force | Out-Null

"Disable Hyper-V Optional Features..."
# Microsoft Official: disable only Hypervisor, not all Hyper-V (but they will not work)
# Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-Hypervisor"
Disable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Hyper-V-All" | Out-Null

# TRY THIS FIRST
"Disable Hypervisor Launch on OS boot..."
bcdedit /set hypervisorlaunchtype off | Out-Null

# TRY THIS SECOND
"Disable Virtualization Based Security (ALL AT ONCE: Core Isolation, Credential Guard, Windows Hello)..."
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard" -Name "EnableVirtualizationBasedSecurity" -PropertyType "DWORD" -Value 0 -Force | Out-Null
Pause
