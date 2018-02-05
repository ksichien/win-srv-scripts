#!/usr/bin/env pwsh
Import-Module Hyper-V

function create-vm ([string]$name) {
    $vmswitch = 'ExternalVmSwitch'
    $vmpath = 'C:\Hyper-V Machines\'
    $vmmemory = 2GB
    $vhdpath = "C:\Hyper-V Disks\$name.vhdx"
    $vhdsize = 32GB
    $adapters = Get-NetAdapter -Physical | Where-Object {$_.Status -eq 'Up'} | sort Name

    New-VMSwitch -Name $vmswitch -NetAdapterName $adapters[0].Name -AllowManagementOS $true
    New-VM -Name $vm -Path $vmpath -MemoryStartupBytes $vmmemory -SwitchName $vmswitch -NewVHDPath $vhdpath -NewVHDSizeBytes $vhdsize
    Set-VMProcessor $vm -Count 2
    Set-VMMemory $vm -DynamicMemoryEnabled $true
    Add-VMNetworkAdapter -VMName $vm -SwitchName $vmswitch
}

$example_name = "Debian 9 x64"

create-vm $example_name
