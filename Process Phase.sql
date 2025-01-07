-- Controllo presenza di osservazioni duplicate
SELECT ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
start_station_id,
end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng,
member_casual,COUNT(*) AS occurrence
FROM `myfirstcasestudy-446813.Cyclistic.alldata_tripdata`
GROUP BY ride_id,
rideable_type,
started_at,
ended_at,
start_station_name,
start_station_id,
end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng,
member_casual
HAVING COUNT(*) > 1;

-- Controllo presenza di valori NULL nella colonna ride_id
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.alldata_tripdata`
WHERE ride_id IS NULL

-- Controllo presenza di valori duplicati nella colonna ride_id
SELECT DISTINCT ride_id FROM `myfirstcasestudy-446813.Cyclistic.alldata_tripdata`


-- Creazione tabella senza righe con ride_id duplicati
SELECT * FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY ride_id ORDER BY started_at) AS row_num
FROM `myfirstcasestudy-446813.Cyclistic.alldata_tripdata` )
WHERE row_num = 1;

-- Controllo che ogni stringa all'interno di ride_id sia di 16 caratteri
SELECT ride_id, LENGTH(ride_id) AS lunghezza
FROM `myfirstcasestudy-446813.Cyclistic.alldata_cleanduplicate`
WHERE LENGTH(ride_id) != 16;

-- Verifica presenza di valori NULL in rideable_type
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.alldata_tripdata`
WHERE rideable_type IS NULL

-- Eliminazione millisecondi in started_at ed ended_at
SELECT ride_id,
rideable_type,
FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP(started_at)) AS started_at,
FORMAT_TIMESTAMP('%Y-%m-%d %H:%M:%S', TIMESTAMP(ended_at)) AS ended_at,
start_station_name,
start_station_id,
end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng,
member_casual
FROM `myfirstcasestudy-446813.Cyclistic.alldata_cleanduplicate`

-- Verifica presenza valori NULL in started_at ed ended_at
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.alldata_cleanduplicate`
WHERE started_at IS NOT NULL

SELECT * FROM `myfirstcasestudy-446813.Cyclistic.alldata_cleanduplicate`
WHERE ended_at IS NOT NULL

-- Verifica presenza di osservazioni con stessi valori in ogni seguente colonna started_at, ended_at, start_station_name ed ended_station_name
SELECT
    started_at,
    ended_at,
    start_station_name,
    end_station_name,
    start_station_id,
    end_station_id,
    COUNT(*) AS duplicate_count
FROM `myfirstcasestudy-446813.Cyclistic.alldata_cleanduplicate`
GROUP BY started_at, ended_at, start_station_name, end_station_name, start_station_id, end_station_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Rimozione dei duplicati individuati nella combinazione designata
SELECT *
FROM (
    SELECT *,ROW_NUMBER() OVER (PARTITION BY started_at, ended_at, start_station_name, end_station_name, start_station_id, end_station_id
	ORDER BY ride_id) AS row_num
    FROM `myfirstcasestudy-446813.Cyclistic.alldata_cleanduplicate`
)
WHERE row_num = 1;

-- Rimozione osservazioni con valori NULL in start_station_name e start_station_id
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.alldata_clean`
WHERE start_station_name IS NOT NULL AND start_station_id IS NOT NULL;

-- Rimozione osservazioni con valori NULL in end_station_name e end_station_id
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.alldata_clean`
WHERE end_station_name IS NOT NULL AND end_station_id IS NOT NULL;

-- Creazione nuova colonna in cui calcolare la durata del viaggio in minuti
SELECT ride_id,
rideable_type,
TIMESTAMP_DIFF(
        PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', ended_at),
        PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', started_at),
        MINUTE
    ) as trip_duration_min,
started_at,
ended_at,
start_station_name,
start_station_id,
end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng,
member_casual
FROM `myfirstcasestudy-446813.Cyclistic.alldata_clean`;

-- Individuazione osservazioni con durata decisamente troppo bassa e sospetta
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.alldata_clean`
ORDER BY trip_duration_min

-- Aggiornamento tabella con solo osservazioni con durata positiva
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.alldata_clean`
WHERE trip_duration_min >= 1

-- Rimozione osservazioni con stazioni di partenza uguali a quelle di arrivo e durata pari ad 1 minuto
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.alldata_clean`
WHERE NOT (trip_duration_min = 1 AND start_station_name = end_station_name);

-- Rimozione anche osservazioni con durata pari a 2 minuti e con stazioni di partenza uguali a quelle di arrivo
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.alldata_clean`
WHERE NOT (trip_duration_min = 2 AND start_station_name = end_station_name);

-- Rimozione osservazioni con durata maggiore a 1440 minuti (1 giorno)
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.alldata_clean`
WHERE trip_duration_min <= 1440

-- Analisi sui nomi delle stazioni citati solamente una volta durante l'anno
SELECT start_station_name, COUNT(start_station_name) AS count_station
FROM `myfirstcasestudy-446813.Cyclistic.alldata_clean`
GROUP BY start_station_name
HAVING COUNT(start_station_name) = 1

-- Correzione stringhe all'interno delle colonne start_station_name ed end_station_name con spazi inutili
SELECT ride_id,
rideable_type,
trip_duration_min,
PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', started_at) AS started_at,
PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', ended_at) AS ended_at,
REGEXP_REPLACE(start_station_name, r'\s{2,}', ' ') AS start_station_name,
start_station_id,
REGEXP_REPLACE(end_station_name, r'\s{2,}', ' ') AS end_station_name,
end_station_id,
start_lat,
start_lng,
end_lat,
end_lng,
member_casual
FROM `myfirstcasestudy-446813.Cyclistic.alldata_clean`;

