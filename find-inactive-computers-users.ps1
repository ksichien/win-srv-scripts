$datecutoff = (Get-Date).AddDays(-90)
$searchbasecomputers = 'ou=computers,ou=vandelayindustries,dc=internal,dc=vandelayindustries,dc=com'
$searchbaseusers = 'ou=users,ou=vandelayindustries,dc=internal,dc=vandelayindustries,dc=com'
Write-Output 'Computers:'
Get-ADComputer -SearchBase $searchbasecomputers -Properties LastLogonDate -Filter {LastLogonDate -lt $datecutoff} | Sort LastLogonDate | FT Name, LastLogonDate -Autosize
Write-Output 'Users:'
Get-ADUser -SearchBase $searchbaseusers -Properties LastLogonDate -Filter {LastLogonDate -lt $datecutoff} | Sort LastLogonDate | FT Name, LastLogonDate -Autosize