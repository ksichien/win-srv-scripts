$srv = 'wsus.internal.example.com'
$service = 'windows server update services'
$output = ''

ForEach($i in $srv) {
    $output += "Server: $i"
    $output += get-winevent -computername $i -filterhashtable @{providername=$service; starttime=(get-date).date;} | select timecreated, level, message | fl | Out-String
}

$from = 'daily-wsus-report@example.com'
$to = 'user@example.com'
$subject = 'Daily WSUS Report'
$body = $output
$smtpserver = 'smtp.example.com'
$smtpport = '587'
$securepassword = ConvertTo-SecureString 'password' -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ('daily-wsus-report', $securepassword)

Send-MailMessage -From $from -to $to -Subject $subject `
-Body $body -SmtpServer $smtpserver -port $smtpport -UseSsl `
-Credential $credential