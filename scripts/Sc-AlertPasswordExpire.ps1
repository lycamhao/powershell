$configs = Get-Content .\config.json | ConvertFrom-Json
. ".\email-content.ps1"
. ".\functions.ps1"
$daysToWarn = @(7, 3, 1)
$typeToWarn = @('Laptop', 'Outlet')
$accountDisabled = 0
$allUser = Get-ADUser -Filter * -SearchBase "OU=UserAvailable,DC=cathay-ins,DC=vn" -Properties description,msDS-UserPasswordExpiryTimeComputed,mail | 
Select-Object Name,SamAccountName,msDS-UserPasswordExpiryTimeComputed,mail,description
foreach ( $user in $allUser ) {
    $displayName = $user.'Name'
    $userName = $user.'SamAccountName'
    $pwdExpireDate = [datetime]::FromFileTime($user.'msDS-UserPasswordExpiryTimeComputed')
    $email = $user.'mail'
    $description = $user.'description'

    $resultDate = ($pwdExpireDate - (Get-Date)).Days
    #echo "User: $displayName - Email: $email - User password will expired after $resultDate days"
    if ($daysToWarn -contains $resultDate)
    {
        echo "User: $displayName - Email: $email - User password will expired after $resultDate days"
        #sendMail -body 
    }    

}