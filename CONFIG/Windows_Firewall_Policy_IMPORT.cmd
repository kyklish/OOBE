@ECHO OFF
CD /D "%~dp0"
netsh netsh advfirewall import "Windows_Firewall_Policy.wfw"
PAUSE
