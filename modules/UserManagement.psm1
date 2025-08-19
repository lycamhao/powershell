Import-Module "common.psm1"

function modGetAllLocalUser {
    [CmdletBinding()]
    param()
    $users = Get-LocalUser 
    return $users
}

function modGetLocalUser {
    [CmdletBinding()]
    param($username)
    if (-not $username) {
        return
    }
    $user = Get-LocalUser | Where-Object { $_.Name -eq $username } | ConvertTo-Json
    return $user
}

function modGetADUser {
    [CmdletBinding()]
    param([string]$username)
    if (-not $username) {
        return
    }
    $user = Get-ADUser -Identity $username -Properties * | ConvertTo-Json
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
function modCreateADUser {
    [CmdletBinding()]
    param(
        [string]$username,
        [SecureString]$password,
        [string]$description = "Created from Script",
        [string]$ou = "OU=Users,DC=example,DC=com"
    )
}

function modGetAllADUser {
    [CmdletBinding()]
    param(
        [string]$csvOutput = $false
    )
    $users = Get-ADUser -Filter *
    if ($csvOutput -eq $true) {
        $users | Export-Csv -Path $configs.paths.data -NoTypeInformation -Encoding UTF8
    } else {
        $users
    }
}

function modGetADUser {
    [CmdletBinding()]
    param(
        [string]$userIdentity,
        [string]$csvOutput = $false
    )
    $user = Get-ADUser -Identity "$userIdentity" -Filter *
    if ($csvOutput -eq $true) {
        $user | Export-Csv -Path $configs.paths.data -NoTypeInformation -Encoding UTF8
    } else {
        $user
    }
}

function newADUserFromCsv {
    [CmdletBinding()]
    param (
        [string]$csvFile
    )
    $users = Import-Csv -Path $csvFile
    $header = Import-Csv -Path $csvFile -First 1
    $header
}