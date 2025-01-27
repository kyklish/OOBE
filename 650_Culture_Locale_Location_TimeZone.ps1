"SystemLocale: [ru-RU] Language for non-Unicode programs..."
Set-WinSystemLocale "ru-RU"
"Culture: [en-GB] Monday, 24-Hour, dd-MM-yyyy..."
Set-Culture "en-GB"
"HomeLocation: [Ukraine] Country or region..."
Set-WinHomeLocation -GeoId 241
"TimeZone: [(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius] Time zone..."
Set-TimeZone -Id "FLE Standard Time"

"Disabling Windows to override your culture with the display language at logon..."
Set-WinCultureFromLanguageListOptOut -OptOut $True
"Disabling Windows to dynamically determine the display language from the language list of the user and set [en-US] no-matter-what display language..."
Set-WinUILanguageOverride -Language "en-US"

"Applying these settings to the [Welcome Screen], [System Accounts] and [New User Profiles]..."
if ([System.Environment]::OSVersion.Version.Build -ge 22000) {
    # Windows 11
    # Copies the current user's international settings (Windows Display language,
    #  Input language, Regional Format/locale, and Location/GeoID) to one or both
    #  of the following:
    #   * Welcome screen and system accounts
    #   * New user accounts
    Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True
} else {
    # Windows 10
    Write-Warning "In Windows 10 you can't do that from PowerShell, use GUI method!"
    Write-Warning "Gui method works for Windows 10 and Windows 11."
    Write-Warning "Control Panel > Region > Administrative > Copy Settings"
    Write-Warning "              intl.cpl > Administrative > Copy Settings"
    Write-Warning "Shortcut for that is next file in OOBE."
}

Pause
