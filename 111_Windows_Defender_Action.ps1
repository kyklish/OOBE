# Disable Tamper Protection before this script???

Set-MpPreference -LowThreatDefaultAction      Quarantine
Set-MpPreference -ModerateThreatDefaultAction Quarantine
Set-MpPreference -HighThreatDefaultAction     Quarantine
Set-MpPreference -SevereThreatDefaultAction   Quarantine
# Set-MpPreference -UnknownThreatDefaultAction  Quarantine
Pause

# Show Current Actions:
# Get-MpPreference | Select-Object *action
# Actions:
# 0 - Default Action (Microsoft Desire)
# 2 - Quarantine
# 3 - Delete
# 9 - Ignore
