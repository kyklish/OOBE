"Add ru-RU keyboard..."
# In Win10-Win11 LanguageTag contains general language code "ru", not "ru-RU", WHY???
#   [if (-not -contains)] fails and try add "ru-RU" again and again.
# "ru-BY", "ru-UA" works as intended, but "ru-RU" saves as general code "ru".
# $langCode = "ru-RU"
$langCode = "ru"
$langList = Get-WinUserLanguageList
if (-not ($langList.LanguageTag -contains $langCode)) {
    $langList.Add($langCode)
    Set-WinUserLanguageList $langList -Force
}

"Remove en-GB keyboard..."
$langCode = "en-GB"
if ($langList.LanguageTag -contains $langCode) {
    $langList = $langList | Where-Object { $_.LanguageTag -ne $langCode }
    Set-WinUserLanguageList $langList -Force
}

# Brute force method
# "Delete all and add en-US and ru-RU keyboards..."
# $langList = Get-WinUserLanguageList
# $langList.Clear()
# $langList.Add("en-US")
# $langList.Add("ru-RU")
# Set-WinUserLanguageList $langList -Force

"`n"
"Check results..."
Get-WinUserLanguageList
Pause
