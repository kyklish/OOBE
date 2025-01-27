"Check environment variables for [RAM DISK] usage..."

function Show-EnvVar {
    param (
        [string]$Name
    )
    Write-Output "   User: $Name = $([System.Environment]::GetEnvironmentVariable($Name, [EnvironmentVariableTarget]::User))"
    Write-Output "Machine: $Name = $([System.Environment]::GetEnvironmentVariable($Name, [EnvironmentVariableTarget]::Machine))"
    Write-Output ""
}

Show-EnvVar -Name "TMP"
Show-EnvVar -Name "TEMP"

Pause
