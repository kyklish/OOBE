@ECHO Run this script only from true 64bit application, for example: Explorer...
@ECHO OFF

ECHO.
ECHO Enabling [System Protection] on disk [C:]...
PowerShell -NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "Enable-ComputerRestore -Drive C:"

ECHO.
ECHO Resizing disk space usage to 4GB...
:: MaxSizeSpec must be 320MB or greater
:: /MaxSize=4GB for absolute size
:: /MaxSize=5% for percentual sizes
:: /MaxSize=UNBOUNDED for unlimited size
vssadmin Resize ShadowStorage /For=C: /On=C: /MaxSize=4GB

PAUSE

:: "System32" folder is fully accessible only from true 64bit apps!
:: "Open a command prompt" shell extension from the 32bit Total Commander shell
::   will open the 32bit command shell!
