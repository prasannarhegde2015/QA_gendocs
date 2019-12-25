Get-CimInstance -ClassName Win32_Process -Filter "Name like 'p%'"
 Write-Host -NoNewLine "OS Version: "
  Get-CimInstance Win32_OperatingSystem | Select-Object  Caption | ForEach{ $_.Caption }
  Write-Host ""
Write-Host -NoNewLine "Install Date: "
  Get-CimInstance Win32_OperatingSystem | Select-Object  InstallDate | ForEach{ $_.InstallDate }
  Write-Host ""
Write-Host -NoNewLine "Service Pack Version: "
  Get-CimInstance Win32_OperatingSystem | Select-Object  ServicePackMajorVersion | ForEach{ $_.ServicePackMajorVersion }
  Write-Host ""
Write-Host -NoNewLine "OS Architecture: "
  Get-CimInstance Win32_OperatingSystem | Select-Object  OSArchitecture | ForEach{ $_.OSArchitecture }
  Write-Host ""
Write-Host -NoNewLine "Boot Device: "
  Get-CimInstance Win32_OperatingSystem | Select-Object  BootDevice | ForEach{ $_.BootDevice }
  Write-Host ""
Write-Host -NoNewLine "Build Number: "
  Get-CimInstance Win32_OperatingSystem | Select-Object  BuildNumber | ForEach{ $_.BuildNumber }
  Write-Host ""
Write-Host -NoNewLine "Host Name: "
  Get-CimInstance Win32_OperatingSystem | Select-Object  CSName | ForEach{ $_.CSName }
  Write-Host ""
  $ieversion = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Internet Explorer').SvcVersion
Write-Host -NoNewLine -ForegroundColor Green  "Internet Explorer Version:  "$ieversion

Set-ExecutionPolicy Unrestricted
Get-CimInstance Win32_OperatingSystem

Get-ChildItem -Path HKLM:\Software -Recurse -ErrorAction SilentlyContinue | Where-Object -FilterScript {($_.Name -Like "*Chrome*") }
Get-ChildItem -Path HKLM:\Software -Recurse -ErrorAction SilentlyContinue | Where-Object -FilterScript {($_.Name -Like "*Chrome*") }

gci . -rec -ea SilentlyContinue | 
   % { 
      Get-ChildItem -Path hklm:\ -Recurse
      if((get-itemproperty -Path Registry::HKLM) -match $searchText)
      { 
         $_.PsPath
      } 
   } 
