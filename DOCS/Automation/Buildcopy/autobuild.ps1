$location = "E:\Prasanna\test\source"
$target = "E:\Prasanna\test\target"
$latestfile = Get-ChildItem -Path $location | Where-Object {$_.PSIsContainer}
if ($latestfile.Count -gt 0 )
{
 Write-Host "The directory has folders in it"
 $desfolder=$latestfile | Sort-Object LastWriteTime -Descending | Select-Object -First 1
 Write-Host $desfolder
$fileone = Get-ChildItem -Path $desfolder.FullName | Where-Object Name  -like "Weatherford_ForeSite_Ful*"


}
else
{
     Write-Host "The directory has no folders in it"
	 $fileone = Get-ChildItem -Path $location.PSPath | Sort-Object LastWriteTime -Descending| Select-Object -First 1
}
Write-Host $fileone
$sw = [Diagnostics.Stopwatch]::StartNew()
Copy-Item   $fileone.FullName -Destination $target
$sw.Stop()
Write-Host "Time required to copy was: "$sw.Elapsed
