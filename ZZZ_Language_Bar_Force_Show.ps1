# GUI
# Settings (Win+I) >>> Time & language >>> Typing >>> Advanced keyboard settings >>> Override for default input method / Switching input methods / Language bar options

# $langList = New-WinUserLanguageList -Language "en-US"
# $langList.Add("ru-RU")
# Set-WinUserLanguageList $langList -Force
# Get-WinUserLanguageList
# Pause

# OR

# $langList = Get-WinUserLanguageList
# Set-WinUserLanguageList $langList -Force
# Get-WinUserLanguageList
# Pause

# OR

# Set-WinDefaultInputMethodOverride -InputTip "0409:00000409" # en-US
# Set-WinDefaultInputMethodOverride -InputTip "0419:00000419" # ru-RU
# Get-WinDefaultInputMethodOverride
# Pause

# Reset to default behaviour: run command without params
# Set-WinDefaultInputMethodOverride
