# How to find out device name:
#   Look for device name in:          "Device Manager"
#   Show device name:                 POWERCFG /DEVICEQUERY wake_armed
# How to find out what woke the system from sleep:
#   Enumerates active wake timers:    POWERCFG /WAKETIMERS
#   What woke the system:             POWERCFG /LASTWAKE

"Disable devices from waking the system from a sleep state..."
"`tOn my PC keyboard and mouse immediately wake up the system from a sleep state!"
$deviceKeyboard = "HID Keyboard Device"
$deviceMouse = "HID-compliant mouse"
"`tDevices below are enabled for waking the system from a sleep state:"
POWERCFG /DEVICEQUERY wake_armed
"`tDevices below will be disabled for waking the system from a sleep state:"
"$deviceKeyboard"
"$deviceMouse`n"
"`tIf names does not match: edit this script and apply again!`n"
POWERCFG /DEVICEDISABLEWAKE "$deviceKeyboard"
POWERCFG /DEVICEDISABLEWAKE "$deviceMouse"
"`tCheck results..."
"`tDevices below are enabled for waking the system from a sleep state:"
POWERCFG /DEVICEQUERY wake_armed
Pause
