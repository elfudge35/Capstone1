UPDATE       source_fighterdata
SET                Time = '0' + Time
WHERE        (Time LIKE ':%')

UPDATE dbo.source_fighterdata
SET Time = REPLACE(Time, '"', ':')
WHERE		(Time LIKE N'_"__')

UPDATE       source_fighterdata
SET                Time = CAST(FLOOR(ABS(CAST(Time AS float) * 24)) AS varchar) + ':' + CAST(ROUND((ABS(CAST(Time AS float) * 24) - FLOOR(ABS(CAST(Time AS float) * 24))) * 60, 0) AS varchar)
WHERE        (Time LIKE '%.%' AND LEN(Time) > 5)

UPDATE dbo.source_fighterdata
SET Time = REPLACE(Time, '.', ':')
WHERE		(Time LIKE N'%.%')

UPDATE       source_fighterdata
SET                Time = '0' + Time
WHERE        (LEN(Time) - LEN(REPLACE(Time, ':', '')) = 2 AND LEN(Time) = 7)

UPDATE       source_fighterdata
SET                Time = RIGHT(Time, 5)
WHERE        (LEN(Time) - LEN(REPLACE(Time, ':', '')) = 2 AND LEFT(Time, 3) = '00:' AND LEN(Time) = 8)

UPDATE       source_fighterdata
SET                Time = LEFT(Time, 5)
WHERE        (LEN(Time) - LEN(REPLACE(Time, ':', '')) = 2 AND RIGHT(Time, 3) = ':00')

UPDATE dbo.source_fighterdata
SET Time = REPLACE(REPLACE(Time, ';', ':'), '::', ':')
WHERE		(Time LIKE N'%;%')

UPDATE dbo.source_fighterdata
SET Time = Time + ':00'
WHERE		(LEN(Time) = 1)

UPDATE dbo.source_fighterdata
SET Time = '04:00'
WHERE		(Time = '354363')

UPDATE dbo.source_fighterdata
SET Time = '00:00'
WHERE		(Time = 'KO/TKO0:')

UPDATE dbo.source_fighterdata
SET Time = '00:21'
WHERE		(Time = '021')

UPDATE dbo.source_fighterdata
SET Time = '05:00'
WHERE		(Time = '05')

UPDATE dbo.source_fighterdata
SET Time = 'N/A'
WHERE		(Time = 'M/A')

UPDATE dbo.source_fighterdata
SET Time = '05:00'
WHERE		(Time = '500')

UPDATE dbo.source_fighterdata
SET Time = '01:01'
WHERE		(Time = '1:1')

UPDATE dbo.source_fighterdata
SET Time = '01:40'
WHERE		(Time = '1:4')

UPDATE dbo.source_fighterdata
SET Time = '02:00'
WHERE		(Time = '2:0')

UPDATE dbo.source_fighterdata
SET Time = '00:23'
WHERE		(Time = '23')

UPDATE dbo.source_fighterdata
SET Time = '02:41'
WHERE		(Time = '241')

UPDATE dbo.source_fighterdata
SET Time = '03:00'
WHERE		(Time = '3:0')

UPDATE dbo.source_fighterdata
SET Time = '03:50'
WHERE		(Time = '3:5')

UPDATE dbo.source_fighterdata
SET Time = '00:38'
WHERE		(Time = '38')

UPDATE dbo.source_fighterdata
SET Time = '04:20'
WHERE		(Time = '4:2')

UPDATE dbo.source_fighterdata
SET Time = '01:32'
WHERE		(Time = '0:L32')

UPDATE dbo.source_fighterdata
SET Time = '03:35'
WHERE		(Time = '3:35q')

UPDATE dbo.source_fighterdata
SET Time = '02:24'
WHERE		(Time = '2:242')

UPDATE dbo.source_fighterdata
SET Time = '03:00'
WHERE		(Time = '3:300')

UPDATE dbo.source_fighterdata
SET Time = '01:34'
WHERE		(Time = '1:#4')

UPDATE dbo.source_fighterdata
SET Time = '01:37'
WHERE		(Time = '0:97')

UPDATE dbo.source_fighterdata
SET Time = '01:05'
WHERE		(Time = '1:$5')

UPDATE dbo.source_fighterdata
SET Time = '02:05'
WHERE		(Time = '1:65')

UPDATE dbo.source_fighterdata
SET Time = '10:00'
WHERE		(Time = '10:0')

UPDATE dbo.source_fighterdata
SET Time = '02:15'
WHERE		(Time = '1:75')

UPDATE dbo.source_fighterdata
SET Time = '01:55'
WHERE		(Time = '1:95')

UPDATE dbo.source_fighterdata
SET Time = '02:05'
WHERE		(Time = '2: 5')

UPDATE dbo.source_fighterdata
SET Time = '02:13'
WHERE		(Time = '2:!3')

UPDATE dbo.source_fighterdata
SET Time = '02:15'
WHERE		(Time = '2:!5')

UPDATE dbo.source_fighterdata
SET Time = '02:27'
WHERE		(Time = '2?27')

UPDATE dbo.source_fighterdata
SET Time = '03:12'
WHERE		(Time = '3:!2')

UPDATE dbo.source_fighterdata
SET Time = '03:17'
WHERE		(Time = '3:!7')

UPDATE dbo.source_fighterdata
SET Time = '03:55'
WHERE		(Time = '3:95')

UPDATE dbo.source_fighterdata
SET Time = '03:02'
WHERE		(Time = '3_02')

UPDATE dbo.source_fighterdata
SET Time = '03:11'
WHERE		(Time = '3L11')

UPDATE dbo.source_fighterdata
SET Time = '04:16'
WHERE		(Time = '4:!6')

UPDATE dbo.source_fighterdata
SET Time = '04:05'
WHERE		(Time = '4:#5')

UPDATE dbo.source_fighterdata
SET Time = '04:44'
WHERE		(Time = '4:85')

UPDATE dbo.source_fighterdata
SET Time = '04:48'
WHERE		(Time = '4:92')

UPDATE dbo.source_fighterdata
SET Time = '05:00'
WHERE		(Time = '5:99')

UPDATE dbo.source_fighterdata
SET Time = '0' + Time
WHERE		(LEN(Time) = 4)

UPDATE dbo.source_fighterdata
SET AdjustedRound = 3, AdjustedTime = CASE WHEN Time < '05:00' THEN '05:00' WHEN Time = 'N/A' THEN '05:00' ELSE Time END
WHERE		(AdjustedTime IS NULL AND MethodClean = 'Decision' AND NOT (Referee = 'N/A') AND Round <> 0)

UPDATE dbo.source_fighterdata
SET AdjustedRound = Round, AdjustedTime = CASE WHEN Time = '00:00' THEN '02:30' ELSE Time END
WHERE		(AdjustedTime IS NULL AND AdjustedRound IS NULL AND NOT (Referee = 'N/A') AND Round <> 0 AND NOT(MethodClean IN ('DQ', 'N/A', 'No Contest')) AND NOT(Time = 'N/A'))

UPDATE dbo.source_fighterdata
SET TotalTime = CAST((AdjustedRound - 1) * 5 AS decimal(6,2)) + CAST(LEFT(AdjustedTime, 2) * 1 AS decimal(6,2)) + CAST(CAST(RIGHT(AdjustedTime, 2) * 1 AS float) / 60 AS decimal(6,2))
WHERE		(AdjustedTime IS NOT NULL)

UPDATE dbo.source_fighterdata
SET TotalTime = 15
WHERE		(TotalTime > 15)

UPDATE dbo.source_fighterdata
SET Date = NULL
WHERE		(Date = '1900-01-01 00:00:00.000' AND Result IS NOT NULL AND TotalTime IS NOT NULL)

