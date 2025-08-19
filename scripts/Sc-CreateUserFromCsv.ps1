$fullPath = $PSScriptRoot | Split-Path -Parent
$configs = Get-Content -Path "$fullPath\configs\configs.json" | ConvertFrom-Json
$secrets = Get-Content -Path "$fullPath\configs\secrets.json" | ConvertFrom-Json
Import-Module "$fullPath\modules\UserManagement.psm1"

Import-Csv .\data\new-employees.csv | ForEach-Object {
    $user = $_
    $userName = "$($user.FirstName).$($user.LastName)"
    $userPassword = ConvertTo-SecureString -String $user.Password -AsPlainText -Force

    New-ADUser -Name $userName `
               -GivenName $user.FirstName `
               -Surname $user.LastName `
               -UserPrincipalName "$userName@$($configs.domain.name)" `
               -SamAccountName $userName `
               -DisplayName "$($user.FirstName) $($user.LastName)" `
               -Path $configs.ad.ou `
               -AccountPassword $userPassword `
               -Enabled $true
}
# if ($secrets.adServer.location -eq "remote")
# {
#     $pssession = Get-PSSession | Where-Object { $_.ComputerName -eq $secrets.adServer.host } | Select-Object 
#     # if (-not $pssession) {
#     #     cmConnectToRemoteAD -adServer $secrets.adServer.host -adUser $secrets.adServer.user
#     # }
#     # else {
#     #     Write-Host "Already connected to remote AD server: $($secrets.adServer.host)"
#     # }
# }

# newADUserFromCsv -csvFile "$($configs.paths.data)\new-employees.csv"