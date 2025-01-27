@ECHO OFF
CD /D "%SystemRoot%\SystemApps"

ECHO ==== Kill processes below permanently ====
ECHO [Win+Space] hotkey will work [but not show pop-up window]
ECHO SearchHost.exe
ECHO ShellExperienceHost.exe
ECHO StartMenuExperienceHost.exe [Start Menu: use Open-Shell]
ECHO TextInputHost.exe [Clipboard History: use Clipdiary]

ECHO.
ECHO ==== [SFC /SCANNOW] will repair all files ====

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

ECHO ==== If TASKKILL can't kill fast enough, use Process Lasso (Disallow Process) ====

PAUSE
