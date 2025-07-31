Import-Module "$PSScriptRoot\..\modules\common.psm1" -Force
function modGetAllLocalUser {
    [CmdletBinding()]
    param()

    # Retrieve all users from the system
    $users = Get-LocalUser 

    # Return the list of users
    return $users
}

function modGetLocalUser {
    [CmdletBinding()]
    param($username)
    if (-not $username) {
        return
    }
    # Retrieve user by username
    $user = Get-LocalUser | Where-Object { $_.Name -eq $username } | ConvertTo-Json

    # Return user information
    return $user
}

function modGetAllADUser {
    [CmdletBinding()]
    param()

    # Retrieve all Active Directory users
    $users = Get-ADUser -Filter * -Properties *

    # Return the list of AD users
    return $users
}