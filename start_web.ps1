# start_web.ps1 — Avvia Anonimizzatore Web UI su Windows
# Rileva Python automaticamente, crea venv locale, installa Flask se mancante.
param(
    [int]$Port = 5000,
    [switch]$NoBrowser
)

$ROOT = $PSScriptRoot
$VENV_DIR = Join-Path $ROOT ".venv"
$VENV_PY  = Join-Path $VENV_DIR "Scripts\python.exe"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Anonimizzatore General Purpose" -ForegroundColor Cyan
Write-Host "  Web UI — Windows" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# 1. Trova Python di sistema (usato solo per creare il venv)
$sysPy = $null
$cmd = Get-Command python -ErrorAction SilentlyContinue
if ($cmd) { $sysPy = $cmd.Source }
if (-not $sysPy) {
    $cmd = Get-Command python3 -ErrorAction SilentlyContinue
    if ($cmd) { $sysPy = $cmd.Source }
}

# Cerca anche nelle posizioni standard di Python.org
if (-not $sysPy) {
    $candidates = @(
        "$env:LOCALAPPDATA\Programs\Python\Python313\python.exe",
        "$env:LOCALAPPDATA\Programs\Python\Python312\python.exe",
        "$env:LOCALAPPDATA\Programs\Python\Python311\python.exe",
        "$env:LOCALAPPDATA\Programs\Python\Python310\python.exe",
        "C:\Python313\python.exe",
        "C:\Python312\python.exe",
        "C:\Python311\python.exe",
        "C:\Python310\python.exe"
    )
    foreach ($c in $candidates) {
        if (Test-Path $c) { $sysPy = $c; break }
    }
}

if (-not $sysPy) {
    Write-Host "ERRORE: Python non trovato." -ForegroundColor Red
    Write-Host "Installa Python 3.10+ da https://python.org/downloads/" -ForegroundColor Yellow
    Write-Host "Assicurati di spuntare 'Add Python to PATH' durante l'installazione." -ForegroundColor Yellow
    exit 1
}

# Verifica versione minima Python 3.10
$verCheck = & $sysPy -c "import sys; ok = sys.version_info >= (3,10); print('OK' if ok else 'OLD')" 2>&1
if ($verCheck -ne "OK") {
    $ver = & $sysPy --version 2>&1
    Write-Host "ERRORE: Python 3.10+ richiesto. Trovato: $ver" -ForegroundColor Red
    Write-Host "Aggiorna da https://python.org/downloads/" -ForegroundColor Yellow
    exit 1
}

$verStr = & $sysPy --version 2>&1
Write-Host "Python: $verStr" -ForegroundColor Green

# 2. Crea venv locale se non esiste
if (-not (Test-Path $VENV_PY)) {
    Write-Host "Creazione ambiente virtuale in .venv ..." -ForegroundColor Yellow
    & $sysPy -m venv $VENV_DIR
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERRORE nella creazione del venv." -ForegroundColor Red
        exit 1
    }
    Write-Host "Ambiente virtuale creato" -ForegroundColor Green
}

# 3. Installa dipendenze solo se mancano
$flaskOk = & $VENV_PY -c "import flask" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "Installazione dipendenze (1-2 min la prima volta)..." -ForegroundColor Yellow
    & $VENV_PY -m pip install -q --upgrade pip
    & $VENV_PY -m pip install -q -r (Join-Path $ROOT "requirements.txt") flask
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ERRORE nell'installazione delle dipendenze." -ForegroundColor Red
        exit 1
    }
    Write-Host "Dipendenze installate" -ForegroundColor Green
} else {
    Write-Host "Dipendenze OK" -ForegroundColor Green
}

# 4. Avvia server
Write-Host ""
Write-Host "Avvio server su http://localhost:$Port" -ForegroundColor Green
Write-Host "Premi Ctrl+C per fermare" -ForegroundColor Gray
Write-Host ""

Set-Location $ROOT
$env:FLASK_PORT = $Port
if ($NoBrowser) { $env:ANON_NO_BROWSER = "1" } else { $env:ANON_NO_BROWSER = "" }
& $VENV_PY app_web.py
