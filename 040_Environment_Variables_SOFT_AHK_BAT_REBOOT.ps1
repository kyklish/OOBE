Write-Warning "Run this script twice!"
Write-Warning "First run will fail to check results!"
Write-Warning "Second run (after Explorer & Q-Dir restart) must show correct results!"

################################################################################
# Use only absolute path. This will skip double deref in other scripts: AHK, PS1
################################ PORTABLE APPS #################################

 $name_sft = "SOFT"
# $value_sft = "F:\PORTABLE"

# Get path to PORTABLE folder
# $PSScriptRoot points out to script's dir regardless of working directory
Set-Location -Path $PSScriptRoot
# Current dir: "F:\PORTABLE\_OOBE_"
Set-Location -Path ".."
# Current dir: "F:\PORTABLE"
$value_sft = Get-Location

######################### AutoHotkey in PORTABLE APPS ##########################

 $name_ahk = "SOFT_AHK"
$value_ahk = "$value_sft\_AutoHotkey_"

######################### BAT Scripts in PORTABLE APPS #########################

 $name_bat = "SOFT_BAT"
$value_bat = "$value_sft\_BAT_"

################################################################################

# Use built-in utils
# [/M] = make it SYSTEM wide
SetX $name_sft $value_sft /M
SetX $name_ahk $value_ahk /M
SetX $name_bat $value_bat /M

########################### Show result (optional) #############################

"`n"
$value = (Get-Item "env:$name_sft").Value
Write-Output "$name_sft = $value"
$value = (Get-Item "env:$name_ahk").Value
Write-Output "$name_ahk = $value"
$value = (Get-Item "env:$name_bat").Value
Write-Output "$name_bat = $value"

############################## Restart Explorer ################################

"`n"
"!!!Restart Explorer & Q-Dir to apply new environment variables!!!"
"In case of any problems search on PC:"
"    windows - How do you add a Windows environment variable without rebooting.rar"

$response = Read-Host "Restart Explorer now? (y/N)"
if ($response -eq "Y" -or $response -eq "y") {
    # HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\AutoRestartShell [REG_DWORD]
    # If the Windows 2000 user interface or one of its components stops unexpectedly,
    #   the interface restarts automatically.
    Stop-Process -ProcessName "explorer" -Force
}

################################# Reboot PC ####################################

# "`n"
# "!!!REBOOT REQUIRED TO APPLY NEW ENVIRONMENT VARIABLES!!!"

# $response = Read-Host "Restart computer now? (y/N)"
# if ($response -eq "Y" -or $response -eq "y") {
#     Restart-Computer -Confirm
# }

################################################################################

# Alternatives:

# Directly set environment variable
# [System.Environment]::SetEnvironmentVariable($name_soft, $value_soft, [EnvironmentVariableTarget]::Machine)
# [System.Environment]::SetEnvironmentVariable($name_soft, $value_soft, [EnvironmentVariableTarget]::User)

# Manually write "String" to registry:
# $path = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
# $path = "Registry::HKEY_CURRENT_USER\Environment"
# New-ItemProperty -Path $path -Name $name_soft -Value $value_soft -Force
