# store the email credentials in a variable
$cred = Get-Credential

#export the credentials to a file so the script reads from it (it will be hashed)
$cred | Export-Clixml -Path c:\users\ayman\psemail.xml