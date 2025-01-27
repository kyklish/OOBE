@ECHO OFF
CD /D "%~dp0"
CD ..
FOR %%i IN ("*_LNK_Start_Menu.ps1") DO SET FileName=%%i
PowerShell -NoLogo -ExecutionPolicy RemoteSigned -File "%FileName%" || PAUSE
