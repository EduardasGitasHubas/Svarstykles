# fi.ps1 — Windows wrapper for fi.sh
# Uses Git Bash directly to avoid WSL bash being blocked in sandbox environments.
$gitBash = 'C:\Program Files\Git\bin\bash.exe'
if (Test-Path $gitBash) {
    & $gitBash (Join-Path $PSScriptRoot 'fi.sh')
} else {
    bash (Join-Path $PSScriptRoot 'fi.sh')
}
