"Changing default action for PS1 from executing to editing in [Windows PowerShell ISE]..."

# "C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe" "%1"
# Default editor is classic Notepad
# $editor = "$env:SystemRoot\System32\notepad.exe"
# Windows PowerShell ISE
$editor = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell_ise.exe"
$commandPath = "Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\Open\Command"
Set-Item -Path $commandPath -Value """$editor"" ""%1"""

Pause
