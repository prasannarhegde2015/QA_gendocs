$services = Get-Service | Where-Object { $_.Name -Like "*Weatherford*" -or $_.Name -Like "*Dynacard*" } |Select-Object Name , Status
$allrows=@()
$numberedservices = "" |Select-Object SrNo,Name,Status
$counter=1
foreach($service in $Services)
{

$allrows += [PSCustomObject]@{
		SrNo    = $counter
        Name = $service.Name
        Status     = $service.Status
    }
	$counter++
}
Write-Host ("{0,-8}{1,-50}{2,-30}" -f "SrNo","Name","Status") -ForegroundColor white
foreach($numberedservice in $allrows )
{
	If ($numberedservice.Status -eq "Stopped")
	{
		Write-Host ("{0,-8}{1,-50}{2,-30}" -f $numberedservice.SrNo,$numberedservice.Name,$numberedservice.Status) -ForegroundColor red
	}
	else
	{
		Write-Host ("{0,-8}{1,-50}{2,-50}" -f $numberedservice.SrNo,$numberedservice.Name,$numberedservice.Status) -ForegroundColor green
	}
}
