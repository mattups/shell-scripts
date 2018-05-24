# Gathering machine info.
$hostname = [System.Net.Dns]::GetHostByName((hostname)).HostName
$lastBoot = Get-WmiObject win32_operatingsystem | ForEach-Object{ $_.ConvertToDateTime($_.LastBootUpTime) }
$rebootDetail = (Get-WinEvent -LogName System -FilterXPath "*[System[(EventID=1074 or EventID=1076 or EventID=6008)]]" `
    -MaxEvents 1 -ComputerName localhost | Format-List) | Out-String
   
# Required parameters for Send-MailMessage.
$from = "from@example.com"
$to = "to@example.co"
$subject = "An example subject"

$message = "Hostname: " `
    + $hostname + "`n `r" `
    + "Last boot: " `
    + $lastBoot + "`n `r" `
    + "Last shutdown detail: " `
    + $rebootDetail

$SMTPserver = "example.smtpserver.com"

# Delay for sending (five minutes here). Uncomment the next line if you want to delay the email.
# Start-Sleep -s 300

Send-MailMessage `
    -From $from `
    -To $to `
    -Subject $subject `
    -Body $message `
    -SmtpServer $SMTPserver