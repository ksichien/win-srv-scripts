#!/usr/bin/env pwsh
$computerkeyhash = @{}
$licenses = (Get-Content './licenses.txt')
foreach ($license in $licenses) {
    $values = $license -split ';'
    $computerkeyhash.Add($values[0], $values[1])
}
$computerkeyhash.GetEnumerator() | foreach { Invoke-Command -ComputerName $_.key -ScriptBlock { slmgr -ipk $_.value } }
