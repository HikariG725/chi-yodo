param(
  [Parameter(Mandatory = $true)]
  [string]$Passphrase,

  [switch]$Clipboard
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$bytes = [Text.Encoding]::UTF8.GetBytes($Passphrase)
$hashBytes = [Security.Cryptography.SHA256]::Create().ComputeHash($bytes)
$hashHex = ($hashBytes | ForEach-Object { $_.ToString("x2") }) -join ""

if ($Clipboard) {
  try {
    Set-Clipboard -Value $hashHex
  } catch {
    Write-Warning "Set-Clipboard に失敗しました: $($_.Exception.Message)"
  }
}

$hashHex
