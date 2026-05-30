#!/usr/bin/env bash
# start_chromebook.sh — Avvia Anonimizzatore Web UI su Chromebook/Linux
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BOLD='\033[1m'; NC='\033[0m'

echo ""
echo -e "${BOLD}========================================${NC}"
echo -e "${BOLD}  Anonimizzatore General Purpose${NC}"
echo -e "${BOLD}  Web UI — Chromebook/Linux${NC}"
echo -e "${BOLD}========================================${NC}"
echo ""

# 1. Verifica Python 3.10+
if ! command -v python3 &>/dev/null; then
    echo -e "${RED}Errore: Python 3 non trovato.${NC}"
    echo "Installa con: sudo apt install python3 python3-pip python3-venv"
    exit 1
fi

PYVER_MAJOR=$(python3 -c "import sys; print(sys.version_info.major)")
PYVER_MINOR=$(python3 -c "import sys; print(sys.version_info.minor)")
if [ "$PYVER_MAJOR" -lt 3 ] || { [ "$PYVER_MAJOR" -eq 3 ] && [ "$PYVER_MINOR" -lt 10 ]; }; then
    echo -e "${RED}Errore: Python 3.10+ richiesto. Trovato: $(python3 --version)${NC}"
    exit 1
fi
echo -e "${GREEN}Python: $(python3 --version)${NC}"

# 2. Crea venv locale se non esiste
VENV_DIR="$SCRIPT_DIR/.venv_web"
if [ ! -d "$VENV_DIR" ]; then
    echo -e "${YELLOW}Creazione ambiente virtuale...${NC}"
    python3 -m venv "$VENV_DIR"
    echo -e "${GREEN}Ambiente virtuale creato${NC}"
fi

PYTHON="$VENV_DIR/bin/python"
PIP="$VENV_DIR/bin/pip"

# 3. Installa dipendenze solo se mancano (evita attesa ad ogni avvio)
if ! "$PYTHON" -c "import flask" 2>/dev/null; then
    echo -e "${YELLOW}Installazione dipendenze (1-2 min la prima volta)...${NC}"
    "$PIP" install -q --upgrade pip
    "$PIP" install -q -r requirements.txt flask
    echo -e "${GREEN}Dipendenze installate${NC}"
else
    echo -e "${GREEN}Dipendenze OK${NC}"
fi

# 4. Avvia server
echo ""
echo -e "${GREEN}Avvio server su ${BOLD}http://localhost:5000${NC}"
echo "Premi Ctrl+C per fermare"
echo ""

exec "$PYTHON" app_web.py
