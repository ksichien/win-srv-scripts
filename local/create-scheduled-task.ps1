#!/usr/bin/env pwsh

function create-scheduled-task ([string]$path, [string]$time, [string]$name) {
    $utility = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
    $action = New-ScheduledTaskAction -Execute $utility -Argument "-NonInteractive -NoLogo -NoProfile -File $file"
    $trigger = New-ScheduledTaskTrigger -Daily -At $time

    Register-ScheduledTask -Action $action  -Trigger $trigger -TaskName $name -User 'System' -RunLevel Highest
}

do {
    Write-Output 'Please provide the following information for the new scheduled task:'
    $path = Read-Host -Prompt 'Script file path'
    $time = Read-Host -Prompt 'Script execution time'
    $name = Read-Host -Prompt 'Scheduled task name'

    create-scheduled-task $path $time $name

    $continue = Read-Host -Prompt 'Would you like to add another task? (y/n)'
} while ($continue -eq 'y')

