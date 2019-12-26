#Connecting Outlook with below command

$target="C:\Prasanna\ForeSite\UIAutomation\TestResults\ATS"
$lastNCount=6
Add-Type -assembly "Microsoft.Office.Interop.Outlook"
$Outlook = New-Object -ComObject Outlook.Application
$Folder = "ATS Emails"
$Namespace = $Outlook.GetNameSpace("MAPI")
#$NameSpace.Folders.Item(1)
$messages = $NameSpace.Folders.Item(1).Folders.Item($Folder).Items
Write-Host "Count of emails in outlook are:  "$messages.Count
$oldcount = $messages.Count

while ($true)
{
	# get New count later
	$messages = $NameSpace.Folders.Item(1).Folders.Item($Folder).Items
	$newcount=$messages.Count
	Write-Host "Old count: "$oldcount
	Write-Host "New count: "$newcount
	if ($newcount -eq $oldcount)
	{
		$messagel6 = $messages |Sort ReceivedTime | select -last $lastNCount
		foreach($message in $messagel6)
		{
			$subject= $message.Subject
			if ($subject.Contains("DPH") -eq $false)
			{
				$messgehtmlbody=$message.HTMLBody
				$sourcepath=$messgehtmlbody | Select-String -Pattern 'LogFile=\\\\.*"'  -AllMatches
				$reresults=$sourcepath.Matches.Value |select -last 1
				$sourcepath=$reresults -replace "LogFile=",""
				$sourcepath=$sourcepath -replace "\\auto.log""",""
				$buildnumber=$sourcepath | Select-String -Pattern '\d\.+\d.+\d.\d{3,5}'  -AllMatches
				$reresults=$buildnumber.Matches.Value | select -last 1
				Write-Host "Source Path from email is: "$sourcepath
				Write-Host "build number is : "$reresults
				if (-not (Test-Path $target"\"$reresult) )
						{
							New-Item -Path $target"\"$reresults -ItemType "directory"
						}
						$sourcedir=$sourcepath+"\\ATS\\UQAScripts"
						if ($subject.Contains("UPG") -eq $true)
							{
							New-Item -Path $target"\"$reresults"\UPG" -ItemType "directory"
							Copy-Item   -Path $sourcedir -Recurse -Destination $target"\"$reresults"\UPG"
							}
							else
							{
							Copy-Item   -Path $sourcedir -Recurse -Destination $target"\"$reresults
							}
					}
			}
	}
	else
		{
		Write-Host "No New Emails to check Idling for 10 minutes"
		Start-Sleep -s 600
		}
}
