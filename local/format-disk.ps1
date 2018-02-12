#!/usr/bin/env pwsh

$diskpart = 'c:\diskpart.txt'
$drive = 'f:\'
$files = 'c:\new folder\'

cmd /c diskpart /s $diskpart

copy-item -path $files -destination $drive -recurse

cmd /c icacls $drive /grant "Administrators:(OI)(CI)F" /t
cmd /c icacls $drive /remove "Everyone" /t
cmd /c icacls $drive /grant "Everyone:(OI)(CI)RX" /t
