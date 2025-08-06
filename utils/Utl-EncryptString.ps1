param (
    [string]$string
)

if (-not $string) {
    Write-Warning "No string provided to encrypt, please try again!!!"
    return
}

# Write-Host "Encrypting ..."
$encryptedString = [System.Text.Encoding]::Unicode.GetBytes($string)
$encryptedString = [System.Convert]::ToBase64String($encryptedString)

Write-Host $encryptedString