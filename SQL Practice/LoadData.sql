USE sqlaccidents; 


drop table if exists Accidents;
CREATE TABLE Accidents (
  accID varchar(14) DEFAULT NULL,
  locationEast varchar(255) DEFAULT NULL,
  locationNorth varchar(255) DEFAULT NULL,
  longitude varchar(255) DEFAULT NULL,
  latitude varchar(255) DEFAULT NULL,
  policeForce integer(100) DEFAULT NULL,
  accidentSeverity integer(100) DEFAULT NULL,
  numberofVehicles integer(100) DEFAULT NULL,
  numberofCasualties integer(100) DEFAULT NULL,
  accDate varchar(255) DEFAULT NULL,
  dayofWeek integer(8) DEFAULT NULL,
  accTime time DEFAULT NULL,
  district varchar(14) DEFAULT NULL,
  highway varchar(12) DEFAULT NULL,
  fstroadClass integer(12) DEFAULT NULL,
  fstroadNumber integer(12) DEFAULT NULL,
  roadType integer(12) DEFAULT NULL,
  speedLimit integer(12) DEFAULT NULL,
  junctionDetail integer(12) DEFAULT NULL,
  junctionControl integer(12) DEFAULT NULL,
  secroadClass integer(12) DEFAULT NULL,
  secroadNumber integer(12) DEFAULT NULL,
  pedcrossinghumanControl integer(12) DEFAULT NULL,
  pedcrossingphysicalFacilities integer(12) DEFAULT NULL,
  lightConditions integer(12) DEFAULT NULL,
  weatherConditions integer(12) DEFAULT NULL,
  roadsurfaceConditions integer(12) DEFAULT NULL,
  specialConditions integer(12) DEFAULT NULL,
  carriagewayHazards integer(12) DEFAULT NULL,
  urbanruralType integer(12) DEFAULT NULL,
  officerAttendance integer(2) DEFAULT NULL,
  lsoaaccLocation varchar(12) DEFAULT NULL);
  
  SELECT * FROM accidents limit 5;
  SELECT count(*) from accidents;
  
drop table if exists carType;
CREATE TABLE carType (
  carcode varchar(14) DEFAULT NULL,
  carlabel varchar(255) DEFAULT NULL);
  
drop table if exists Vehicles;
CREATE TABLE Vehicles (
  accIndex varchar(200) DEFAULT NULL,
  vehReference integer(20) DEFAULT NULL,
  vehType integer(20) DEFAULT NULL,
  towing integer(20) DEFAULT NULL,
  vehMane integer(20) DEFAULT NULL,
  vehLoc integer(20) DEFAULT NULL,
  juncLoc integer(20) DEFAULT NULL,
  skidding integer(20) DEFAULT NULL,
  hitObjinCarriage integer(100) DEFAULT NULL,
  vehLeaving integer(20) DEFAULT NULL,
  hitOjboffCarriage integer(20) DEFAULT NULL,
  fstPOI integer(20) DEFAULT NULL,
  driverLefthand integer(20) DEFAULT NULL,
  journeyPurpose integer(20) DEFAULT NULL,
  gender integer(20) DEFAULT NULL,
  age integer(20) DEFAULT NULL,
  ageBand integer(20) DEFAULT NULL,
  engineCapacity integer(20) DEFAULT NULL,
  propulsionCode integer(20) DEFAULT NULL,
  vehAge integer(20) DEFAULT NULL,
  driverIMD integer(20) DEFAULT NULL,
  driverHomeArea integer(20) DEFAULT NULL,
  carIMD integer(20) DEFAULT NULL);
  
  SELECT COUNT(*) from vehicles; 
  
  SELECT accidentSeverity, vehType
  from accidents, vehicles
  where accidents.accID = vehicles.accIndex; 
 

##median of accident severity by motorcycles
SET SESSION group_concat_max_len = 3000000; 
SELECT COUNT(vehicles.vehType), vehtype AS vehicleType,
SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(`accidentSeverity` ORDER BY `accidentSeverity`), ',', CEILING((COUNT(`accidentSeverity`)/2))), ',', -1) medianOfaccidentSeverity
FROM accidents, vehicles
WHERE accidents.accID = vehicles.accIndex
GROUP BY vehType;

##accident severity and total accidents per vechile type 
SELECT vehType, SUM(accidents.accID) AS totalAccidents, 
COUNT(accidents.accidentSeverity) as accidentSeverity
FROM accidents, vehicles
WHERE accidents.accID = vehicles.accIndex
GROUP BY vehType;

Select * from accidents limit 5;



  