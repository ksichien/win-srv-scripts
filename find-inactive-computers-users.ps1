Import-Module ActiveDirectory
$datecutoff = (Get-Date).AddDays(-90)
$domain = "DC=internal,DC=vandelayindustries,DC=com"
$company = 'vandelayindustries'

$searchbasecomputers = "OU=computers,OU=$company,$domain"
Write-Output 'Computers:'
Get-ADComputer -SearchBase $searchbasecomputers -Properties LastLogonDate -Filter {LastLogonDate -lt $datecutoff} | Sort LastLogonDate | Format-Table Name, LastLogonDate -Autosize

$searchbaseusers = "OU=users,OU=$company,$domain"
Write-Output 'Users:'
Get-ADUser -SearchBase $searchbaseusers -Properties LastLogonDate -Filter {LastLogonDate -lt $datecutoff} | Sort LastLogonDate | Format-Table Name, LastLogonDate -Autosize
