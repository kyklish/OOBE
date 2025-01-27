@ECHO OFF
CD /D "%~dp0"
SET GuMonSet32=%CD%\DRIVERS\GuMonSet32.exe
ECHO Create file with possible monitor settings...
ECHO Look in [DRIVERS] folder...
CD /D "DRIVERS"
%GuMonSet32% /S
ECHO Look in [TEMP] folder...
CD /D "%TEMP%"
%GuMonSet32% /S
PAUSE
START "" Notepad "%TEMP%\GuMonSet32.txt"
