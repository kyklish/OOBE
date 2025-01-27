@ECHO Setting [Execution Policy] for PS1 to [RemoteSigned] for [CurrentUser]...
@ECHO OFF
SET PS=PowerShell -NoLogo -NoProfile -Command
%PS% "& {Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force}"
%PS% "& {Get-ExecutionPolicy -List}"
ECHO If [CurrentUser] is [RemoteSigned] then OK
PAUSE
