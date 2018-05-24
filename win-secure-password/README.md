# Windows secure password

A simple script to generate a `secureString` password in Powershell, using DPAPI (Windows Data Protection API).

Put the password you want to secure in `$plainTextPassword` and launch the script. It will create a `secureStringPassword.txt` file with encrypted password.

This can be useful if you're working with `PSCredential`object inside your project, as you can grab the encrypted password from this file instead inserting it as plain text in you code.