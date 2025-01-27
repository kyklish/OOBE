@ECHO Uncheck "Users must enter a user name and password to use this computer" checkbox...
@ECHO OFF

:: Enable "Users must enter a user name and password to use this computer" checkbox in "User Accounts"
:: Win11 (defalut value 0x00000002)
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\PasswordLess\Device" /v "DevicePasswordLessBuildVersion" /t REG_DWORD /d 0x00000000 /f /reg:64
IF %ERRORLEVEL% NEQ 0 (
    PAUSE
    EXIT
)

:: Open "User Accounts"
START "" netplwiz.exe
::START "" control userpasswords2
