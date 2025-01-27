"Add RU keyboard..."

$lang = "ru-RU"
$LangList = Get-WinUserLanguageList
if (-not ($LangList.LanguageTag -contains $lang)) {
    $LangList.Add($lang)
    Set-WinUserLanguageList $LangList -Force
}

"Check results..."
Get-WinUserLanguageList
Pause
