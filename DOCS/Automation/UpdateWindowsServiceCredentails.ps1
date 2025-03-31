# Define variables
$ServiceName = "YourServiceName" # Replace with the actual service name
$NewUsername = "DOMAIN\\NewUser" # Replace with the domain and username of the new account
$NewPassword = "Password" # Replace with the password of the new account

# Update service logon
$SecurePassword = ConvertTo-SecureString $NewPassword -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential($NewUsername, $SecurePassword)
Set-Service -Name $ServiceName -Credential $Credential
