# SecureString password generation
$plainTextPassword = "Plain text password"

$securePassword = $plainTextPassword | ConvertTo-SecureString -AsPlainText -Force 
$storedPassword = $securePassword | ConvertFrom-SecureString 

Set-Content "secureStringPassword.txt" $storedPassword