"Set TIMEOUT settings for 'Balanced' Power Scheme..."

$GUID_AHK = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF"
$GUID_Balanced = "381b4222-f694-41f0-9685-ff5bb260df2e"
$name = "AHK"

POWERCFG /SETACTIVE $GUID_Balanced
POWERCFG /CHANGE monitor-timeout-ac 45
POWERCFG /CHANGE disk-timeout-ac 0
POWERCFG /CHANGE standby-timeout-ac 0
POWERCFG /CHANGE hibernate-timeout-ac 0

"Duplicate 'Balanced' Power Scheme..."
"New GUID: $GUID_AHK"
"New Name: $name"

POWERCFG /DUPLICATESCHEME $GUID_Balanced $GUID_AHK
POWERCFG /CHANGENAME $GUID_AHK "$name" "Balanced power plan for AHK: CPU_Freq_Cores_Manager"
Pause
