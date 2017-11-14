$users = @('alice','bob')
$password = convertto-securestring 'P@ssword!' -asplaintext -force
foreach ($user in $users) {
    new-localuser -name $user -password $password
}
