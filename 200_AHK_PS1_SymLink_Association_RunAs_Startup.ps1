# MKLINK creates links, but files does not launch from them :(
# USE PowerShell to create this links!
# %ProgramW6432% ==> C:\Program Files
#     only available when running under a 64 bit OS
# %ProgramFiles% ==> C:\Program Files or C:\Program Files (x86)
#     32 bit programs on 32 bit systems "C:\Program Files"
#     64 bit programs on 64 bit systems "C:\Program Files"
#     32 bit programs on 64 bit systems "C:\Program Files (x86)"
#     CMD.EXE is 32 bit??? It points to "C:\Program Files (x86)"!
# %ProgramFiles(x86)% ==> "C:\Program Files (x86)"
#     only available when running under a 64 bit OS

# Test-Path env:SOFT_AHK is correct call!
#   Test-Path  env:VARIABLE_EXIST     ==> true / false
#   Test-Path  env:VARIABLE_NOT_EXIST ==> false
#   Test-Path $env:VARIABLE_EXIST     ==> true / false
#   Test-Path $env:VARIABLE_NOT_EXIST ==> ERROR
if (-Not (Test-Path env:SOFT_AHK)) {
    "Set environment variables before running this script!"
    "Run XXX_Environment_Variables_SOFT_AHK_BAT.ps1 before this script!"
    Pause
    Exit
}

############################ AHK STARTUP SCRIPT ################################

# Example: [%SOFT_AHK%] == [F:\PORTABLE\_AutoHotkey_]
$ahkStartupScript = "$env:SOFT_AHK\Scripts\_AutoHotkey_.ahk"

############### EXE DESTINATION (C:\Program Files\AutoHotkey) ##################

# Using [%SOFT_AHK%\AutoHotkey.exe] as source. Must be renamed [AutoHotkeyU64.exe].

$appPath = "$env:ProgramW6432\AutoHotkey"

# In PowerShell, single-quoted strings are treated as literal strings, meaning
#   that variables inside them are not expanded. If you want to expand a variable
#   inside a string, you should use double quotes instead.
# ["%1"] is script's full path and [%*] all other parameters, that passed to script.
$ahkCommand = "`"$appPath\AutoHotkey.exe`" `"%1`" %*"
$ps1Command = "`"$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe`" `"%1`" %*"

############################### SYMBOLIC LINKS #################################

"Create [AutoHotkey] symbolic links into [$env:ProgramW6432] folder..."
if (-Not (Test-Path -Path $appPath -PathType "Container")) {
    New-Item -ItemType "Directory" -Path $appPath
}
# -Force == overwrite
New-Item -ItemType "SymbolicLink" -Path "$appPath\AutoHotkey.exe" -Target "$env:SOFT_AHK\AutoHotkey.exe" -Force
New-Item -ItemType "SymbolicLink" -Path "$appPath\AutoHotkey.chm" -Target "$env:SOFT_AHK\AutoHotkey.chm" -Force
New-Item -ItemType "SymbolicLink" -Path "$appPath\WindowSpy.ahk" -Target "$env:SOFT_AHK\Tools\WindowSpy.ahk" -Force

#### DIRTY FIX ####

# VS Code (Debug) uses [AutoHotkey.exe]
# VS Code (AHK++) uses [AutoHotkeyU64.exe], so add this dirty fix
New-Item -ItemType "SymbolicLink" -Path "$appPath\AutoHotkeyU64.exe" -Target "$env:SOFT_AHK\AutoHotkey.exe" -Force
Pause

############################ AHK FILE ASSOCIATIONS #############################

"Create association for [AHK] files..."
# Example:
#   [.txt] and [.log] file extensions are [txtfile] file type
#   [txtfile] file type is opened by [notepad.exe] application
#   We can change application for all [txtfile] file types and don't touch file extensions
# See [assoc] and [ftype] info for help
function Set-DefaultAppForFileType {
    param (
        [string]$FileExtension,
        [string]$FileType,
        [string]$ApplicationCommand
    )

    # NOT WORK in Windows 11!!!
    # [assoc] WORKS
    # [ftype] NOT WORKS!!!

    # [assoc] and [ftype] are built-in functionality of [cmd.exe]
    # They can't be invoked in PowerShell directly!
    # Use assoc to associate the file extension with the file type
    # $assocCommand = "cmd /c assoc $FileExtension=$FileType"
    # Invoke-Expression $assocCommand

    # [`] is escape character in PowerShell
    # Use ftype to define how files with this ProgID should be opened
    # $ftypeCommand = "cmd /c ftype $FileType=$ApplicationCommand"
    # Invoke-Expression $ftypeCommand

    # Create all registry changes manually
    # File extension: HKCR:\.ahk
    $path = "Registry::HKEY_CLASSES_ROOT\$FileExtension"
    New-Item -Path $path -Force
    New-ItemProperty -Path $path -Name "(Default)" -Value $FileType
    # File type: HKCR:\ahkfile with open command
    $path = "Registry::HKEY_CLASSES_ROOT\$FileType\shell\open\command"
    New-Item -Path $path -Force
    New-ItemProperty -Path $path -Name "(Default)" -Value $ApplicationCommand
    # Example from Windows: [.bat] ==> [batfile] ==> [batfile=cmd.exe "%1" %*]
    # ["%1"] is script's full path and [%*] all other parameters, that passed to script.
}

Set-DefaultAppForFileType -FileExtension ".ahk" -FileType "ahkfile" -ApplicationCommand $ahkCommand
Pause

############################ RUN AS ADMINISTRATOR ##############################

"Add [Run as administrator] in context menu for [ahkfile] file type..."
"Add [Run as administrator] in context menu for [Microsoft.PowerShellScript.1] file type..."

function Set-RunAsAdminForFileType {
    param (
        [string]$FileType,
        [string]$ApplicationCommand
    )

    $path = "Registry::HKEY_CLASSES_ROOT\$FileType\shell\runas"
    New-Item -Path $path -Force
    New-ItemProperty -Path $path -Name "(Default)" -Value "Run as administrator"
    $path = "$path\command"
    New-Item -Path $path -Force
    New-ItemProperty -Path $path -Name "(Default)" -Value $ApplicationCommand
}

Set-RunAsAdminForFileType -FileType "ahkfile" -ApplicationCommand $ahkCommand
Set-RunAsAdminForFileType -FileType "Microsoft.PowerShellScript.1" -ApplicationCommand $ps1Command
Pause

###################### LNK TO STARTUP FOLDER (OBSOLETE) ########################

# "Create shortcut in [Startup] folder..."
# For current user
# $filePath = "$env:AppData\Microsoft\Windows\Start Menu\Programs\Startup\AutoHotkey.lnk"
# For all users
# $filePath = "$env:AllUsersProfile\Microsoft\Windows\Start Menu\Programs\Startup\AutoHotkey.lnk"
# if (-Not (Test-Path -Path $filePath)) {
#     Copy-Item -Path "AutoHotkey_Startup_Shortcut.lnk" -Destination $filePath
# }
# Pause

############################### AHK STARTUP TASK ###############################

"Create autostart task in [Task Scheduler]..."

# Define the Task Action, Trigger, and Settings:
# You can add this if you need it: -Argument "PassSomeArgumentToScript"
$action = New-ScheduledTaskAction -Execute $ahkStartupScript
# At logon of any user
# $trigger = New-ScheduledTaskTrigger -AtLogOn
# At logon of current user (who run this script)
$trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME
$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries:$true `
    -DontStopIfGoingOnBatteries:$true

# Wrap long commands across multiple lines using the backtick character (`).
# This character acts as a line continuation character in PowerShell.
# White space matters. The required format is [Space] [`] [Enter].
Register-ScheduledTask `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -TaskName "@AutoHotkey" `
    -Description "AutoHotkey Startup Script" `
    -RunLevel "Highest" `
    -Force
Pause

################################################################################
