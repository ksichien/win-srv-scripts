$vmswitch = "ExternalVmSwitch"
$vm = "CentOS 7 x64"
$vmpath = "C:\Hyper-V Machines\"
$vmmemory = 1GB
$vhdpath = "C:\Hyper-V Disks\$($vm).vhdx"
$vhdsize = 40GB

Import-Module Hyper-V
$adapter = Get-NetAdapter -Physical | where {$_.Status -eq "Up"} | sort ASC | select Name
New-VMSwitch -Name $vmswitch -NetAdapterName $adapter[0] -AllowManagementOS $true
New-VM -Name $vm -Path $vmpath -MemoryStartupBytes $vmmemory -SwitchName $vmswitch -NewVHDPath $vhdpath -NewVHDSizeBytes $vhdsize
Set-VMProcessor $vm -Count 2
Set-VMMemory $vm -DynamicMemoryEnabled $true
Add-VMNetworkAdapter -VMName $vm -SwitchName $vmswitch
