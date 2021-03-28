# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/set-variable?view=powershell-7.1
Set-Variable -Name FRP_VERSION -Value 0.35.1
Set-Variable -Name FRP_NAME -Value frp_${FRP_VERSION}_windows_386
Set-Variable -Name BIN_LOCATION -Value C:\frp

# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-output?view=powershell-7.1
# debug
# Write-Output https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/${FRP_NAME}.zip

# https://4sysops.com/archives/use-powershell-to-download-a-file-with-http-https-and-ftp/
Invoke-WebRequest -Uri https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/${FRP_NAME}.zip -OutFile .\${FRP_NAME}.zip

# debug
# Write-Output "${FRP_NAME}.zip"

# This will require choco install unzip
# unzip .\${FRP_NAME}.zip
Expand-Archive .\${FRP_NAME}.zip

# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/move-item?view=powershell-7.1
Move-Item -Path .\${FRP_NAME} -Destination ${BIN_LOCATION}
Remove-Item -Path .\${FRP_NAME}.zip

# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file?view=powershell-7.1
Out-File -FilePath ${BIN_LOCATION}\frpc.ps1 -InputObject 'Start-Process -FilePath C:\frp\frpc.exe -ArgumentList "-c C:\frp\frpc.ini" -WindowStyle Hidden'
Copy-Item -Path .\frpc.ini -Destination ${BIN_LOCATION}
Copy-Item -Path .\UbuntuFRPServer\frps.ini -Destination ${BIN_LOCATION}

$trigger = New-JobTrigger -AtStartup -RandomDelay 00:00:30
Register-ScheduledJob -Trigger $trigger -FilePath ${BIN_LOCATION}\frpc.ps1 -Name FRPC
