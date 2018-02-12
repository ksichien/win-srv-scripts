#!/usr/bin/env pwsh

function format-disk ([string]$diskpart, [string]$drive, [string]$files){
    cmd /c diskpart /s $diskpart
    copy-item -path $files -destination $drive -recurse
    cmd /c icacls $drive /grant "Administrators:(OI)(CI)F" /t
    cmd /c icacls $drive /remove "Everyone" /t
    cmd /c icacls $drive /grant "Everyone:(OI)(CI)RX" /t
}

$example_diskpart = 'C:\diskpart.txt'
$example_drive = 'F:\'
$example_files = 'C:\new folder\'

format-disk $example_diskpart $example_drive $example_files
