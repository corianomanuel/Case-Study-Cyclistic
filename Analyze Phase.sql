-- Ad ogni operazione indicata è stato preferito sfruttare la funzionalità di BigQuery di trasferire il risultato all'interno di una tabella apposita

-- Creazione colonna con nome del giorno della settimana associato al giorno di inizio del servizio di sharing
SELECT
    ride_id,
    FORMAT_TIMESTAMP('%A', TIMESTAMP(started_at)) AS day_of_week,
    started_at,
    ended_at,
    trip_duration_min,
    start_station_name,
    end_station_name,
    rideable_type,
    member_casual,
FROM `myfirstcasestudy-446813.Cyclistic.alldata_clean`

-- Creazione di una nuova colonna in cui indicare la parte della giornata in cui avviene l'inizio del noleggio, individuando le seguenti categorie: Night, Morning, Afternoon e Evening.
SELECT
ride_id,
day_of_week,
started_at,
ended_at,
trip_duration_min,
start_station_name,
end_station_name,
rideable_type,
member_casual,
CASE
  WHEN EXTRACT(HOUR FROM TIMESTAMP(started_at)) BETWEEN 0 AND 5 THEN 'Night'
  WHEN EXTRACT(HOUR FROM TIMESTAMP(started_at)) BETWEEN 6 AND 11 THEN 'Morning'
  WHEN EXTRACT(HOUR FROM TIMESTAMP(started_at)) BETWEEN 12 AND 17 THEN 'Afternoon'
  WHEN EXTRACT(HOUR FROM TIMESTAMP(started_at)) BETWEEN 18 AND 23 THEN 'Evening'
  END AS time_of_day
FROM `myfirstcasestudy-446813.Cyclistic.alldata_cleaned`

-- Creazione di una nuova colonna in cui categorizzare la durata, individuando le seguenti categorie: Very Short, Short, Medium, Long e Very long.
SELECT
ride_id,
day_of_week,
started_at,
ended_at,
trip_duration_min,
start_station_name,
end_station_name,
rideable_type,
member_casual,
time_of_day,
CASE
 WHEN trip_duration_min <= 5 THEN 'Very Short'
 WHEN trip_duration_min BETWEEN 6 AND 15 THEN 'Short'
 WHEN trip_duration_min BETWEEN 16 AND 30 THEN 'Medium'
 WHEN trip_duration_min BETWEEN 31 AND 60 THEN 'Long'
 WHEN trip_duration_min > 60 THEN 'Very Long'
 END AS duration_category
FROM `myfirstcasestudy-446813.Cyclistic.alldata_cleaned`

