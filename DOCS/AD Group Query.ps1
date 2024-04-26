Get-ADGroupMember -identity "MEINWESSFS_QualityAnalysis_Change" -Recursive | foreach{ get-aduser $_} | select SamAccountName,objectclass,name
Get-ADGroup -filter 'Name -like "*MEINWESSFS_QualityAnalysis_Change*"' | select  SamAccountName,DisplayName,Name
