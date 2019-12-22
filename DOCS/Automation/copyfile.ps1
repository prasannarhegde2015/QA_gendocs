$location = "C:\Users\Prasanna\Downloads\test"
$target = "B:\Prasanna\test"
$latestfile=Get-ChildItem -Path $location | Where-Object {$_.PSIsContainer} | 
Sort-Object LastWriteTime -Descending | Select-Object -First 1
$fileone = Get-ChildItem -Path $latestfile.PSPath | Select-Object -First 1
Write-Host $fileone
Copy-Item   $fileone.FullName -Destination $target
