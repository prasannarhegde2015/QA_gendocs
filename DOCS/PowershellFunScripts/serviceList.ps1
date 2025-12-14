$allservices = Get-Service | Where-object { $_.Name -Like "*APACHE*" }
$totalrow = "" | Select-Object SrNo, Name, Status
$Cnt=1
foreach($service  in $allservices)
{

    $totalrow.SrNo = $Cnt
    $totalrow.Name = $service.Name
    $totalrow.Status = $service.Status
	$Cnt=$Cnt+1
}
foreach ($row in $totalrow)
{
	
	if ($row.Status -eq "Stopped" )
	{
		Write-Host ("{0,-5} {1,-25} {2,-25}" -f $row.SrNo, $row.Name, $row.Status)  -Foregroundcolor red
	}
	else
	{
		Write-Host ("{0,-5} {1,-25} {2,-25}" -f $row.SrNo, $row.Name, $row.Status)  -Foregroundcolor green
	}
	
}
