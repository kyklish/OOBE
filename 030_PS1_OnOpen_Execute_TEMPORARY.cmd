@ECHO Changing default action for PS1 from opening in [Windows PowerShell ISE] to execute...
@ECHO OFF

:: [^] symbol as a line continuation with REG ADD may be unreliable in Windows 10 because of stricter argument parsing.
:: Windows 11 relaxed this, so it works there.
:: This script works in Windows 10 too, will not change to single line.

:: Windows 10 CMD very strict about how quotes are escaped. Triple quotes (""") confuse the parser.
:: Instead of triple quotes, use backslash to escape quotes: (\").
:: Windows 11 CMD parses triple quotes (""") just fine.

:: "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -ExecutionPolicy RemoteSigned -File "%1"
SET PS=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe
REG ADD "HKCR\Microsoft.PowerShellScript.1\Shell\Open\Command" /ve /t REG_SZ ^
    /d "\"%PS%\" -NoLogo -ExecutionPolicy RemoteSigned -File \"%%1\"" /f /reg:64
:: IF %ERRORLEVEL% NEQ 0 (
::     PAUSE
::     EXIT /B
:: )
PAUSE
