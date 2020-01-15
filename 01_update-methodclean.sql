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

