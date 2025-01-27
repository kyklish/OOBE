# How to find out device name:
#   Look for device name in:          "Device Manager"
#   Show device name:                 POWERCFG /DEVICEQUERY wake_armed
# How to find out what woke the system from sleep:
#   Enumerates active wake timers:    POWERCFG /WAKETIMERS
#   What woke the system:             POWERCFG /LASTWAKE

"Disable devices from waking the system from a sleep state..."
"On my PC keyboard and mouse immediately wake up the system from a sleep state!"

"`n"
"Devices below are enabled for waking the system from a sleep state:"
POWERCFG /DEVICEQUERY wake_armed

$deviceKeyboard = "HID Keyboard Device"
$deviceMouse = "HID-compliant mouse"
"`n"
"Devices below will be disabled for waking the system from a sleep state:"
"$deviceKeyboard"
"$deviceMouse"

"`n"
"If names does not match: edit this script and apply again!"
$response = Read-Host "Continue? (y/N)"
if ($response -ne "Y" -or $response -ne "y") {
    Exit
}

POWERCFG /DEVICEDISABLEWAKE "$deviceKeyboard"
POWERCFG /DEVICEDISABLEWAKE "$deviceMouse"

"`n"
"Check results..."
"Devices below are enabled for waking the system from a sleep state:"
POWERCFG /DEVICEQUERY wake_armed
Pause
