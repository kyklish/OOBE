@ECHO OFF
CD /D "%SOFT%\WPD"
:: Create [WPD Restore Point]
:: WPD.exe -restorePoint
:: Apply saved rules
WPD.bat

:: How to create (save current state) WPD.BAT:
:: WPD.exe -saveState
