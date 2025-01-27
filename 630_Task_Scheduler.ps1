"Create tasks in [Task Scheduler]..."

############################# STARTUP TASK EXAMPLE #############################

# Define the Task Action, Trigger, and Settings:
#   Action
# $action = New-ScheduledTaskAction -Execute "file.exe" -Argument "params"
#   Actions (multiple actions in the array)
# $actions = @()
# $actions += New-ScheduledTaskAction ...
# $actions += New-ScheduledTaskAction ...
#   Trigger                          Get-Help New-ScheduledTaskTrigger -detailed
# At logon of any user
# $trigger = New-ScheduledTaskTrigger -AtLogOn
# At logon of current user
# $trigger = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME
# Examples of daily and weekly triggers
# $trigger = New-ScheduledTaskTrigger -Daily -At 3am
# $trigger = New-ScheduledTaskTrigger -Daily -DaysInterval 3 -At 3am
# $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 3am
# $trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 2 -DaysOfWeek Sunday -At 3am
#   Settings
# $settings = New-ScheduledTaskSettingsSet `
    # -AllowStartIfOnBatteries:$true `
    # -DontStopIfGoingOnBatteries:$true `
    # -StartWhenAvailable:$true     # Enables the “Run task as soon as possible after a scheduled start is missed” setting.

# Wrap long commands across multiple lines using the backtick character (`).
# This character acts as a line continuation character in PowerShell.
# White space matters. The required format is [Space] [`] [Enter].
# Register-ScheduledTask `
#     -Action $action `
#     -Trigger $trigger `
#     -Settings $settings `
#     -TaskName "TaskName" `
#     -Description "Description" `
#     -RunLevel Highest `
#     -Force

#     -User "SYSTEM"
#     -RunLevel Highest

################################### TimeSync ###################################

$name = "@TimeSync"
Write-Output $name
$action = New-ScheduledTaskAction -Execute "$env:SOFT\TimeSync\timesync.exe" -Argument "/auto"
$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek "Sunday" -At "3am"
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable:$true
Register-ScheduledTask `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -TaskName $name `
    -Description "TimeSync - NIST Time Service - Ver 2.3x, Horst Schaeffer" `
    -RunLevel "Highest" `
    -Force

################################################################################

Pause
