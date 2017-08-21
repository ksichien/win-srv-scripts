$utility = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
do {
    Write-Output 'Please provide the following information for the new scheduled task:'
    $file = Read-Host -Prompt 'Script file path'
    $time = Read-Host -Prompt 'Script execution time'
    $name = Read-Host -Prompt 'Scheduled task name'
    $credentials = Get-Credential

    $Action = New-ScheduledTaskAction -Execute $utility -Argument "-NonInteractive -NoLogo -NoProfile -File $file"
    $Trigger = New-ScheduledTaskTrigger -Daily -At $time
    $Task = New-ScheduledTask -Action $Action -Trigger $Trigger -Settings (New-ScheduledTaskSettingsSet)
    $Task | Register-ScheduledTask -TaskName $name -User $credentials.username -Password $credentials.password

    $continue = Read-Host -Prompt 'Would you like to add another task? (y/n)'
} while ($continue -eq 'y')