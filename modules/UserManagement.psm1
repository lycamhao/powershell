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
        [SecureString]$password,
        [string]$description = "Created from Script"
    )
    
    # Create a new local user
    try {
        New-LocalUser -Name $username -Password (ConvertTo-SecureString $password -AsPlainText -Force) -FullName $username -Description description -ErrorAction Stop 
        cmWriteLog -logType "Info" -logFile "UserManagement" -logMessage "modCreateLocalUser: user <$username> created successfully."
    } 
    catch {
        Write-Host $_.Exception.Message
        cmWriteLog -logType "Error" -logFile "UserManagement" -logMessage "modCreateLocalUser: user <$username> failed to create with error: $_"
    }
}

function modCreateLocalUserFromCsv {
    [CmdletBinding()]
    param (
        [string]$userListFile
    )

    if (-not $userListFile -or -not (Test-Path $userListFile) -or $userListFile -eq $null -or $userListFile -eq "") {
        cmWriteLog -logType "Error" -logFile "UserManagement" -logMessage "modCreateLocalUserFromCsv: csvFilePath not provided or path not found."
        return
    }
    $csv = cmReadCsv -csvFilePath $userListFile
    foreach ( $user in $csv ) {
        $username = $user.username
        $password = ConvertTo-SecureString $user.password -AsPlainText -Force
        $description = $user.description
        modCreateLocalUser -username $username -password $password -description $description
    }
}

function modCreateADUser {
    [CmdletBinding()]
    param(
        [string]$username,
        [SecureString]$password,
        [string]$description = "Created from Script",
        [string]$ou = "OU=Users,DC=example,DC=com"
    )
}