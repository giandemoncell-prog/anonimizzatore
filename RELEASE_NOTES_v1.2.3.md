# Anonimizzatore General Purpose v1.2.3

Versione di miglioramento: i documenti Word anonimizzati mantengono l'aspetto originale, e il testo resta più leggibile.

## Novità

- **I documenti Word mantengono tabelle e formattazione.** Prima un `.docx` anonimizzato diventava una sequenza di paragrafi semplici: tabelle, grassetti, intestazioni e impaginazione andavano persi. Ora il programma modifica una copia del documento originale sostituendo solo i dati personali, quindi tabelle, stili, caselle di testo e intestazioni restano al loro posto. Per sicurezza:
  - immagini e loghi vengono rimossi, perché possono contenere dati che il programma non legge (foto, firme, nome della scuola);
  - vengono cancellati i metadati del file (autore, ultimo salvataggio…);
  - se il documento contiene revisioni tracciate, commenti o note a piè di pagina, oppure se il modello AI ha modificato il testo in modo non verificabile, il programma torna all'output semplice di prima, che è sempre sicuro.
- **Intestazioni, piè di pagina e caselle di testo vengono anonimizzati.** Prima non venivano letti affatto.
- **Le date delle leggi e i codici diagnostici restano leggibili.** Riferimenti come "Legge 3 agosto 2009 n. 102", "D.Lgs. n. 66 del 13 aprile 2017" o "ICD-10: F84.0" non vengono più trasformati in `[Data]` o `[CAP]`. Le date personali (nascita, visite, colloqui) vengono sostituite come sempre. Nei profili si possono aggiungere altri testi da non toccare con la nuova opzione `keep_rules`.
- **`--output-dir` funziona.** Da riga di comando i file prodotti, compresa la mapping e i file de-anonimizzati, possono essere salvati in un'altra cartella. Con `--batch` viene ricreata la struttura delle sottocartelle.

## Correzioni

- **Il profilo predefinito resta quello scelto.** L'interfaccia grafica salvava in `settings.yaml` il nome visualizzato del profilo invece del nome del file, e a ogni avvio riscriveva il file spostando i commenti. Ora salva solo ciò che cambia e lascia intatto il resto.
- **Il modello scelto non viene più sostituito.** Se in Ollama il modello compariva come `nome:latest` (per esempio `llama3.2:latest`), l'interfaccia grafica non lo riconosceva come quello configurato e ne selezionava un altro.

## Come aggiornare

Scarica l'installer o lo ZIP allegato e installalo sopra la versione precedente. Se hai modificato i profili YAML, conserva una copia dei tuoi file prima di aggiornare.

---

Domande, segnalazioni o richieste di nuovi formati e profili: **giandemoncell@gmail.com**
