"Set default action on open PS1 to edit in Windows PowerShell ISE..."

# Default editor is classic Notepad
# $editor = "$env:SystemRoot\System32\notepad.exe"
# Windows PowerShell ISE
$editor = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell_ise.exe"
Set-ItemProperty `
    -Path "Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\Open\Command" `
    -Name "(Default)" `
    -Value "`"$editor`" `"%1`""
Pause
