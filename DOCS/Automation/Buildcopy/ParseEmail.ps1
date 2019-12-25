Clear-Host
$Folder = "InBox"
Add-Type -assembly "Microsoft.Office.Interop.Outlook"
$Outlook = New-Object -ComObject Outlook.Application
$Namespace = $Outlook.GetNameSpace("MAPI")
$NameSpace.Folders.Item(1)
$Email = $NameSpace.Folders.Item(1).Folders.Item($Folder).Items
$Email | Get-Member -MemberType Properties |Ft Name
#-Email another
#Connecting Outlook with below command
$Outlook = New-Object -ComObject Outlook.Application
# Now getting all folders info in variable (Shows Email, Calendar, Tasks etc)
$OutlookFolders = $Outlook.Session.Folders.Item(1).Folders
#Now connecting Inbox mails
$OutlookInbox = $Outlook.session.GetDefaultFolder(6)
#Now reading latest mail
$latestmail=$OutlookInbox.items | select -last 1
#Now calling email content and getting email content as output in html
$latestmail.HTMLBody
