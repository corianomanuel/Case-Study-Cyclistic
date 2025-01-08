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

Per l'esecuzione dell'esercizio, Google mette a disposizione un [link](https://divvy-tripdata.s3.amazonaws.com/index.html per scaricare i dati necessari all'esecuzione dell'analisi, i quali sono forniti da Motivate International Inc., una fonte rispettata nel settore. Tali file presentano un nome diverso poiché Cyclistic è un'azienda immaginaria, ma nonostante ciò risultano comunque appropriati alla risoluzione del caso aziendale.

Per questioni legate alla privacy dei dati non è possibile utilizzare le informazioni personali degli utenti, garantendo l'impossibilità di una loro identificazione. Di conseguenza, non sarà possibile effettuare qualsiasi collegamento ai loro numeri di carta di credito, i quali consentirebbero, ad esempio, di comprendere se i rider occasionali vivono nell'area di servizio o se nel tempo hanno effettuato molteplici acquisti di singoli pass. Ciò rende l'analisi puramente comportamentale, con conseguente assenza di bias nei dati, proprio perchè si tratta di un insieme di dati oggettivi.

La selezione dei dati è ricaduta sulla raccolta dei file più recenti, inerenti ai viaggi effettuati negli ultimi 12 mesi, più specificamente da dicembre 2023 a novembre 2024, in maniera tale da effettuare un'analisi in ottica annuale, la quale permette di tenere conto di ogni possibile fattore stagionale e dei pattern di comportamento che potrebbero variare durante l'anno. Tali file, in formato .zip, sono stati scaricati ed estratti all'interno di una cartella locale, ottenendo 12 file in formato .csv, ciascuno inerente ad uno specifico mese.

L'enorme dimensione di ogni file, in base anche alla previsione di un'unione in un unico dataset, ha determinato la scelta di evitare l'utilizzo di Google Sheets per utilizzare direttamente BigQuery. Al suo interno è stato creato un progetto denominato 'myfirstcasestudy-446813', al cui interno è stato creato un set di dati denominato 'Cyclistic'. All'interno di tale set di dati sono stati caricati tutti i file .csv, sfruttando la specifica funzione che permette di creare una tabella caricando il file specifico e applicando la funzionalità del rilevamento automatico dello schema della tabella, grazie alla presenza delle virgole, caratteristico dei file .csv. Per sopperire al problema inerente alla dimensione massima di 100mb di upload per ogni file, anziché sfruttare Google Cloud Storage, è stato preferito separare manualmente circa a metà ogni file superiore a 100 mb (quelli da maggio 2024 a novembre 2024), ricopiando i nomi delle colonne nel file contenente la seconda metà, per caricare ciascuna metà in una specifica tabella da unire successivamente in un'unica tabella relativa al mese in questione.

Ogni tabella è stata successivamente controllata:
- per verificare la presenza di tutti i dati, confermando come non siano state perse osservazioni a causa del processo di aggiramento del problema dei 100mb
- l'uniformità dello schema delle tabelle per verificare la condivisione della stessa denominazione e della stessa tipologia di colonne.

Inoltre è stato calcolato il totale di ogni select count, ottenendo una somma totale delle righe pari 5.906.269 osservazioni.

Per unire ogni tabella all'interno di un'unica è stata creata una tabella vuota denominata 'alldata_tripdata' in cui sfruttare l'apposita funzione per riempire tale tabella con il risultato della query di unione, ottenendo una tabella con 5.906.269 osservazioni.


## Process Phase
In seguito ad una comprensione delle colonne presenti all'interno della tabella, è iniziato il seguente processo di pulizia:

1. Ricerca di eventuali osservazioni duplicate: Assenza di osservazioni duplicate
2. Ricerca di valori NULL all'interno della colonna ride_id: Assenza di valori NULL
3. Ricerca di valori duplicati all'interno della colonna ride_id: Rilevazione di 211 righe con ride_id duplicati
4. Creazione nuova tabella senza le righe con ride_id duplicati
5. Controllo che ogni stringa all'interno di ride_id sia di 16 caratteri: Assenza stringhe con numero di caratteri diverso da 16
6. Ricerca di valori NULL all'interno della colonna rideable_type: Assenza di valori NULL
7. Conversione started_at ed ended_at allo stesso formato (alcuni presentavano anche i millisecondi)
8. Ricerca di valori NULL all'interno delle colonne started_at ed ended_at
9. Verifica presenza di osservazioni con stessi valori nella combinazione delle seguenti colonne started_at, ended_at, start_station_name ed ended_station_name: 51 duplicati individuati
10. Rimozione dei duplicati individuati nella combinazione designata
11. Rimozione osservazioni con valori NULL in start_station_name e start_station_id
12. Rimozione osservazioni con valori NULL in end_station_name e end_station_id
13. Creazione nuova colonna in cui calcolare la durata del viaggio in minuti
14. Individuazione osservazioni con durata decisamente troppo bassa e sospetta: 27 osservazioni con durata negativa
15. Aggiornamento tabella con solo osservazioni con durata positiva
16. Analisi e intrepretazione osservazioni di durata pari ad 1 minuto: rimozione osservazioni con stazioni di partenza uguali a quelle di arrivo
17. Rimozione anche osservazioni con durata pari a 2 minuti e con stazioni di partenza uguali a quelle di arrivo
18. Rimozione osservazioni con durata maggiore a 1440 minuti (1 giorno)
19. Analisi sui nomi delle stazioni, notando come ci siano delle stazioni il cui nome è presente pochissime volte nell'arco di un anno, da cui magari dedurre l'inesatta scrittura all'interno del database: esistono 163 stazioni citate solamente una volta all'interno di tale database; tra queste sono presenti diverse stazioni che iniziano per Public Rack, seguite da un trattino e da un nome di una stazione. Tramite informazione esterna, si scopre come Public Rack sia una rastrelliera pubblica installata in città dove le persone possono parcheggiare e assicurare le proprie biciclette. Non è una stazione ufficiale di Cyclistic, ma un'opzione per il parcheggio della bici.
20. Eliminazione eventuali spazi all'inizio o alla fine della stringa: assenti tali osservazioni
21. Correzione stringhe all'interno delle colonne start_station_name ed end_station_name con spazi inutili
22. Tra le 163 stazioni visualizzate solamente una volta in start_station_name, tolte quelle che iniziano con Public Rack, vi sono alcune senza tale indicazione e si procede ad un controllo per visionare l'esistenza di eventuali errori di battitura, rimuovendo solo l'osservazione con NEW HASTINGS come start_station_name.
23. Eliminazione colonne inerenti agli id, alla longitudine e latitudine delle stazioni, poiché ritenute non rilevanti ai fini dell'analisi, consapevole di come un'analisi approfondita, in caso di maggiore tempo a disposizione, avrebbe permesso di ottimizzare ulteriormente la pulizia, analizzando ad esempio la longitudine e la latitudine per confermare l'esattezza del nome delle stazioni.


## Analyze Phase

Il processo di analisi prevede le seguenti azioni:
1. Creazione colonna in cui inserire il relativo nome del giorno della settimana in cui inizia il servizio di sharing in ogni osservazione rilevata
2. Creazione colonna in cui indicare la parte della giornata in cui avviene l'inizio del noleggio, individuando le seguenti categorie: Night, Morning, Afternoon e Evening.
3. Creazione colonna in cui categorizzare la durata, individuando le seguenti categorie: Very Short, Short, Medium, Long e Very long.

Il risultato finale viene scaricato in formato .csv e caricato all'interno di Power BI Desktop per iniziare la vera e propria analisi.
Durante il controllo in seguito al caricamento, si controlla come le colonne started_at ed ended_at siano considerate stringhe a causa della presenza di UTC dopo la data e l'orario all'interno di ogni valore. Per tal motivo si procede tramite Power Query a dividere ciascuna colonna in base dal primo delimitatore *spazio* a partire da destra, con conseguente eliminazione della colonna contenente solo UTC come valore. In autonomia Power BI riconosce immediatamente il formato corretto.

Inizialmente si cerca di comprendere a livello generale il numero di corse effettuate nell'arco di un anno da parte delle due tipologie di utente, approfondendo anche la tipologia di mezzo utilizzata.

![image](https://github.com/user-attachments/assets/ed6c4c2a-64d3-40a5-8e52-31c7072bddca)

L'anno in questione viene analizzato ulteriormente con l'obiettivo di comprendere la distribuzione del numero di corse effettuate nei diversi mesi, confrontando ulteriormente la differenza di approccio ai diversi mesi da parte delle due tipologie di utenti.

![image](https://github.com/user-attachments/assets/1cb79fca-c156-40c3-8afa-abc45cc7f3a1)


Successivamente, si verifica la distribuzione generale del numero di corse durante la settimana, con conseguente approfondimento su tale distribuzione in base alla tipologia di utente. Non notando alcuna rilevanza con la tipologia di mezzo, non si considera più tale informazione.

![image](https://github.com/user-attachments/assets/fcceea5b-5746-4804-ae19-044708880ec4)

Viene sfruttato il potenziale di Tableau per approfondire ulteriormente il numero di corse durante i giorni della settimana nel corso dell'anno.

![Foglio 9](https://github.com/user-attachments/assets/f6e35ca8-53b6-41d6-8209-13ab88798d6d)

Si entra ulteriormente in profondità tramite approfondimento inerente alla parte della giornata in cui inizia il noleggio, sfruttando la divisione della giornata nelle categorie: Morning(6.00-11.59), Afternoon(12.00-17.59), Evening(18.00-23.59) e Night (0.00-5.59).

![image](https://github.com/user-attachments/assets/ca82c3c2-2e55-435c-85be-4ed5604a998b)

Per una maggiore comprensione, viene analizzata ogni parte della giornata in relazione al giorno della settimana.

![image](https://github.com/user-attachments/assets/0e3bfef9-a2d7-440d-8318-3bc35606ce59)

Successivamente si approfondisce la durata tipica di noleggio da parte di ciascuna tipologia di utente, con la consapevolezza che da essa comunque non si possa dedurre l'effettiva distanza percorsa da parte dell'utente, a causa dell'assenza di informazioni sui km esattamente percorsi, non ritenendo sufficiente considerare la distanza tra la stazione di partenza e di consegna.

Inizialmente vengono calcolate le medie delle corse.

![image](https://github.com/user-attachments/assets/26d9fca7-9a17-4919-9504-c9bd35b11b36)

Successivamente si effettua un approfondimento, sfruttando le categorie di durata precedentemente assegnate per dare una spiegazione alle medie individuate: Very Short (< 5 min), Short (tra 6 e 15 min), Medium (tra 16 e 30), Long (tra 31 e 60) e Very Long (>60).

![image](https://github.com/user-attachments/assets/b963433a-5930-4b79-a1c4-3a25510006f2)


Infine, si conclude tale generale analisi individuando quali siano le 20 stazioni più utilizzate sia come stazioni di partenza che come stazioni di deposito.

![Foglio 11](https://github.com/user-attachments/assets/a12ffd7a-51f6-4d63-974a-481bf768a554)

![Foglio 12](https://github.com/user-attachments/assets/2c5ccd9d-9bc0-4857-a4c5-ccf4c5f159bf)




