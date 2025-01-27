@ECHO OFF
CD /D "%~dp0"
CD ".\DRIVERS\NVIDIA_Driver"

ECHO Install [RAM DISK] and move [TEMP] folder there before installing driver.
ECHO Installer will unpack more then 2GB in [TEMP] folder.
ECHO [TEMP] = %TEMP%
SET /P answer="Do you want to continue (y/N)? "
IF /I "%answer%"=="y" GOTO :CONTINUE
GOTO :EOF

:CONTINUE
EXE_Install_Express.cmd
PAUSE
