"SystemLocale: [ru-RU] Language for non-Unicode programs..."
Set-WinSystemLocale "ru-RU"
"Culture: [en-GB] Monday, 24-Hour, dd-MM-yyyy..."
Set-Culture "en-GB"
"HomeLocation: [Ukraine] Country or region..."
Set-WinHomeLocation -GeoId 241
"TimeZone: [(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius] Time zone..."
Set-TimeZone -Id "FLE Standard Time"

"Disable Windows to override your culture with the display language at logon..."
Set-WinCultureFromLanguageListOptOut -OptOut $True
"Disable Windows to dynamically determine the display language from the language list of the user and set [en-US] no-matter-what display language..."
Set-WinUILanguageOverride -Language "en-US"

"Apply these settings to the Welcome Screen, System Accounts and New User profiles..."
# Copies the current user's international settings (Windows Display language, Input language,
#  Regional Format/locale, and Location/GeoID) to one or both of the following:
#   * Welcome screen and system accounts
#   * New user accounts
# Note: This cmdlet is specific to Windows 11 and recent Windows Server versions.
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True

# GUI Alternative
# Control Panel > Region > Administrative > Copy Settings

Pause
