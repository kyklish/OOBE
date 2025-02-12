"Set default action on open PS1 to execute..."

$ps = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
Set-ItemProperty `
    -Path "Registry::HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\Open\Command" `
    -Name "(Default)" `
    -Value "`"$ps`" -NoLogo -ExecutionPolicy RemoteSigned -File `"%1`""
Pause
