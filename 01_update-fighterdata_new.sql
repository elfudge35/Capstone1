USE rpi

--start import new data--

DELETE FROM source_output

BULK INSERT source_output
FROM 'E:\Dropbox\RPI\02Scripts\output.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n'
	)

DELETE FROM source_output1

BULK INSERT source_output1
FROM 'E:\Dropbox\RPI\02Scripts\output1.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n'
	)

DELETE FROM source_output2

BULK INSERT source_output2
FROM 'E:\Dropbox\RPI\02Scripts\output2.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n'
	)

--end import new data--

--start backup old data--

DELETE FROM source_fighterdata2

INSERT INTO source_fighterdata2
                      (FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, Event, Date, Round, Time, Referee)
SELECT     FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, REPLACE(REPLACE(Event,',',''),'"',''), Date, Round, Time, Referee
FROM         source_fighterdata1

DELETE FROM source_fighterdata1

INSERT INTO source_fighterdata1
                      (FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, Event, Date, Round, Time, Referee)
SELECT     FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, REPLACE(REPLACE(Event,',',''),'"',''), Date, Round, Time, Referee
FROM         source_fighterdata

--end backup old data--

--start consolidate new data--

DELETE FROM source_output_all

INSERT INTO source_output_all
                      (FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, Event, Date, Round, Time, Referee)
SELECT     REVERSE(LEFT(REVERSE(FighterID),CHARINDEX('-',REVERSE(FighterID))-1)), FighterID, REPLACE(LEFT(FighterID, LEN(FighterID)-CHARINDEX('-',REVERSE(FighterID))), '-', ' '), Birthdate, Height, Weight, Result, REVERSE(LEFT(REVERSE(OpponentID),CHARINDEX('-',REVERSE(OpponentID))-1)), OpponentID, Opponent, Method, EventID, REPLACE(REPLACE(Event,',',''),'"',''), Date, Round, Time, Referee
FROM         source_output
UNION
SELECT     REVERSE(LEFT(REVERSE(FighterID),CHARINDEX('-',REVERSE(FighterID))-1)), FighterID, REPLACE(LEFT(FighterID, LEN(FighterID)-CHARINDEX('-',REVERSE(FighterID))), '-', ' '), Birthdate, Height, Weight, Result, REVERSE(LEFT(REVERSE(OpponentID),CHARINDEX('-',REVERSE(OpponentID))-1)), OpponentID, Opponent, Method, EventID, REPLACE(REPLACE(Event,',',''),'"',''), Date, Round, Time, Referee
FROM         source_output1
UNION
SELECT     REVERSE(LEFT(REVERSE(FighterID),CHARINDEX('-',REVERSE(FighterID))-1)), FighterID, REPLACE(LEFT(FighterID, LEN(FighterID)-CHARINDEX('-',REVERSE(FighterID))), '-', ' '), Birthdate, Height, Weight, Result, REVERSE(LEFT(REVERSE(OpponentID),CHARINDEX('-',REVERSE(OpponentID))-1)), OpponentID, Opponent, Method, EventID, REPLACE(REPLACE(Event,',',''),'"',''), Date, Round, Time, Referee
FROM         source_output2
GROUP BY REVERSE(LEFT(REVERSE(FighterID),CHARINDEX('-',REVERSE(FighterID))-1)), FighterID, REPLACE(LEFT(FighterID, LEN(FighterID)-CHARINDEX('-',REVERSE(FighterID))), '-', ' '), Birthdate, Height, Weight, Result, REVERSE(LEFT(REVERSE(OpponentID),CHARINDEX('-',REVERSE(OpponentID))-1)), OpponentID, Opponent, Method, EventID, REPLACE(REPLACE(Event,',',''),'"',''), Date, Round, Time, Referee

--end consolidate new data--

--start fighters with no updates--

DELETE FROM source_noupdatecurrentfighters

INSERT INTO source_noupdatecurrentfighters
                         (FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, Event, Date, Round, Time, Referee)
SELECT        source_fighterdata.FID, source_fighterdata.FighterID, source_fighterdata.Fighter, source_fighterdata.Birthdate, source_fighterdata.Height, source_fighterdata.Weight, source_fighterdata.Result, source_fighterdata.OID, source_fighterdata.OpponentID, 
                         source_fighterdata.Opponent, source_fighterdata.Method, source_fighterdata.EventID, source_fighterdata.Event, source_fighterdata.Date, source_fighterdata.Round, source_fighterdata.Time, source_fighterdata.Referee
FROM            source_fighterdata LEFT OUTER JOIN
                         source_output_all ON source_fighterdata.FID = source_output_all.FID
WHERE        (source_output_all.FID IS NULL)
GROUP BY source_fighterdata.FID, source_fighterdata.FighterID, source_fighterdata.Fighter, source_fighterdata.Birthdate, source_fighterdata.Height, source_fighterdata.Weight, source_fighterdata.Result, source_fighterdata.OID, source_fighterdata.OpponentID, 
                         source_fighterdata.Opponent, source_fighterdata.Method, source_fighterdata.EventID, source_fighterdata.Event, source_fighterdata.Date, source_fighterdata.Round, source_fighterdata.Time, source_fighterdata.Referee

--end fighters with no updates--

--start update current fighters--

DELETE FROM source_updatecurrentfighters

INSERT INTO source_updatecurrentfighters
                         (FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, Event, Date, Round, Time, Referee)
SELECT        source_output_all.FID, source_output_all.FighterID, source_output_all.Fighter, source_output_all.Birthdate, source_output_all.Height, source_output_all.Weight, source_output_all.Result, source_output_all.OID, source_output_all.OpponentID, 
                         source_output_all.Opponent, source_output_all.Method, source_output_all.EventID, source_output_all.Event, source_output_all.Date, source_output_all.Round, source_output_all.Time, source_output_all.Referee
FROM            source_fighterdata INNER JOIN
                         source_output_all ON source_fighterdata.FID = source_output_all.FID
GROUP BY source_output_all.FID, source_output_all.FighterID, source_output_all.Fighter, source_output_all.Birthdate, source_output_all.Height, source_output_all.Weight, source_output_all.Result, source_output_all.OID, source_output_all.OpponentID, 
                         source_output_all.Opponent, source_output_all.Method, source_output_all.EventID, source_output_all.Event, source_output_all.Date, source_output_all.Round, source_output_all.Time, source_output_all.Referee

--end updated current fighters--

--start new fighters--

DELETE FROM source_newfighters

INSERT INTO source_newfighters
                      (FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, Event, Date, Round, Time, Referee)
SELECT     source_output_all.FID, source_output_all.FighterID, source_output_all.Fighter, source_output_all.Birthdate, source_output_all.Height, source_output_all.Weight, source_output_all.Result, source_output_all.OID, source_output_all.OpponentID, source_output_all.Opponent, source_output_all.Method, 
                      source_output_all.EventID, REPLACE(REPLACE(source_output_all.Event,',',''),'"',''), source_output_all.Date, source_output_all.Round, source_output_all.Time, source_output_all.Referee
FROM         source_fighterdata RIGHT OUTER JOIN
                      source_output_all ON source_fighterdata.FID = source_output_all.FID
WHERE     (source_fighterdata.FID IS NULL)
ORDER BY source_output_all.FID, source_output_all.Date DESC

--end new fighters--

--start update fightersdata--

DELETE FROM source_fighterdata

INSERT INTO source_fighterdata
                      (FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, Event, Date, Round, Time, Referee)
SELECT     FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, Event, Date, Round, Time, Referee
FROM         source_noupdatecurrentfighters
UNION
SELECT     FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, Event, Date, Round, Time, Referee
FROM         source_updatecurrentfighters
UNION
SELECT     FID, FighterID, Fighter, Birthdate, Height, Weight, Result, OID, OpponentID, Opponent, Method, EventID, Event, Date, Round, Time, Referee
FROM         source_newfighters
ORDER BY FID, Date DESC

--end update fightersdata--

--start update methodclean--

UPDATE       source_fighterdata
SET                MethodClean = NULL

UPDATE       source_fighterdata
SET                MethodClean = 'DQ'
WHERE        (MethodClean IS NULL AND Method LIKE N'%dq%')

UPDATE       source_fighterdata
SET                MethodClean = 'No Contest'
WHERE        (MethodClean IS NULL AND Method LIKE N'%no con%')

UPDATE       source_fighterdata
SET                MethodClean = 'No Contest'
WHERE        (MethodClean IS NULL AND Method LIKE N'%no decision%')

UPDATE       source_fighterdata
SET                MethodClean = 'Decision'
WHERE        (MethodClean IS NULL AND Method LIKE N'%dr_w%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%suplex%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%choke%')

UPDATE       source_fighterdata
SET                MethodClean = 'No Contest'
WHERE        (MethodClean IS NULL AND Method LIKE N'%overtu%')

UPDATE       source_fighterdata
SET                MethodClean = 'Decision'
WHERE        (MethodClean IS NULL AND Method LIKE N'%dec%')

UPDATE       source_fighterdata
SET                MethodClean = 'No Contest'
WHERE        (MethodClean IS NULL AND Method LIKE N'%nc %')

UPDATE       source_fighterdata
SET                MethodClean = 'DQ'
WHERE        (MethodClean IS NULL AND Method LIKE N'%ill_gal%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%bar%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%kimura%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%lock%')

UPDATE       source_fighterdata
SET                MethodClean = 'DQ'
WHERE        (MethodClean IS NULL AND Method LIKE N'%disq%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%punch%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%kick%')

UPDATE       source_fighterdata
SET                MethodClean = 'N/A'
WHERE        (MethodClean IS NULL AND Method IS NULL)

UPDATE       source_fighterdata
SET                MethodClean = 'N/A'
WHERE        (MethodClean IS NULL AND Method LIKE N'%N/A%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%ko%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%strike%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%k.o%')

UPDATE       source_fighterdata
SET                MethodClean = 'No Contest'
WHERE        (MethodClean IS NULL AND Method LIKE N'nc')

UPDATE       source_fighterdata
SET                MethodClean = 'No Contest'
WHERE        (MethodClean IS NULL AND Method LIKE N'%n/c%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%slice%')

UPDATE       source_fighterdata
SET                MethodClean = 'Decision'
WHERE        (MethodClean IS NULL AND Method LIKE N'%points%')

UPDATE       source_fighterdata
SET                MethodClean = 'No Contest'
WHERE        (MethodClean IS NULL AND Method LIKE N'%forfeit%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%lever%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%elbow%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%knee%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%slam%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%he_l%hook%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%hold%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%triangle%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%liver%')

UPDATE       source_fighterdata
SET                MethodClean = 'No Contest'
WHERE        (MethodClean IS NULL AND Method LIKE N'%poke%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%stomp%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%sub%')

UPDATE       source_fighterdata
SET                MethodClean = 'Decision'
WHERE        (MethodClean IS NULL AND Method LIKE N'%split%')

UPDATE       source_fighterdata
SET                MethodClean = 'Decision'
WHERE        (MethodClean IS NULL AND Method LIKE N'%unanimous%')

UPDATE       source_fighterdata
SET                MethodClean = 'Decision'
WHERE        (MethodClean IS NULL AND Method LIKE N'%majority%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%stop%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%refu%')

UPDATE       source_fighterdata
SET                MethodClean = 'No Contest'
WHERE        (MethodClean IS NULL AND Method LIKE N'%nd %')

UPDATE       source_fighterdata
SET                MethodClean = 'No Contest'
WHERE        (MethodClean IS NULL AND Method LIKE N'%retire%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%knock%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%injury%')

UPDATE       source_fighterdata
SET                MethodClean = 'DQ'
WHERE        (MethodClean IS NULL AND Method LIKE N'%low%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%mata%')

UPDATE       source_fighterdata
SET                MethodClean = 'DQ'
WHERE        (MethodClean IS NULL AND Method LIKE N'%card%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'su')

UPDATE       source_fighterdata
SET                MethodClean = 'Decision'
WHERE        (MethodClean IS NULL AND Method LIKE N'de')

UPDATE       source_fighterdata
SET                MethodClean = 'No Contest'
WHERE        (MethodClean IS NULL AND Method LIKE N'%foul%')

UPDATE       source_fighterdata
SET                MethodClean = 'Submission'
WHERE        (MethodClean IS NULL AND Method LIKE N'%tap%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%doctor%')

UPDATE       source_fighterdata
SET                MethodClean = 'DQ'
WHERE        (MethodClean IS NULL AND Method LIKE N'%unsport%')

UPDATE       source_fighterdata
SET                MethodClean = 'KO'
WHERE        (MethodClean IS NULL AND Method LIKE N'%towel%')

UPDATE       source_fighterdata
SET                MethodClean = 'N/A'
WHERE        (MethodClean IS NULL)

--end update methodclean--

--start update time--


--end update time--