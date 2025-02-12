"Add [Open TotalCMD here] to context menu..."

$cmd = "$env:SOFT\TotalCmd_IT_x64\TOTALCMD.EXE"
$msg = "Open TotalCMD here"

$path = "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\TotalCMD"
New-Item -Path $path -Force
New-ItemProperty -Path $path -Name "(Default)" -Value $msg
New-ItemProperty -Path $path -Name "Icon" -Value $cmd
$path = "$path\command"
New-Item -Path $path -Force
New-ItemProperty -Path $path -Name "(Default)" -Value "$cmd `"%V`""

$path = "Registry::HKEY_CLASSES_ROOT\Directory\shell\TotalCMD"
New-Item -Path $path -Force
New-ItemProperty -Path $path -Name "(Default)" -Value $msg
New-ItemProperty -Path $path -Name "Icon" -Value $cmd
$path = "$path\command"
New-Item -Path $path -Force
New-ItemProperty -Path $path -Name "(Default)" -Value "$cmd `"%1`""

# Source
# Windows Registry Editor Version 5.00

# [HKEY_CLASSES_ROOT\Directory\Background\shell\TotalCMD]
# @="Open TotalCMD here"
# "Icon"="F:\\PORTABLE\\TotalCmd_IT_x64\\TOTALCMD.EXE"

# [HKEY_CLASSES_ROOT\Directory\Background\shell\TotalCMD\command]
# @="F:\\PORTABLE\\TotalCmd_IT_x64\\TOTALCMD.EXE \"%V\""

# [HKEY_CLASSES_ROOT\Directory\shell\TotalCMD]
# @="Open TotalCMD here"
# "Icon"="F:\\PORTABLE\\TotalCmd_IT_x64\\TOTALCMD.EXE"

# [HKEY_CLASSES_ROOT\Directory\shell\TotalCMD\command]
# @="F:\\PORTABLE\\TotalCmd_IT_x64\\TOTALCMD.EXE \"%1\""
