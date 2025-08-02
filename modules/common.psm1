$configs = Get-Content -Path "$PSScriptRoot\..\configs\configs.json" | ConvertFrom-Json
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
    $result = Import-Csv -Path $csvFilePath -ErrorAction Stop
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
            Add-Content -Path "$($configs.logPath)\$logFile.log" -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [Error] $logMessage"
        }
        "Info" { 
            Add-Content -Path "$($configs.logPath)\$logFile.log" -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [Info] $logMessage"
        }
        Default {
            return
        }
    }
}

function cmBase64Encrypt {
    param (
        $string
    )
    if (-not $string) {
        return $null
    }
}

function cmBase64Decrypt {
    param (
        $string
    )
    
}