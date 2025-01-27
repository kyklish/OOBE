"Set TIMEOUT & BATTERY_LEVEL settings for ALL Power Schemes..."

# Win11
$GUID_PowerSaver = "a1841308-3541-4fab-bc81-f71556f20b4a"
$GUID_Balanced = "381b4222-f694-41f0-9685-ff5bb260df2e"
$GUID_HighPerformance = "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c"
$GUID_UltimatePerformance = "e9a42b02-d5df-448d-aa00-03f14749eb61"

$GUID_AHK = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF"
$name = "AHK"

function Set-PowerPlanSettings {
    param (
        [string]$PowerSchemeGUID
        )

    POWERCFG /SETACTIVE $PowerSchemeGUID

    POWERCFG /CHANGE monitor-timeout-ac 45
    POWERCFG /CHANGE monitor-timeout-dc 45
    POWERCFG /CHANGE disk-timeout-ac 0
    POWERCFG /CHANGE disk-timeout-dc 0
    POWERCFG /CHANGE standby-timeout-ac 0
    POWERCFG /CHANGE standby-timeout-dc 0
    POWERCFG /CHANGE hibernate-timeout-ac 0
    POWERCFG /CHANGE hibernate-timeout-dc 0

    # BATFLAGSLOW & BATFLAGSCRIT: disable notification on low & critical battery level
    # POWERCFG /SETACVALUEINDEX SCHEME_CURRENT SUB_BATTERY BATLEVELLOW  50
    # POWERCFG /SETACVALUEINDEX SCHEME_CURRENT SUB_BATTERY BATLEVELCRIT 25
    # POWERCFG /SETACVALUEINDEX SCHEME_CURRENT SUB_BATTERY BATFLAGSLOW   0
    # POWERCFG /SETACVALUEINDEX SCHEME_CURRENT SUB_BATTERY BATFLAGSCRIT  0
    POWERCFG /SETDCVALUEINDEX SCHEME_CURRENT SUB_BATTERY BATLEVELLOW  50
    POWERCFG /SETDCVALUEINDEX SCHEME_CURRENT SUB_BATTERY BATLEVELCRIT 25
    POWERCFG /SETDCVALUEINDEX SCHEME_CURRENT SUB_BATTERY BATFLAGSLOW   0
    POWERCFG /SETDCVALUEINDEX SCHEME_CURRENT SUB_BATTERY BATFLAGSCRIT  0

    # Disabled (look above)
    # POWERCFG /SETACVALUEINDEX SCHEME_CURRENT SUB_DISK    DISKIDLE      0
    # POWERCFG /SETDCVALUEINDEX SCHEME_CURRENT SUB_DISK    DISKIDLE      0
}

Set-PowerPlanSettings -PowerSchemeGUID $GUID_PowerSaver
Set-PowerPlanSettings -PowerSchemeGUID $GUID_Balanced
Set-PowerPlanSettings -PowerSchemeGUID $GUID_HighPerformance
Set-PowerPlanSettings -PowerSchemeGUID $GUID_UltimatePerformance

"Duplicate 'Balanced' Power Scheme..."
"`tNew GUID: $GUID_AHK"
"`tNew Name: $name"

POWERCFG /DUPLICATESCHEME $GUID_Balanced $GUID_AHK
POWERCFG /CHANGENAME $GUID_AHK "$name" "Balanced power plan for AHK: CPU_Freq_Cores_Manager"

POWERCFG /SETACTIVE $GUID_AHK
"`n`n"
Pause
