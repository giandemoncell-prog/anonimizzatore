#!/usr/bin/env bash
# install.sh — Installa Anonimizzatore General Purpose su Chromebook/Linux
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

# 1. Verifica Python 3.10+
if ! command -v python3 &>/dev/null; then
    echo -e "${RED}Errore: Python 3 non trovato.${NC}"
    echo "Installa con: sudo apt update && sudo apt install python3 python3-pip python3-venv"
    exit 1
fi

PYVER_MAJOR=$(python3 -c "import sys; print(sys.version_info.major)")
PYVER_MINOR=$(python3 -c "import sys; print(sys.version_info.minor)")
if [ "$PYVER_MAJOR" -lt 3 ] || { [ "$PYVER_MAJOR" -eq 3 ] && [ "$PYVER_MINOR" -lt 10 ]; }; then
    echo -e "${RED}Errore: Python 3.10+ richiesto. Trovato: $(python3 --version)${NC}"
    echo "Aggiorna con: sudo apt update && sudo apt install python3"
    exit 1
fi
echo -e "${GREEN}Python $(python3 --version) OK${NC}"

# 2. Verifica python3-venv disponibile
if ! python3 -m venv --help &>/dev/null; then
    echo -e "${YELLOW}Installazione python3-venv...${NC}"
    sudo apt-get install -y python3-venv
fi

# 3. Copia file nella directory di installazione (se siamo in una dir diversa)
if [ "$SCRIPT_DIR" != "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}Installazione in $INSTALL_DIR ...${NC}"
    mkdir -p "$INSTALL_DIR"
    # Copia tutto tranne venv e cartelle di build
    rsync -a --exclude='.venv_web' --exclude='.venv' --exclude='__pycache__' \
          --exclude='*.pyc' --exclude='dist/' --exclude='build/' \
          "$SCRIPT_DIR/" "$INSTALL_DIR/" 2>/dev/null || \
    cp -r "$SCRIPT_DIR"/. "$INSTALL_DIR/"
    echo -e "${GREEN}File copiati in $INSTALL_DIR${NC}"
fi
cd "$INSTALL_DIR"

# 4. Crea ambiente virtuale
VENV_DIR="$INSTALL_DIR/.venv_web"
if [ ! -d "$VENV_DIR" ]; then
    echo -e "${YELLOW}Creazione ambiente virtuale...${NC}"
    python3 -m venv "$VENV_DIR"
    echo -e "${GREEN}Ambiente virtuale creato${NC}"
fi

# 5. Installa dipendenze
echo -e "${YELLOW}Installazione dipendenze (1-2 minuti)...${NC}"
"$VENV_DIR/bin/pip" install -q --upgrade pip
"$VENV_DIR/bin/pip" install -q -r requirements.txt flask
echo -e "${GREEN}Dipendenze installate${NC}"

# 6. Rendi eseguibili gli script
chmod +x "$INSTALL_DIR/start_chromebook.sh" 2>/dev/null || true

# 7. Crea collegamento nel menu app Linux
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_DIR"
cat > "$DESKTOP_DIR/anonimizzatore.desktop" << EOF
[Desktop Entry]
Name=Anonimizzatore
GenericName=Anonimizzatore Documenti
Comment=Anonimizza documenti sensibili 100% in locale — GDPR compliant
Exec=bash -c "cd $INSTALL_DIR && bash start_chromebook.sh"
Terminal=true
Type=Application
Categories=Office;Utility;Security;
Keywords=privacy;gdpr;anonimizzare;documenti;
EOF
chmod +x "$DESKTOP_DIR/anonimizzatore.desktop" 2>/dev/null || true
update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true
echo -e "${GREEN}Collegamento menu applicazioni creato${NC}"

echo ""
echo -e "${BOLD}========================================${NC}"
echo -e "${GREEN}${BOLD}  Installazione completata!${NC}"
echo -e "${BOLD}========================================${NC}"
echo ""
echo -e "Per avviare l'app:"
echo -e "  ${BOLD}bash $INSTALL_DIR/start_chromebook.sh${NC}"
echo ""
echo -e "Poi apri Chrome e vai su: ${BOLD}http://localhost:5000${NC}"
echo ""
