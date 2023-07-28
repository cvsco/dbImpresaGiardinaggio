DELIMITER $$
CREATE EVENT AggiornaRilevazioniContenitori
ON SCHEDULE EVERY 1 DAY 
DO
BEGIN
    
    DECLARE finito INTEGER DEFAULT 0;
    DECLARE _contenitore VARCHAR(45) DEFAULT '';
    
    DECLARE ContenitoriAnalizzati CURSOR FOR
      SELECT CP.CodContenitore
      FROM CatalogoPiante CP;
      
	DECLARE CONTINUE HANDLER 
      FOR NOT FOUND SET finito = 1;
	
    OPEN ContenitoriAnalizzati;
    
    scan:LOOP 
      FETCH ContenitoriAnalizzati INTO _contenitore;
      
      IF finito = 1 THEN
        LEAVE scan;
	  END IF;
      
	  INSERT INTO RilevazioniSensori
        VALUES(_contenitore, CURRENT_DATE(), NULL, NULL, CURRENT_TIME());
	END LOOP scan;

    CLOSE ContenitoriAnalizzati;
   
END $$
DELIMITER ;
   