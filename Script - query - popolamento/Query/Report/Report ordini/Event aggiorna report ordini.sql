-- drop event aggiornareportordini;
DELIMITER $$
CREATE EVENT AggiornaReportOrdini
ON SCHEDULE EVERY 7 DAY
DO
  BEGIN 
  
     SET @esito = 0;
     CALL Refresh_MV_ReportOrdini(@esito);
     
     IF @esito = 1 THEN
       SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT = 'Errore nel refresh';
	END IF;
    
END $$
DELIMITER ;