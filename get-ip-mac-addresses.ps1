$location = Read-Host -Prompt 'Please enter the searchbase' # f.e. ou=computers,ou=vandelayindustries,DC=internal,DC=vandelayindustries,DC=com
$computercollection = Get-ADComputer -Filter * -SearchBase "$location"

foreach($computer in $computercollection) {
    $wmi = Get-WmiObject -Class "Win32_NetworkAdapterConfiguration" -ComputerName $computer.Name -Filter "IpEnabled = TRUE"
    write-host "Connection information for " $computer.Name
    write-host "Adapter Name:" $wmi.Description
    write-host "MAC Address:" $wmi.MacAddress
    write-host "IP Address:" $wmi.IPAddress
}