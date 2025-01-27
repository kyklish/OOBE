"Disable Tamper Protection before using this script!"
"Set default action to [Quarantine]..."

Set-MpPreference -LowThreatDefaultAction      Quarantine
Set-MpPreference -ModerateThreatDefaultAction Quarantine
Set-MpPreference -HighThreatDefaultAction     Quarantine
Set-MpPreference -SevereThreatDefaultAction   Quarantine
Set-MpPreference -UnknownThreatDefaultAction  Quarantine


"Check results... (2 == Quarantine)"
# Show Current Actions:
Get-MpPreference | Select-Object *action
# Actions:
# 0 - Default Action (Microsoft Desire)
# 2 - Quarantine
# 3 - Delete
# 9 - Ignore


Pause
