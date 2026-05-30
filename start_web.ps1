# start_web.ps1 — Avvia Anonimizzatore Web UI su Windows
param(
    [int]$Port = 5000,
    [switch]$NoBrowser
)

$PY = "C:\Users\Luca\AnonimizzatoreDatiSensibili\venv\Scripts\python.exe"
$ROOT = $PSScriptRoot

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Anonimizzatore General Purpose" -ForegroundColor Cyan
Write-Host "  Web UI — Windows" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $PY)) {
    Write-Host "Errore: Python non trovato in: $PY" -ForegroundColor Red
    exit 1
}

# Verifica Flask
$flaskCheck = & $PY -c "import flask; print(flask.__version__)" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Installazione Flask..." -ForegroundColor Yellow
    & $PY -m pip install flask --quiet
}

Write-Host "Avvio server su http://localhost:$Port" -ForegroundColor Green
Write-Host "Premi Ctrl+C per fermare" -ForegroundColor Gray
Write-Host ""

Set-Location $ROOT
& $PY app_web.py
