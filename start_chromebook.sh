#!/usr/bin/env bash
# start_chromebook.sh — Avvia Anonimizzatore Web UI su Chromebook/Linux
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colori
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo "========================================"
echo "  Anonimizzatore General Purpose"
echo "  Web UI — Chromebook/Linux"
echo "========================================"
echo ""

# 1. Verifica Python 3
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Errore: Python 3 non trovato.${NC}"
    echo "Installa con: sudo apt install python3 python3-pip"
    exit 1
fi

PYTHON=$(command -v python3)
echo -e "${GREEN}Python:${NC} $($PYTHON --version)"

# 2. Verifica/crea venv locale
VENV_DIR="$SCRIPT_DIR/.venv_web"
if [ ! -d "$VENV_DIR" ]; then
    echo -e "${YELLOW}Creazione ambiente virtuale...${NC}"
    $PYTHON -m venv "$VENV_DIR"
fi

PYTHON="$VENV_DIR/bin/python"
PIP="$VENV_DIR/bin/pip"

# 3. Installa dipendenze
echo -e "${YELLOW}Verifica dipendenze...${NC}"
$PIP install -q -r requirements.txt flask
echo -e "${GREEN}Dipendenze OK${NC}"

# 4. Avvia server
echo ""
echo -e "${GREEN}Avvio server su http://localhost:5000${NC}"
echo "Premi Ctrl+C per fermare"
echo ""

$PYTHON app_web.py
