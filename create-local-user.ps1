$users = get-content "C:\users.txt"
$password = convertto-securestring 'P@ssword!' -asplaintext -force
foreach ($user in $users) {
    new-localuser -name $user -password $password
}
