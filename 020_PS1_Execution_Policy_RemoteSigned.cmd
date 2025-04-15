:: Set Execution Policy for PS1 to RemoteSigned for CurrentUser
@ECHO OFF
SET PS="%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -Command
%PS% "& {Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force}"
%PS% "& {Get-ExecutionPolicy -List}"
ECHO If CurrentUser is RemoteSigned then OK
PAUSE
