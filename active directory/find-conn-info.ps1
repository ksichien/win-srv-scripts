#!/usr/bin/env pwsh
Import-Module ActiveDirectory

function find-conn-info ([string]$searchbase) {
    $computercollection = Get-ADComputer -Filter * -SearchBase $searchbase

    foreach ($computer in $computercollection) {
        $wmi = Get-WmiObject -Class 'Win32_NetworkAdapterConfiguration' -ComputerName $computer.Name -Filter 'IpEnabled = TRUE'
        write-host 'Connection information for ' $computer.Name
        write-host 'Adapter Name:' $wmi.Description
        write-host 'MAC Address:' $wmi.MacAddress
        write-host 'IP Address:' $wmi.IPAddress
    }
}

$example_search_base = 'OU=computers,OU=vandelayindustries,DC=internal,DC=vandelayindustries,DC=com'

find-conn-info $example_search_base
