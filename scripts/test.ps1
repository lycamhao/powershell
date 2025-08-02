Import-Module "$PSScriptRoot\..\modules\common.psm1" -Force
Import-Module "$PSScriptRoot\..\modules\UserManagement.psm1" -Force
modCreateLocalUserFromCsv -userListFile "$PSScriptRoot\..\data\userList.csv"