Import-Module "$PSScriptRoot\..\modules\UserManagement.psm1" -Force
$configs = Get-Content -Path "$PSScriptRoot\..\configs\configs.json" | ConvertFrom-Json
$secrets = Get-Content -Path "$PSScriptRoot\..\configs\secrets.json" | ConvertFrom-Json
# if ($secrets.adServer.location -eq "remote")
# {
#     $pssession = Get-PSSession | Where-Object { $_.ComputerName -eq $secrets.adServer.host }
#     if (-not $pssession) {
#         cmConnectToRemoteAD -adServer $secrets.adServer.host -adUser $secrets.adServer.user
            #$pssession = Get-PSSession | Where-Object { $_.ComputerName -eq $secrets.adServer.host }
#     }
#     else {
#         Write-Host "Already connected to remote AD server: $($secrets.adServer.host)"
#     }
# }
# newADUserFromCsv -csvFile "$($configs.paths.data)\new-employees.csv"
Import-Csv -Path 