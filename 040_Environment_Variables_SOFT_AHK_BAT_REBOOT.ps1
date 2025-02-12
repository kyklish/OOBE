################################################################################
# Use only absolute path. This will skip double deref in other scripts: AHK, PS1
################################ PORTABLE APPS #################################

$name_soft = "SOFT"
# $value_soft = "F:\PORTABLE"

# Get path to PORTABLE folder
# $PSScriptRoot points out to script's dir regardless of working directory
Set-Location -Path $PSScriptRoot
# Current dir: "F:\PORTABLE\_OOBE_"
Set-Location -Path ".."
# Current dir: "F:\PORTABLE"
$value_soft = Get-Location

######################### AutoHotkey in PORTABLE APPS ##########################

$name_ahk = "SOFT_AHK"
$value_ahk = "$value_soft\_AutoHotkey_"

######################### BAT Scripts in PORTABLE APPS #########################

$name_bat = "SOFT_BAT"
$value_bat = "$value_soft\_BAT_"

################################################################################

# Use built-in utils
# [/M] = make it SYSTEM wide
SetX $name_soft $value_soft /M
SetX $name_ahk  $value_ahk  /M
SetX $name_bat  $value_bat  /M

################################################################################

"`n!!!REBOOT REQUIRED TO APPLY NEW ENVIRONMENT VARIABLES!!!"

$response = Read-Host "Restart computer now? (y/N)"
if ($response -eq "Y" -or $response -eq "y") {
    Restart-Computer -Confirm
} else {
    Pause
}

################################################################################

# Alternatives:

# Directly set environment variable
# [System.Environment]::SetEnvironmentVariable($name_soft, $value_soft, [EnvironmentVariableTarget]::Machine)
# [System.Environment]::SetEnvironmentVariable($name_soft, $value_soft, [EnvironmentVariableTarget]::User)

# Manually write "String" to registry:
# $path = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
# $path = "Registry::HKEY_CURRENT_USER\Environment"
# New-ItemProperty -Path $path -Name $name_soft -Value $value_soft -Force
