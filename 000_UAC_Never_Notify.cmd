:: On Win11 [set _Args=%*] command works strange.
:: When script executes without params it returns [ECHO is OFF]: output of the first string of this script.
:: When script executes with params it works fine.
:: I got remove args code, because this script does not use params.

@ECHO OFF
SetLocal

REM ----------------------------------------------------------------------------
REM Test if Admin
    CALL net session >nul 2>&1
    IF %ERRORLEVEL% == 0 GOTO :START

REM Create and run a temporary VBScript to elevate this batch file
    SET _batchFile=%~f0
    REM Double up any quotes
    SET _batchFile=""%_batchFile:"=%""

    ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\~GetAdmin.vbs"
    ECHO UAC.ShellExecute "cmd", "/c ""%_batchFile%""", "", "runas", 1 >> "%temp%\~GetAdmin.vbs"

    cscript "%temp%\~GetAdmin.vbs" > nul
    DEL "%temp%\~GetAdmin.vbs"
    EXIT /B
REM ----------------------------------------------------------------------------

:START
:: set the current directory to the batch file location
CD /D "%~dp0"
:: Place the code which requires Admin/elevation below
ECHO We are now running as admin

SET X=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
reg.exe add %X% /V "EnableLUA" /T REG_DWORD /D 1 /F
reg.exe add %X% /V "ConsentPromptBehaviorAdmin" /T REG_DWORD /D 0 /F
reg.exe add %X% /V "PromptOnSecureDesktop" /T REG_DWORD /D 0 /F
PAUSE
