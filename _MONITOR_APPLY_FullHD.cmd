@ECHO OFF
CD /D "%~dp0"
CD "DRIVERS"

:: On first boot monitor has problem with resolution changing from command line.
:: After first successful resolution change all programs works.

:: FAILS: resolution not changed
:: nircmd.exe setdisplay 1920 1080 32 60 -allusers
:: Save to registry
:: nircmd.exe setdisplay 1920 1080 32 60 -allusers -updatereg

:: FAILS: shows only 4 supported resolutions with wierd 64Hz regresh rate
:: GuMonSet32.exe 1920 1080 32 60
:: Save to registry
:: GuMonSet32.exe /R

:: FAILS: MSVCP120.dll was not found.
:: ChangeScreenResolution.exe /w=1920 /h=1080 /f=60 b=32
:: Save to registry
:: ChangeScreenResolution.exe /force

:: FAILS: shows only 4 supported resolutions with wierd 64Hz regresh rate
:: SetResolution SET -w 1920 -h 1080 -f 60 -noprompt -nopersist
:: Save to registry
:: SetResolution SET -w 1920 -h 1080 -f 60 -noprompt

:: 64Hz in settings changes to 60Hz after NVIDIA Driver Installed
GuMonSet32.exe 1920 1080 32 64
