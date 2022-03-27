function Send-GmailMessage {
    param (
        [Parameter(Mandatory = $true)]
        [String]$Recipient,
        [String]$From = "ps.ayman.mahmoud@gmail.com",
        [String]$Subject,
        [String]$Body
    )

    #splatting parameters
    $param = @{
        SmtpServer = 'smtp.gmail.com'
        Port = 587
        UseSsl = $true
        Credential = (Import-Clixml c:\users\ayman\psemail.xml)
        From = $From
        To = $Recipient
        Subject = $Subject
        Body = $Body
            }

    Send-MailMessage @param
}