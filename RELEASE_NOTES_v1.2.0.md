# Anonimizzatore General Purpose v1.2.0

Strumento desktop per Windows che anonimizza documenti contenenti dati personali e sensibili, funzionando interamente sul tuo computer. Nessun dato viene inviato al cloud.

## Correzioni importanti

- **La de-anonimizzazione ora funziona davvero.** Nella v1.1.0 la mapping table veniva salvata sempre vuota: il pulsante "De-anonimizza" restituiva il documento invariato senza segnalare errori. Ora ogni valore individuato dalle regole regex (email, IBAN, telefono, codice fiscale, partita IVA, ecc.) riceve un placeholder numerato univoco (es. `[EMAIL_1]`, `[EMAIL_2]`) e viene tracciato correttamente: la mapping table JSON e la de-anonimizzazione ripristinano ora i valori originali. I dati individuati solo dall'AI (nomi, indirizzi non strutturati) restano per natura non ripristinabili — la GUI lo segnala chiaramente.
- **Profilo predefinito corretto.** La GUI confrontava il profilo salvato in `settings.yaml` solo con il nome visualizzato, mai con il nome file: il profilo predefinito "universal" non veniva mai riconosciuto e l'app ripiegava silenziosamente su un altro profilo, sovrascrivendo la configurazione a ogni avvio. Risolto sia in GUI che da riga di comando.
- **`settings.yaml` non viene più corrotto al salvataggio.** Prima ogni chiusura dell'app riscriveva l'intero file, cancellando tutti i commenti esplicativi e riordinando le chiavi alfabeticamente. Ora vengono aggiornati solo i valori effettivamente cambiati, preservando commenti e struttura.

## Altre novità dalla v1.1.0

- **Compilazione moduli da archivio** (funzione opzionale, `compila_modulo.py`) — compila moduli e schede ricevuti via email usando dati recuperati da un archivio locale e/o Gmail/Drive, senza mai inviare nulla automaticamente.
- **Pacchetti autoinstallanti migliorati** — fix del percorso Python, controllo dipendenze e guardia sulla versione nello script di build.
- **Identità visiva** — logo, social preview e banner README.
- **Privacy Policy** pubblicata e collegata dal footer della landing page.
- **SEO/GEO tecnico completo** sulla landing page GitHub Pages.

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

1. **Scarica** l'installer o il file ZIP allegato a questa release.
2. **Installa/estrai** in una cartella a tua scelta.
3. **Avvia** `Anonimizzatore.exe`. Non serve installare Python né altre dipendenze.

In modalità "Solo Regex" sei subito operativo e completamente offline. Per la fase AI contestuale, configura un'istanza Ollama locale o un endpoint OpenAI-compatible dalle impostazioni.

## Note tecniche

- **Bundle Windows standalone** — nessuna installazione di Python richiesta, tutto incluso nell'eseguibile.
- **AI opzionale** — Ollama in locale oppure qualsiasi API OpenAI-compatible. La connessione avviene solo verso l'endpoint che configuri tu.
- **Modalità offline** — la modalità "Solo Regex" non richiede alcun modello e non effettua nessuna connessione di rete.
- **Pipeline a due fasi** — regex deterministiche per gli identificatori strutturati, seguite da un passaggio AI contestuale opzionale per nomi e dettagli non strutturati.

---

Domande, segnalazioni o richieste di nuovi formati e profili: **giandemoncell@gmail.com**
