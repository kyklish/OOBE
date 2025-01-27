"Check environment variables for RAM DISK usage..."

function Print-EnvVar {
    param (
        [string]$Name
    )
    Write-Output "   User: $Name = $([System.Environment]::GetEnvironmentVariable($Name, [EnvironmentVariableTarget]::User))"
    Write-Output "Machine: $Name = $([System.Environment]::GetEnvironmentVariable($Name, [EnvironmentVariableTarget]::Machine))"
    Write-Output ""
}

Print-EnvVar -Name "TMP"
Print-EnvVar -Name "TEMP"
Pause
