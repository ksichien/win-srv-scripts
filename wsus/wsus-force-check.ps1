#!/usr/bin/env pwsh
# Microsoft has deprecated wuauclt for Windows 10 & Windows Server 2016.
# Instead, usoclient should now be used to report client status to the WSUS server.
# The binary is located in C:\Windows\System32\UsoClient.exe

usoclient StartScan # Used To Start Scan
usoclient StartDownload # Used to Start Download of Patches
usoclient StartInstall # Used to Install Downloaded Patches
usoclient RefreshSettings # Refresh Settings if any changes were made
usoclient StartInteractiveScan # May ask for user input and/or open dialogues to show progress or report errors
usoclient RestartDevice # Restart device to finish installation of updates
usoclient ScanInstallWait # Combined Scan Download Install
usoclient ResumeUpdate # Resume Update Installation On Boot
