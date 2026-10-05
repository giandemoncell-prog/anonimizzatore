# Anonimizzatore General Purpose v1.2.2

Versione di correzione, nata dalla prova su documenti scolastici reali (PEI). Consigliata a chi anonimizza documenti scolastici o usa la fase AI.

## Correzioni importanti

- **Dati scolastici che restavano visibili.** In un PEI reale rimanevano in chiaro le iniziali dell'alunno, l'indirizzo e il comune della sede e, a volte, il nome della scuola. Messi insieme bastano a riconoscere lo studente. Ora vengono sostituiti:
  - le **iniziali** dopo "Alunno/a", "Studente", "Nome", "Iniziali" (es. "Alunno/a (iniziali): P. M.");
  - il **nome della scuola** tra virgolette dopo il tipo di istituto (es. ISTITUTO DI ISTRUZIONE SUPERIORE «…», I.C. "…");
  - gli **indirizzi senza numero civico**, quando sono seguiti dal CAP o dal comune tra parentesi;
  - il **comune scritto dopo il CAP**.
- **Parole comuni scambiate per nomi.** Il modello AI a volte sostituiva parole come "DOCENTE" o "insegnante" come se fossero nomi, e il programma estendeva la sostituzione a tutto il documento, rovinando intestazioni e tabelle. Ora una parola comune non viene mai trattata come dato personale e resta com'era.
- **Ripristino più preciso.** Quando il modello alterava più placeholder vicini (es. CAP e comune), la numerazione andava persa e quei dati non si potevano ripristinare. Ora vengono riallineati uno per uno.
- **Crash da riga di comando con alcuni simboli.** Caratteri come "☑", frequenti nei moduli, facevano chiudere `anonymize.py` a metà elaborazione quando l'output non andava su una console interattiva, perdendo il lavoro. Ora l'anteprima a video sostituisce i caratteri non rappresentabili con "?", mentre il file salvato resta completo. La versione con interfaccia grafica non era interessata.

## Note

I profili italiani e il profilo universale contengono nuove regole. Se hai profili personalizzati, puoi copiare le regole che ti servono da quelli inclusi (cerca "Iniziali", "Indirizzi senza civico", "Comune dopo il CAP" e "Nome scuola").

## Come aggiornare

Scarica l'installer o lo ZIP allegato e installalo sopra la versione precedente. Se hai modificato i profili YAML, conserva una copia dei tuoi file prima di aggiornare.

---

Domande, segnalazioni o richieste di nuovi formati e profili: **giandemoncell@gmail.com**
