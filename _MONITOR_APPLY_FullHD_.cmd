@ECHO OFF
CD /D "%~dp0"
:: .\DRIVERS\nircmd.exe setdisplay monitor:0 1920 1080 32 60 -allusers -updatereg
:: .\DRIVERS\nircmd.exe setdisplay 1920 1080 32 60 -allusers -updatereg

.\DRIVERS\GuMonSet32.exe 1920 1080 32 60
