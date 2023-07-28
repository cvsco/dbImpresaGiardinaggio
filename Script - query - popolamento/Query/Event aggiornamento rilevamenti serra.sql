DELIMITER $$
CREATE EVENT AggiornaRilevamentiSerra
ON SCHEDULE EVERY 1 HOUR 
DO
BEGIN
  
     DECLARE finito INTEGER DEFAULT 0;
     DECLARE _codSerra VARCHAR(45) DEFAULT '';
     
     DECLARE SerreAnalizzate CURSOR FOR
        SELECT CodSerra
        FROM Serre ;
	
     DECLARE CONTINUE HANDLER 
       FOR NOT FOUND SET finito = 1;
       
	 OPEN SerraAnalizzata;
     
     scan:LOOP
       FETCH SerraAnalizzata INTO _codSerra;
       
       IF finito = 1 THEN
         LEAVE scan;
	   END IF;
       
       INSERT INTO RilevamentiSerra
         VALUES(_codSerra, current_timestamp(), NULL, NULL, NULL);
         
	 END LOOP scan;
     
     CLOSE SerraAnalizzata;
     
END $$
DELIMITER $$