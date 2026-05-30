#!/usr/bin/env bash
# install.sh — Installa Anonimizzatore General Purpose su Chromebook Linux
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$HOME/Anonimizzatore"
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; BOLD='\033[1m'; NC='\033[0m'

echo ""
echo -e "${BOLD}========================================${NC}"
echo -e "${BOLD}  Anonimizzatore General Purpose${NC}"
echo -e "${BOLD}  Installazione automatica${NC}"
echo -e "${BOLD}========================================${NC}"
echo ""

# 1. Verifica Python 3
if ! command -v python3 &>/dev/null; then
    echo -e "${RED}Errore: Python 3 non trovato.${NC}"
    echo "Installa con: sudo apt update && sudo apt install python3 python3-pip python3-venv"
    exit 1
fi
PYVER=$("$(command -v python3)" --version 2>&1 | grep -oP '\d+\.\d+' | head -1)
echo -e "${GREEN}Python $PYVER trovato${NC}"

# 2. Copia file nella directory di installazione
if [ "$SCRIPT_DIR" != "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}Copio i file in $INSTALL_DIR ...${NC}"
    mkdir -p "$INSTALL_DIR"
    cp -r "$SCRIPT_DIR"/. "$INSTALL_DIR/"
fi
cd "$INSTALL_DIR"

# 3. Crea ambiente virtuale
echo -e "${YELLOW}Creazione ambiente virtuale...${NC}"
python3 -m venv .venv_web
echo -e "${GREEN}Ambiente virtuale creato${NC}"

# 4. Installa dipendenze
echo -e "${YELLOW}Installazione dipendenze (può richiedere 1-2 minuti)...${NC}"
.venv_web/bin/pip install -q --upgrade pip
.venv_web/bin/pip install -q -r requirements.txt flask
echo -e "${GREEN}Dipendenze installate${NC}"

# 5. Rendi eseguibile lo script di avvio
chmod +x "$INSTALL_DIR/start_chromebook.sh" 2>/dev/null || true

# 6. Crea collegamento nel menu app Linux (opzionale)
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_DIR"
cat > "$DESKTOP_DIR/anonimizzatore.desktop" << EOF
[Desktop Entry]
Name=Anonimizzatore
Comment=Anonimizza documenti 100% in locale
Exec=bash -c "cd $INSTALL_DIR && .venv_web/bin/python app_web.py"
Terminal=true
Type=Application
Categories=Office;Utility;
EOF
chmod +x "$DESKTOP_DIR/anonimizzatore.desktop" 2>/dev/null || true
echo -e "${GREEN}Collegamento menu creato${NC}"

echo ""
echo -e "${BOLD}========================================${NC}"
echo -e "${GREEN}  Installazione completata!${NC}"
echo -e "${BOLD}========================================${NC}"
echo ""
echo -e "Per avviare l'app:"
echo -e "  ${BOLD}cd $INSTALL_DIR${NC}"
echo -e "  ${BOLD}bash start_chromebook.sh${NC}"
echo ""
echo -e "Poi apri Chrome su: ${BOLD}http://localhost:5000${NC}"
echo ""
