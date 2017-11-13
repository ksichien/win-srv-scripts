Import-Module ActiveDirectory
$server = 'dc1.internal.vandelayindustries.com'
$domain = 'DC=internal,DC=vandelayindustries,DC=com'
$dfs = '\\internal.vandelayindustries.com\shares'
$company = 'vandelayindustries'
$continent = 'europe'
$country = 'germany'
$city = 'berlin'
$departments = @('finance')
$homedrive = 'U:'

foreach ($d in $departments) {
    $ou = "ou=$d,ou=$city,ou=$country,ou=$continent,ou=users,ou=$company,$domain"
    $users = get-aduser -filter * -searchbase $ou -server $server
    foreach ($u in $users) {
        $username = $u.samAccountName
        $homedirectory = "$dfs\home\$username"
        if (-not(test-path -path "$homedirectory")) {
            new-item $homedirectory -type directory
            $acl = get-acl $homedirectory
            $ar = new-object System.Security.AccessControl.FileSystemAccessRule($username, 'Modify', 'ContainerInherit,ObjectInherit', 'None', 'Allow')
            $acl.setaccessrule($ar)
            set-acl $homedirectory $acl
            set-aduser -identity $u -replace @{HomeDirectory="$homedirectory";HomeDrive="$homedrive"}
        }
    }
}
