@ECHO OFF
CD /D "%~dp0"

:: Usage:
::  CALL :CreateShortcut "MyShortcut" "C:\Folder"
::  CALL :CreateShortcut "MyShortcut" "C:\Path\Program.exe" ["Arguments"]
::  CALL :CreateShortcut "My Shortcut" "C:\Path to prog\Program.exe" ["""Arg 1"" Arg 2"""]
:: SPACES: no need for double quotes in ShortcutName and TargetPath.
:: SPACES: add double quotes in Arguments.

:: Copy entire [Q-Dir] folder to fix issues with admin rights in [VirtualBox].
:: ROBOCOPY "%CD%\DRIVERS\Q-Dir" "%USERPROFILE%\Desktop"
XCOPY "%CD%\DRIVERS\Q-Dir" "%USERPROFILE%\Desktop\Q-Dir" /I

CALL :CreateShortcut "Q-Dir" "%USERPROFILE%\Desktop\Q-Dir\Q-Dir_x64.exe" """%CD%"""
CALL :CreateShortcut "OOBE" "%CD%"
PAUSE
GOTO :EOF

:CreateShortcut
:: %~1 = ShortcutName (on Desktop) without LNK exstension
:: %~2 = TargetPath
:: %~3 = Arguments (optional)
SET SHORTCUT=%USERPROFILE%\Desktop\%~1.lnk
SET WORKDIR=%~dp2
SET TARGET=%~2
SET ARGS=%~3

:: Create a temporary VBScript
:: CreateShortcut() handles spaces in TargetPath and WorkingDirectory automatically,
::  no need for quotes, but Arguments is another deal...
SET VBS=%TEMP%\MakeLink.vbs
ECHO Set oWS = WScript.CreateObject("WScript.Shell") > "%VBS%"
ECHO Set oLink = oWS.CreateShortcut("%SHORTCUT%") >> "%VBS%"
ECHO oLink.TargetPath = "%TARGET%" >> "%VBS%"
ECHO oLink.Arguments = "%ARGS%" >> "%VBS%"
ECHO oLink.WorkingDirectory = "%WORKDIR%" >> "%VBS%"
ECHO oLink.Save >> "%VBS%"

:: Run the VBScript
CSCRIPT //nologo "%VBS%"
DEL "%VBS%"
EXIT /B
