#!/usr/bin/env pwsh

function install-product-key ([string]$licensefile) {
    $computerkeyhash = @{}
    $licenses = Get-Content $licensefile

    foreach ($license in $licenses) {
        $values = $license -split ';'
        $computerkeyhash.Add($values[0], $values[1])
    }
    $computerkeyhash.GetEnumerator() | foreach { Invoke-Command -ComputerName $_.key -ScriptBlock { slmgr -ipk $_.value } }
}

$example_license_file = 'C:\licenses.txt'

install-product-key $example_license_file
