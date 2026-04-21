@ECHO OFF
CD /D "%SystemRoot%\SystemApps"

ECHO ==== [Process Lasso (Disallow Process)] ====
ECHO 1. Simple usage with same results
ECHO 1.1. [Process Lasso] - [Options] - [Control] - [Dissalowed Processes...]
ECHO 1.2. [Process Lasso] - Right Click - [Dissalow Process]
ECHO 2. Exit [Process Lasso] to stop killing processes
ECHO 3. Better alternative to this script
ECHO.

ECHO ==== Kill processes below permanently ====
ECHO SearchHost.exe
ECHO ShellExperienceHost.exe
ECHO StartMenuExperienceHost.exe [Start Menu: use Open-Shell]
ECHO TextInputHost.exe [Clipboard History: use Clipdiary]
ECHO 1. [Notifications] stops working
ECHO 2. Right click on app in taskbar stops working
ECHO 3. [Win+Space] hotkey will work but not show pop-up window
ECHO 4. [Windows Defender] GUI stops working
ECHO 5. [Bluetooth Add Device] GUI stops working

ECHO.
ECHO ==== Full list of the EXE files see in 680_*.LST files ====

ECHO.
ECHO ==== [SFC /SCANNOW] will repair all files ====

SET /P answer="Do you want to continue (y/N)? "
IF /I "%answer%"=="y" GOTO :CONTINUE
GOTO :EOF

:CONTINUE

ECHO.
ECHO ==== Take ownership ====
TAKEOWN /F "Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy"
TAKEOWN /F "MicrosoftWindows.Client.CBS_cw5n1h2txyewy"
TAKEOWN /F "ShellExperienceHost_cw5n1h2txyewy"

ECHO.
ECHO ==== Grant permission: FULL CONTROL ====
ICACLS "Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy" /inheritance:r /grant:r %UserName%:F
ICACLS "MicrosoftWindows.Client.CBS_cw5n1h2txyewy" /inheritance:r /grant:r %UserName%:F
ICACLS "ShellExperienceHost_cw5n1h2txyewy" /inheritance:r /grant:r %UserName%:F

ECHO.
ECHO ==== Kill processes and rename directories ====
TASKKILL /IM "StartMenuExperienceHost.exe" /F
MOVE "Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy" "_OLD_Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy"

TASKKILL /IM "CrossDeviceResume.exe" /F
TASKKILL /IM "SearchHost.exe" /F
TASKKILL /IM "TextInputHost.exe" /F
MOVE "MicrosoftWindows.Client.CBS_cw5n1h2txyewy" "_OLD_MicrosoftWindows.Client.CBS_cw5n1h2txyewy"

TASKKILL /IM "ShellExperienceHost.exe" /F
MOVE "ShellExperienceHost_cw5n1h2txyewy" "_OLD_ShellExperienceHost_cw5n1h2txyewy"

ECHO ==== If TASKKILL can't kill fast enough, use [Process Lasso (Disallow Process)] ====

PAUSE
