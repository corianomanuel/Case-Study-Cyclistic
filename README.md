# Comprensione del Case Study

All'interno del Case Study ricopro il ruolo di Junior Data Analyst all'interno del marketing analyst team di una società immaginaria di bike-sharing a Chicago, Cyclistic. Tale società ha lanciato un sistema di bike-sharing basato su tre diverse opzioni tariffarie:
- single-ride passes
- full-day passes
- annual membership.

I clienti che approcciano alle prime due forme di offerta sono definiti clienti occasionali, mentre coloro che attuano la membership annuale vengono considerati membri Cyclistic.

Secondo gli analisti finanziari, gli utenti che sottoscrivono un abbonamento annuale generano un valore economico superiore per l'azienda rispetto ai clienti occasionali che acquistano solo pass giornalieri o per singole corse. 

Tale indicazione ha spinto il Direttore Marketing a sostenere di conseguenza come il futuro dell'azienda dipenda fortemente dall'aumento del numero di membri annuali. Sulla base di ciò vuole elaborare strategie di marketing atte alla conversione dei consumatori occasionali in membri Cyclistic.

A tale scopo, sorgono tre domande per guidare l'elaborazione:
- In che modo i membri annuali e i rider occasionali utilizzano le biciclette di Cyclistic?
- Perché i rider occasionali dovrebbero acquistare un abbonamento annuale di Cyclistic?
- Come può Cyclistic utilizzare i media digitali per influenzare i rider occasionali a diventare membri?

Il direttore marketing in questo Case Study mi ha assegnato la risposta della prima domanda, consapevole di come l'analisi dei dati storici potrebbe aiutare ad identificare particolari insight da sfruttare nell'elaborazione delle strategie.

## Ask Phase

In tale prima fase si cerca di comprendere maggiormente il contesto aziendale e l'obiettivo del compito assegnato.

Cyclistic è un'azienda immaginaria che opera nel settore del bike-sharing a Chicago. Offre un sistema di noleggio biciclette caratterizzato da un’ampia rete di docking station sparse per la città, con l’obiettivo di fornire una mobilità urbana sostenibile e accessibile. Per una maggiore inclusività, l'offerta comprende anche modelli come biciclette reclinabili, tricicli a mano e bici cargo, pensate per persone con disabilità o che non possono utilizzare una bicicletta standard.

Tale tipologia di noleggio biciclette consente agli utenti di prelevare una bicicletta da una stazione di raccolta (detta docking station) e restituirla ad un'altra stazione dello stesso circuito.

Si ipotizza che gli utenti possano accedere al servizio tramite:
- App mobile per localizzare le biciclette disponibili e gestire il noleggio.
- Totem nelle docking station per sbloccare direttamente una bicicletta in loco.
- Account dedicato per un accesso rapido: solo per i membri annuali.

Successivamente l'utente può portare la bicicletta in una qualsiasi stazione di docking Cyclistic disponibile, dove questa viene bloccata inserendola in uno degli slot disponibili nella docking station, terminando automaticamente il noleggio. Qui, l'app mobile (se usata) o il sistema interno registra l'orario e il luogo di riconsegna.

Sulla base di tali informazioni, si vogliono utilizzare i dati storici per comprendere le differenze comportamentali tra i rider occasionali e i membri annuali negli ultimi 12 mesi.


## Prepare Phase
