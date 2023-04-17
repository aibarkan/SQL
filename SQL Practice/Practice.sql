#median severity of accidents caused by motorcycles
SET SESSION group_concat_max_len = 3000000;
SELECT cT.carlabel as MotorcycleType, SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(`accidentSeverity` ORDER BY 
`accidentSeverity`), ',', CEILING((COUNT(`accidentSeverity`)/2))), ',', -1) 
medianOfaccidentSeverity
FROM carType cT
INNER JOIN vehicles v ON v.vehType = cT.carcode
INNER JOIN accidents a ON a.accID = v.accIndex
WHERE cT.carlabel like '%motorcycle%'
GROUP BY cT.carlabel;

##Accident severity and total accidents 
SELECT cT.carlabel, COUNT(v.accIndex) AS totalAccidents, 
AVG(a.accidentSeverity) as accidentSeverity
#JOINS first table should be unique 
FROM carType cT
INNER JOIN vehicles v ON v.vehType = cT.carcode
INNER JOIN accidents a ON a.accID = v.accIndex
GROUP BY cT.carlabel
#Filter by top, bottom
ORDER BY COUNT(v.accIndex) DESC;

##Severity and total for motorcycles
SELECT cT.carlabel, COUNT(v.accIndex) AS totalAccidents, 
AVG(a.accidentSeverity) as accidentSeverity
#JOINS first table should be unique 
FROM carType cT
INNER JOIN vehicles v ON v.vehType = cT.carcode
INNER JOIN accidents a ON a.accID = v.accIndex
WHERE cT.carlabel like '%motorcycle%'
GROUP BY cT.carlabel
#Filter by top, bottom
ORDER BY COUNT(v.accIndex) DESC;

