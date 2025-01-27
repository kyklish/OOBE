@ECHO OFF
CD /D "%~dp0"
CD "DRIVERS"

:: Save to registry current params
GuMonSet32.exe /R
