-- Ad ogni operazione indicata è stato preferito sfruttare la funzionalità di BigQuery di trasferire il risultato all'interno di una tabella apposita

-- Creazione tabella unica di maggio 2024 unendo le due tabelle inerenti a maggio 2024 / operazione ripetuta per ogni mensilità > 100mb
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_05_tripdata_1`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_05_tripdata_2`

-- Rimozione tabelle di comodità
DROP TABLE `myfirstcasestudy-446813.Cyclistic.2024_05_tripdata_1`
DROP TABLE `myfirstcasestudy-446813.Cyclistic.2024_05_tripdata_2`

-- Creazione tabella unica dell'interno anno preso in considerazione
CREATE TABLE `myfirstcasestudy-446813.Cyclistic.alldata` AS
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.dic_23`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.gen_24`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.feb_24`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.mar_24`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.apr_24`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.mag_24`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.giu_24`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.lug_24`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.ago_24`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.set_24`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.ott_24`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.nov_24`
