############### Set working directory to the script's directory ################
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Set-Location -Path $scriptDir
################################################################################

"Add applications to [Open with] & [Select the app to open this file]..."

function Add-OpenWith {
    param (
        [string]$AppFullName
    )

    # Get FileName.exe without double quotes:
    # [System.IO.Path]::GetFileNameWithoutExtension("C:\Example\Reports\summary.txt")
    #     Returns: summary
    # (Get-Item "C:\Example\Reports\summary.txt").BaseName
    #     .BaseName gives the file name without extension (summary).
    #     .Name would give summary.txt.
    # Split-Path -Path "C:\Example\Reports\summary.txt" -LeafBase
    #     -LeafBase returns only the file name without extension (summary). ONLY IN PowerShell 6.0! Check your version: $PSVersionTable.PSVersion
    #     -Leaf would include the extension (summary.txt).

    $appName = Split-Path -Path $AppFullName -Leaf
    $commandPath = "Registry::HKEY_CLASSES_ROOT\Applications\$appName\shell\open\command"
    $commandValue = $AppFullName + " ""%1"""
    New-Item -Path $commandPath -Force | Out-Null
    Set-Item -Path $commandPath -Value $commandValue
}

function Set-DefaultAppForFileType {
    param (
        [string]$AppFullName,
        [string]$FileExtension
    )

    $appNameNoExt = [System.IO.Path]::GetFileNameWithoutExtension($AppFullName)
    $fileType = $appNameNoExt + "File"

    # All comments here: 200_AHK_PS1_SymLink_Association_RunAs_Startup.ps1
    $extensionPath = "Registry::HKEY_CLASSES_ROOT\$FileExtension"
    New-Item -Path $extensionPath -Force | Out-Null
    Set-Item -Path $extensionPath -Value $fileType

    $commandPath = "Registry::HKEY_CLASSES_ROOT\$fileType\shell\open\command"
    $commandValue = $AppFullName + " ""%1"""
    New-Item -Path $commandPath -Force | Out-Null
    Set-Item -Path $commandPath -Value $commandValue
}

# "Open_With_Applications.CSV" example:
# "AppFullName","FileExtension"
# "%SOFT%\1by1\1by1.exe",".mp3"
# "%SOFT%\1by1\1by1.exe",".flac"

$apps = Import-Csv -Path ".\CONFIG\Open_With_Applications.csv" | Where-Object { $_.Path -notlike '#*' }

foreach ($app in $apps) {
    $app.AppFullName = [System.Environment]::ExpandEnvironmentVariables($app.AppFullName.Trim())
    Add-OpenWith -AppFullName $app.AppFullName
    Set-DefaultAppForFileType -AppFullName $app.AppFullName -FileExtension $app.FileExtension.Trim()
}

Pause
