@ECHO OFF
CD /D "%~dp0"
ECHO Delete all WFC recommended rules before exporting!
netsh advfirewall export "Windows_Firewall_Policy.wfw"
PAUSE
