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

function modGetADUser {
    [CmdletBinding()]
    param([string]$username)
    if (-not $username) {
        return
    }
    # Retrieve AD user by username
    $user = Get-ADUser -Identity $username -Properties * | ConvertTo-Json

    # Return user information
    return $user
}

function modCreateLocalUser {
    [CmdletBinding()]
    param(
        [string]$username,
        [SecureString] $password
    )
    
    # Create a new local user
    try {
        New-LocalUser -Name $username -Password (ConvertTo-SecureString $password -AsPlainText -Force) -FullName $username -Description "Create from Script"
        #cmWriteLog -logType "Info" -logFile "UserManagement" -logMessage "User <$username> created successfully."
    }
    catch {
        cmWriteLog -logType "Error" -logFile "UserManagement" -logMessage "User <$username> failed to create with error $_"
    }
}

function createLocalUserFromCsv {

}