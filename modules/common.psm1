function cmGetPSModule {
    Write-Host "Current Powershell Version: $($PSVersionTable.PSVersion)"
}

function cmGetExecutionPolicy {
    $executionPolicy = Get-ExecutionPolicy
    Write-Host "Current Execution Policy: $executionPolicy"
}

function cmReadCsv {
    $csvPath = 
}

function cmWriteCsv {
    
}

function cmWriteTxtLog {

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