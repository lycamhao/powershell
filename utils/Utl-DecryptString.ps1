param (
    [string]$string
)

if (-not $string) {
    Write-Warning "No string provided to decrypt."
    return
}

# Write-Host: "Decrpting ..."
$decryptedString = [System.Convert]::FromBase64String($string)
$decryptedString = [System.Text.Encoding]::Unicode.GetString($decryptedString)

Write-Host $decryptedString