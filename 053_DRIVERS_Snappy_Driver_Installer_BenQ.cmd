@ECHO OFF
CD /D "%~dp0"
CD ".\DRIVERS\Snappy_Driver_Installer_BenQ"
START "" drv.exe -autoinstall -autoclose
