# Look down below for source REG file
"Add [Open TotalCMD here] to context menu..."

################################################################################

function Set-ExplorerFolderContextMenuEx {
    param (
        [string]$Context,
        [string]$Exe,
        [string]$Message,
        [string]$RegName # Must be unique for each app
    )

    if ($Context -eq "Background") {
        $path = "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\$RegName"
        $cmd = "$Exe `"%V`""
    } else {
        $path = "Registry::HKEY_CLASSES_ROOT\Directory\shell\$RegName"
        $cmd = "$Exe `"%1`""
    }

    New-Item -Path $path -Force
    New-ItemProperty -Path $path -Name "(Default)" -Value $Message
    New-ItemProperty -Path $path -Name "Icon" -Value $Exe
    $path = "$path\command"
    New-Item -Path $path -Force
    New-ItemProperty -Path $path -Name "(Default)" -Value $cmd
}

################################################################################

function Set-ExplorerFolderContextMenu {
    param (
        [string]$Exe,
        [string]$Message,
        [string]$RegName
    )

    Set-ExplorerFolderContextMenuEx -Exe $Exe -Message $Message -RegName $RegName -Context ""
    Set-ExplorerFolderContextMenuEx -Exe $Exe -Message $Message -RegName $RegName -Context "Background"
}

##################### ADD APPS TO DIRECTORY'S CONTEXT MENU #####################

Set-ExplorerFolderContextMenu `
    -Exe "$env:SOFT\Total_Commander_IT_Edition\TOTALCMD.EXE" `
    -Message "Open TotalCMD here" `
    -RegName "TotalCMD"
Pause

################################################################################

# $cmd = "$env:SOFT\Total_Commander_IT_Edition\TOTALCMD.EXE"
# $msg = "Open TotalCMD here"

# $path = "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\TotalCMD"
# New-Item -Path $path -Force
# New-ItemProperty -Path $path -Name "(Default)" -Value $msg
# New-ItemProperty -Path $path -Name "Icon" -Value $cmd
# $path = "$path\command"
# New-Item -Path $path -Force
# New-ItemProperty -Path $path -Name "(Default)" -Value "$cmd `"%V`""

# $path = "Registry::HKEY_CLASSES_ROOT\Directory\shell\TotalCMD"
# New-Item -Path $path -Force
# New-ItemProperty -Path $path -Name "(Default)" -Value $msg
# New-ItemProperty -Path $path -Name "Icon" -Value $cmd
# $path = "$path\command"
# New-Item -Path $path -Force
# New-ItemProperty -Path $path -Name "(Default)" -Value "$cmd `"%1`""

# Pause

################################################################################

<#
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\Background\shell\TotalCMD]
@="Open TotalCMD here"
"Icon"="F:\\PORTABLE\\Total_Commander_IT_Edition\\TOTALCMD.EXE"

[HKEY_CLASSES_ROOT\Directory\Background\shell\TotalCMD\command]
@="F:\\PORTABLE\\Total_Commander_IT_Edition\\TOTALCMD.EXE \"%V\""

[HKEY_CLASSES_ROOT\Directory\shell\TotalCMD]
@="Open TotalCMD here"
"Icon"="F:\\PORTABLE\\Total_Commander_IT_Edition\\TOTALCMD.EXE"

[HKEY_CLASSES_ROOT\Directory\shell\TotalCMD\command]
@="F:\\PORTABLE\\Total_Commander_IT_Edition\\TOTALCMD.EXE \"%1\""
#>

################################################################################
