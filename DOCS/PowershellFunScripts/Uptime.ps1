(New-TimeSpan -Start (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime -End (Get-Date))
