function cmGetPSModule {
    Write-Host "Current Powershell Version: $($PSVersionTable.PSVersion)"
}

function cmGetExecutionPolicy {
    $executionPolicy = Get-ExecutionPolicy
    Write-Host "Current Execution Policy: $executionPolicy"
}

function cmReadCsv {
    [CmdletBinding()]
    param (
        [string]$csvFilePath
    )
    $result = Import-Csv -Path 
     -ErrorAction Stop
    return $result
}

function cmWriteCsv {
    
}

function cmWriteLog {
    [CmdletBinding()]
    param(
        [string]$logType,
        [string]$logFile,
        [string]$logMessage
    )
    switch ($logType) {
        "Error" { 
            Add-Content -Path "$($configs.paths.log)\$logFile.log" -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [Error] $logMessage"
        }
        "Info" { 
            Add-Content -Path "$($configs.paths.log)\$logFile.log" -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [Info] $logMessage"
        }
        Default {
            return
        }
    }
}

function cmBase64Encrypt {
    param (
    [string]$string
    )
    if (-not $string) {
        cmWriteLog $logType "Error" $logFile "$($configs.logPath)\$logFile.log" $logMessage "No string provided to encrypt, please try again!!!"
        return
    }
    $encryptedString = [System.Text.Encoding]::Unicode.GetBytes($string)
    $encryptedString = [System.Convert]::ToBase64String($encryptedString)
    Write-Host $encryptedString
}

function cmBase64Decrypt {
    param (
        $string
    )
    
}

function cmConnectToRemoteAD {
    [CmdletBinding()]
    param (
        [string]$adServer,
        [string]$adUser
    )
    if (-not $adServer -or -not $adServer) {
        Write-Host "AD server or username empty."
        return
    }
    $session = New-PSSession -ComputerName $adServer -Credential $adUser
    Invoke-command { import-module activedirectory } -session $session
    Export-PSSession -session $session -commandname *-AD* -outputmodule RemAD -allowclobber -Force
    Import-Module RemAD -Force
}

function cmLoadJsonConfig {
    param (
        [string]$configPath,
        [string]$basePath = $PSScriptRoot
    )

    if (-not (Test-Path $configPath)) {
        throw "❌ Cannot find the path: $configPath"
    }

    $config = Get-Content -Path $configPath -Raw | ConvertFrom-Json

    foreach ($prop in $config.PSObject.Properties) {
        if ($prop.Value -is [string] -and $prop.Value -match "[\\/]+") {
            if (-not [System.IO.Path]::IsPathRooted($prop.Value)) {
                $config.$($prop.Name) = Join-Path $basePath $prop.Value
            }
        }
    }

    return $config
}


function cmEncodePassowrd { param ($password)
    $encodedPassword = [System.Text.Encoding]::Unicode.GetBytes($password)
    $encodedPassword = [System.Convert]::ToBase64String($encodedPassword)
    return $encodedPassword
}


function cmDecodePassword { param ($password)
    $decodedPassword = [System.Convert]::FromBase64String($password)
    $decodedPassword = [System.Text.Encoding]::Unicode.GetString($decodedPassword)
    return $decodedPassword
}

function cmSendMail { param ($body,$from,$to,$username,$password)
    Import-Module Send-MailKitMessage
    $securepwd = ConvertTo-SecureString $password -AsPlainText -Force
    $credential = [System.Management.Automation.PSCredential]::new($username, (ConvertTo-SecureString -String $password -AsPlainText -Force))
    $mailParam = @{
        "From" = $from
        "To" = $to
        "Subject" = 'Thông báo đổi mật khẩu'
        "SMTPServer" = 'email.cathay-ins.com.vn'
        "Port" = 465
        "UseSecureConnectionIfAvailable" = $true
        "HTMLBody" = $body
        "Credential" = $credential
        #DeliveryNotificationOption = 'OnSuccess', 'OnFailure'
    }
    #[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::SystemDefault
    Send-MailKitMessage @mailParam
}