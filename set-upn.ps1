Import-Module ActiveDirectory
$server = 'dc1.internal.vandelayindustries.com'
$domain = 'DC=internal,DC=vandelayindustries,DC=com'
$upnsuffix = 'vandelayindustries.com'
$company = 'vandelayindustries'
$continent = 'europe'
$country = 'germany'
$city = 'berlin'
$departments = @('finance','logistics')

foreach ($department in $departments) {
    $ou = "OU=$department,OU=$city,ou=$country,OU=$continent,OU=users,OU=$company,$domain"
    $users = get-aduser -filter * -searchbase $ou -server $server
    foreach ($user in $users) {
        $username = $user.samaccountname
        $upn = "$username@$upnsuffix"
        set-aduser -identity $user -replace @{UserPrincipalName=$upn}
    }
}
