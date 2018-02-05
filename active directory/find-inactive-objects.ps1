#!/usr/bin/env pwsh
Import-Module ActiveDirectory

function get-inactive-objects ([string]$company, [string]$domain) {
    $datecutoff = (Get-Date).AddDays(-90)
    $searchbasecomputers = "OU=computers,OU=$company,$domain"
    $searchbaseusers = "OU=users,OU=$company,$domain"

    Write-Output 'Computers:'
    Get-ADComputer -SearchBase $searchbasecomputers -Properties LastLogonDate -Filter {LastLogonDate -lt $datecutoff} | sort-object LastLogonDate | ft Name, LastLogonDate -Autosize
    Write-Output 'Users:'
    Get-ADUser -SearchBase $searchbaseusers -Properties LastLogonDate -Filter {LastLogonDate -lt $datecutoff} | sort-object LastLogonDate | ft Name, LastLogonDate -Autosize
}

$example_company = 'vandelayindustries'
$example_domain = 'DC=internal,DC=vandelayindustries,DC=com'

get-inactive-objects $example_company $example_domain
