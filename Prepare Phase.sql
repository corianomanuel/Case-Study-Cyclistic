-- Creazione tabella unica di maggio 2024
SELECT  * FROM `myfirstcasestudy-446813.Cyclistic.2024_05_tripdata_1` 
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_05_tripdata_2`

-- Creazione tabella unica dell'interno anno preso in considerazione
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2023_12_tripdata`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_01_tripdata`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_02_tripdata`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_03_tripdata`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_04_tripdata`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_05_tripdata`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_06_tripdata`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_07_tripdata`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_08_tripdata`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_09_tripdata`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_10_tripdata`
UNION ALL
SELECT * FROM `myfirstcasestudy-446813.Cyclistic.2024_11_tripdata`
