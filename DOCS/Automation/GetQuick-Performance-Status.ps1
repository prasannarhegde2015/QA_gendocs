$os=Get-CimInstance -ClassName Win32_OperatingSystem
$cpu=Get-CimInstance -ClassName Win32_Processor
  [PSCustomObject]@{
  "Total Memory (GB)" =  $os.TotalVisibleMemorySize/1MB
  "Avaialable Memeory (GB)" = $os.FreePhysicalMemory/1MB
  "Number of Processors" = $env:NUMBER_OF_PROCESSORS
  "CPU Utilization %" = $cpu.LoadPercentage
  }
  
