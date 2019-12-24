$location = "\\wft\us\USDC-Groups6\POBuilds\ReleaseBuild\POP\Trunk"
$target = "F:\ForeSite Builds\Trunk Builds"
$latestfile=Get-ChildItem -Path $location | Where-Object {$_.PSIsContainer} | 
Sort-Object LastWriteTime -Descending | Select-Object -First 1
if ($latestfile -eq "")
{
	$fileone = Get-ChildItem -Path $location.PSPath | Sort-Object LastWriteTime -Descending| Select-Object -First 1
}
else
{
	$fileone = Get-ChildItem -Path $latestfile.PSPath | Where-Object Name  -like "Weatherford_ForeSite_Full*"
}
Write-Host $fileone
$sw = [Diagnostics.Stopwatch]::StartNew()
Copy-Item   $fileone.FullName -Destination $target
$sw.Stop()
Write-Host "Time required to copy was: "$sw.Elapsed
