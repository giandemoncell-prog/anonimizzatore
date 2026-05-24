# Anonimizzatore General Purpose v1.1.0

Strumento desktop per Windows che anonimizza documenti contenenti dati personali e sensibili, funzionando interamente sul tuo computer. Nessun dato viene inviato al cloud.

## Novità in questa versione

- **GUI di de-anonimizzazione** — ripristina i documenti ai valori originali partendo dal file di mapping JSON, direttamente dall'interfaccia grafica.
- **Profilo Universal** — 16 regole regex globali multilingua, attivo come profilo predefinito.
- **Modalità "Solo Regex"** — anonimizzazione completamente offline senza alcun modello AI (checkbox nella GUI, flag `--no-ai` da riga di comando).
- **Supporto a 16 formati** — inclusi i formati OpenDocument (ODT/ODS), presentazioni PowerPoint (PPTX), Rich Text (RTF) ed email (MSG, EML).
- **Pseudonimizzazione reversibile** — ogni sostituzione viene registrata in una mapping table JSON, così puoi tornare ai dati originali quando necessario.
- **Batch processing** — elabora intere cartelle in un solo passaggio, saltando automaticamente i file già anonimizzati.
- **Impostazioni backend persistenti** — la configurazione AI (provider, modello, endpoint) viene salvata automaticamente tra una sessione e l'altra.

## Formati supportati (16)

| Categoria | Formati |
|---|---|
| Testo | `.txt` `.md` |
| Office | `.docx` `.pdf` `.xlsx` |
| Presentazioni | `.pptx` |
| Dati | `.csv` `.json` `.xml` |
| Web | `.html` `.htm` |
| Email | `.eml` `.msg` |
| OpenDocument | `.odt` `.ods` |
| Rich Text | `.rtf` |

## Profili disponibili (6)

| Profilo | Uso |
|---|---|
| **Universal** | 16 regex globali multilingua — profilo predefinito, adatto a qualsiasi documento |
| **Italian Legal** | Atti, fascicoli e documenti legali italiani |
| **Italian Medical** | Cartelle e referti sanitari |
| **Italian Educational** | PDP, PEI e documentazione scolastica |
| **Italian HR** | Documenti per risorse umane e selezione del personale |
| **English Generic** | Documenti generici in lingua inglese |

I profili sono file YAML modificabili posizionati accanto all'eseguibile: puoi adattarli alle tue esigenze o crearne di nuovi.

## Come iniziare

1. **Scarica** il file ZIP allegato a questa release.
2. **Estrai** l'archivio in una cartella a tua scelta.
3. **Avvia** `Anonimizzatore.exe`. Non serve installare Python né altre dipendenze.

In modalità "Solo Regex" sei subito operativo e completamente offline. Per la fase AI contestuale, configura un'istanza Ollama locale o un endpoint OpenAI-compatible dalle impostazioni.

## Note tecniche

- **Bundle Windows standalone** — nessuna installazione di Python richiesta, tutto incluso nell'eseguibile.
- **Dimensione** — circa 37 MB.
- **AI opzionale** — Ollama in locale oppure qualsiasi API OpenAI-compatible. La connessione avviene solo verso l'endpoint che configuri tu.
- **Modalità offline** — la modalità "Solo Regex" non richiede alcun modello e non effettua nessuna connessione di rete.
- **Pipeline a due fasi** — regex deterministiche per gli identificatori strutturati, seguite da un passaggio AI contestuale opzionale per nomi e dettagli non strutturati.

---

Domande, segnalazioni o richieste di nuovi formati e profili: **giandemoncell@gmail.com**
