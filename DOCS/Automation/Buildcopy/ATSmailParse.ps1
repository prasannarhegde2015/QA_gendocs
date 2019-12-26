#Connecting Outlook with below command
$target=""
Add-Type -assembly "Microsoft.Office.Interop.Outlook"
$Outlook = New-Object -ComObject Outlook.Application
$Folder = "ATS Emails"
$Namespace = $Outlook.GetNameSpace("MAPI")
#$NameSpace.Folders.Item(1)
$messages = $NameSpace.Folders.Item(1).Folders.Item($Folder).Items
Write-Host "Count of emails in outlook are "$OutlookFolders.Count
$message = $messages |Sort ReceivedTime | select -last 1
Write-Host $message.Subject
$messgehtmlbody=$message.HTMLBody
$sourcepath=$messgehtmlbody | Select-String -Pattern 'LogFile=\\\\.*"'  -AllMatches
$reresults=$sourcepath.Matches.Value |select -last 1
$sourcepath=$reresults -replace "LogFile=",""
$sourcepath=$sourcepath -replace "\\auto.log""",""
$buildnumber=$sourcepath | Select-String -Pattern '\d\.+\d.+\d.\d{3,5}'  -AllMatches
$reresults=$buildnumber.Matches.Value | select -last 1
Write-Host "Source Path from email is: "$sourcepath
Write-Host "build number is : "$reresults
