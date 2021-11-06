use synthea;
show tables;
Select *
from clinical_data;
INSERT INTO clinical_data (patientUID, lastname, systolic,
diastolic) VALUES (141514, 'GinaT', 120, 80);
Select Description, totalcost, Medicationcost(totalcost)
From medications;

#### trigger
delimiter $$ 
CREATE TRIGGER quaLItySystolic BEFORE INSERT ON clinical_data  FOR EACH ROW 
BEGIN 
 IF NEW.systolic >= 300 THEN 
 SIGNAL SQLSTATE '45000' 
 SET MESSAGE_TEXT = 'ERROR: Systolic BP MUST BE BELOW 300 mg!';  
 END IF; 
END; $$ 


Delimiter $$
CREATE FUNCTION MedicationCost6(cost DECIMAL(10,2))
returns varchar(20)
DETERMINISTIC
BEGIN
DECLARE drugCost VARCHAR(20);
IF cost > 500 THEN
SET drugCost = ‘high drug cost’;
ELSEIF (cost >= 200 AND
credit <= 500) THEN

SET drugCost = 'normal drug cost';
ELSEIF cost < 200 THEN
SET drugCost = 'low drug cost';
END IF;

RETURN (drugCost);
END$$
DELIMITER ;

