# Anonimizzatore General Purpose v1.2.1

Versione di correzione, con una novità: la lettura dei PDF scansionati. Chi usa la fase AI o la de-anonimizzazione dovrebbe aggiornare.

## Novità: PDF scansionati

I PDF fatti solo di immagini (scansioni, fax, verbali stampati e riacquisiti) prima risultavano vuoti. Ora le pagine scansionate vengono trascritte da un modello AI con visione che gira sul tuo computer (Ollama), e il testo viene poi anonimizzato come sempre. Le pagine con testo normale vengono lette come prima.

- Serve un modello che sappia leggere le immagini. Se quello configurato non ci riesce, il programma lo segnala e suggerisce i modelli adatti già installati.
- Si può indicare un modello dedicato alla lettura con `ai.ocr_model` in `settings.yaml`.
- In modalità "Solo regex" i PDF scansionati non si possono leggere: il programma lo spiega invece di produrre un file vuoto.

## Correzioni importanti

- **De-anonimizzazione funzionante anche con l'AI attiva.** I modelli AI tendevano a riscrivere i placeholder già presenti nel testo (`[DATE_1]` diventava `[DATE]`), e la mapping table non trovava più nulla da ripristinare. Ora l'output del modello viene confrontato con il testo inviato: la numerazione persa viene ripristinata e il modello riceve un'istruzione esplicita per non toccare i placeholder.
- **Anche i nomi trovati dall'AI ora sono ripristinabili.** Nomi, enti e altre entità sostituite dal modello ricevono un placeholder numerato (`[PERSON_1]`, `[PERSON_2]`) e finiscono nella mapping table. Se il modello riscrive un'intera frase, quella parte può restare non ripristinabile: controlla sempre il risultato.
- **De-anonimizzare un file Word non lo corrompe più.** Il file `.docx` veniva letto come testo semplice e il risultato non si apriva. Ora viene prodotto un `.docx` valido, comprese tabelle, intestazioni e piè di pagina. Per i formati che l'anonimizzatore non produce mai (PDF, Excel...) compare un messaggio chiaro.
- **Elaborazione di cartelle: niente più file sovrascritti.** `contratto.pdf` e `contratto.docx` nella stessa cartella producevano lo stesso file di output e la stessa mapping, e una delle due andava persa. Ora i nomi diventano `contratto_pdf_…` e `contratto_docx_…`, solo quando c'è un conflitto. Le mapping table non vengono più rielaborate se si ripete l'operazione sulla stessa cartella.
- **Due valori diversi non condividono più lo stesso placeholder.** Un numero di telefono internazionale e uno nazionale potevano diventare entrambi `[PHONE_1]` e venire confusi durante il ripristino.
- **Un dato riconosciuto viene tolto ovunque.** Se il modello AI sostituiva un nome o un comune in un punto ma lo lasciava in un altro (un'intestazione, una riga in minuscolo), il dato restava visibile. Ora, una volta riconosciuto, viene sostituito in tutto il documento. I placeholder sono sempre numerati, così `[Paziente_1]` e `[Paziente_2]` indicano persone diverse anche senza salvare la mapping.
- **Niente più attese senza fine con i modelli che "ragionano".** Con modelli come qwen3 o deepseek-r1 il programma restava a lungo senza mostrare nulla, perché il modello ragionava prima di rispondere. Ora questa fase è disattivata per impostazione predefinita, e si può riattivare con `ai.think: true`.

## Meno falsi positivi

- Frasi come "al 100 km" non vengono più scambiate per una targa.
- I numeri di 5 cifre ("35000 persone") non vengono più scambiati per un CAP o uno ZIP code.
- L'etichetta "P.IVA" resta nel testo: viene sostituito solo il numero.

## Più dati personali riconosciuti

Nei profili italiani e nel profilo universale:

- indirizzi scritti in maiuscolo o con la virgola prima del civico ("VIA GIUSEPPE VERDI, 7", "via dei Mille n. 25b");
- numeri di carta d'identità, passaporto e patente, anche in minuscolo, e carte d'identità elettroniche;
- numeri di domanda, verbale, pratica e protocollo (INPS, ASL, enti), oltre ai codici numerici e alfanumerici lunghi. Il codice fiscale non viene toccato.

I profili YAML supportano due nuove opzioni per le regole regex, documentate in `profiles/_template.yaml`: `ignore_case: false` e il gruppo `(?P<value>...)`.

## Messaggi d'errore più chiari

Se il modello AI configurato non è installato in Ollama, il programma lo dice e spiega come scaricarlo (`ollama pull <modello>`), elencando i modelli già disponibili. Prima segnalava, sbagliando, "Ollama non raggiungibile".

## Come aggiornare

Scarica l'installer o lo ZIP allegato e installalo sopra la versione precedente. Se hai modificato i profili YAML, conserva una copia dei tuoi file prima di aggiornare.

---

Domande, segnalazioni o richieste di nuovi formati e profili: **giandemoncell@gmail.com**
