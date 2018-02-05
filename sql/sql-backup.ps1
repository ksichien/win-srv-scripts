#!/usr/bin/env pwsh
# this script requires use of the powershell module Posh-SSH (https://github.com/darkoperator/Posh-SSH)

$sqlserver = "mssql.internal.vandelayindustries.com"
$sqldb = "sqlexpress"
$sqlusername = "sa"
$securesqlstring = "P@ssword!"

$localdb = "C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\sqlexpress.bak"
$transferdb = "C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\sqlexpress-" + $(get-date -f yyyy-MM-dd) + "-full.bak"

$stfpserver = "backup.internal.vandelayindustries.com"
$sftpusername = "backup.user"
$securesftpstring = "P@ssword!"
$remotepath = "/sqlexpress/"

# create backup of sql database
$securesqlpassword = convertto-securestring $securesqlstring -AsPlainText -force
$sqlcredentials = new-object System.Management.Automation.PSCredential ($sqlusername, $securesqlpassword)
Backup-SqlDatabase -ServerInstance $sqlserver -Database $sqldb -BackupAction Database -Credential $sqlcredentials -Verbose # full database backup

# append today's date to the filename
cp -path $localdb  -destination $transferdb

# transfer file to server with sftp
$securesftppassword = convertto-securestring $securesftpstring -AsPlainText -force
$sftpcredentials = new-object System.Management.Automation.PSCredential ($sftpusername, $securesftppassword)
new-sftpsession -credential $sftpcredentials -computername $stfpserver
set-sftpfile -sessionid 0 -remotepath $remotepath -localfile $transferdb -verbose
remove-sftpsession -sessionid 0 -verbose

# delete temporary db
rm $transferdb
