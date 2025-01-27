@ECHO OFF
CD /D "%~dp0"
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoLogo -ExecutionPolicy RemoteSigned -File "..\220_LNK_Start_Menu.ps1"
