Import-Module "$PSScriptRoot\..\modules\UserManagement.psm1" -Force
$password = ConvertTo-SecureString -String "a@12345" -AsPlainText -Force
$username = "test"
modCreateLocalUser -username $username -password $password