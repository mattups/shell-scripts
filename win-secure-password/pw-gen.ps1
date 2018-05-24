# SecureString password generation

$originalPassword = "Plain text password"
$securePassword = $originalPassword | ConvertTo-SecureString -AsPlainText -Force 
$storedPassword = $securePassword | ConvertFrom-SecureString 
Set-Content "secureStringPassword.txt" $storedPassword