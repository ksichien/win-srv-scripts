#!/usr/bin/env pwsh

function mail-wsus-report ([string]$to) {
    $srv = 'wsus.internal.vandelayindustries.com'
    $svc = 'windows server update services'
    $from = 'daily-wsus-report@vandelayindustries.com'
    $subject = 'Daily WSUS Report'
    $body = ''
    $smtpserver = 'smtp.vandelayindustries.com'
    $smtpport = '587'
    $securepassword = ConvertTo-SecureString 'P@ssword!' -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ('daily-wsus-report', $securepassword)

    ForEach($i in $srv) {
        $body += "Server: $i"
        $body += get-winevent -computername $i -filterhashtable @{providername=$svc; starttime=(get-date).date;} | select timecreated, level, message | fl | Out-String
    }

    Send-MailMessage -From $from -to $to -Subject $subject `
    -Body $body -SmtpServer $smtpserver -port $smtpport -UseSsl `
    -Credential $credential
}

$example_recipient = 'user@vandelayindustries.com'

mail-wsus-report $example_recipient
