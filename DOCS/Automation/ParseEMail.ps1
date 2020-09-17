$target = "C:\Prasanna\ForeSite\UIAutomation\Inbox"
Add-Type -Assembly "Microsoft.Office.Interop.Outlook"
$Outlook = New-Object -ComObject Outlook.Application
$Folder = "External"
$Namespace = $Outlook.GetNameSpace("MAPI")
$messages = $NameSpace.Folders.Item(1).Folders.Item($Folder).Items
$cnt =1
    foreach ($message in $messages)
    {
      $subject = "Message"+$cnt
      $messgehtmlbody = $message.HTMLBody
      $filestamp = $subject + (get-date -f MMddyyyyHHmmss)+".txt"
      New-Item $target\$filestamp
      set-content -path $target\$filestamp -value $messgehtmlbody
      $cnt=$cnt+1
    }
#}
