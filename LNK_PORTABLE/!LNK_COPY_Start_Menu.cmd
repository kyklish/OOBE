@ECHO OFF
CD /D "%~dp0"
CD ..
REM FOR %%i IN ("*_LNK_Start_Menu.ps1") DO SET FileName=%CD%\%%i
FOR %%i IN ("*_LNK_Start_Menu.ps1") DO SET FileName=%%i
"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -ExecutionPolicy RemoteSigned -File "%FileName%" || PAUSE
