#!/usr/bin/env pwsh

function create-local-user([array]$users) {
    $password = convertto-securestring 'P@ssword!' -asplaintext -force
    
    foreach ($user in $users) {
        new-localuser -name $user -password $password
    }
}

$example_users = @('alice', 'bob')

create-local-user $example_users
