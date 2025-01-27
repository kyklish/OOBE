@ECHO OFF
CD /D "%~dp0"
netsh advfirewall import "Windows_Firewall_Policy.wfw"
PAUSE
