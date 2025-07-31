Import-Module "$PSScriptRoot\..\modules\UserManagement.psm1" -Force
$user = modGetLocalUser "administrator" | ConvertFrom-Json
echo $user.Name