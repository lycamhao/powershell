$configs = Get-Content -Path "$PSScriptRoot\..\configs\configs.json" | ConvertFrom-Json
Write-Host $configs