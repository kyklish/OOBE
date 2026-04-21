@ECHO OFF
CD /D "%~dp0"
ECHO Create file with possible monitor settings...
ECHO Look in [DRIVERS] folder...
CD /D "DRIVERS"
GuMonSet32.exe /S
PAUSE
