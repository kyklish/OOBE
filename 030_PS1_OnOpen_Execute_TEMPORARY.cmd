@ECHO Set default action on open PS1 to execute...
@ECHO OFF

:: "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -ExecutionPolicy RemoteSigned -File "%1"
SET PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe
REG ADD "HKCR\Microsoft.PowerShellScript.1\Shell\Open\Command" /ve /t REG_SZ ^
    /d """%PS%"" -NoLogo -ExecutionPolicy RemoteSigned -File ""%%1""" /f /reg:64
:: IF %ERRORLEVEL% NEQ 0 (
::     PAUSE
::     EXIT /B
:: )
PAUSE
