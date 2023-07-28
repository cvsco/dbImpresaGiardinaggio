-- drop event AggiornaReportVendite;

DELIMITER $$
CREATE EVENT AggiornaReportVendite
ON SCHEDULE EVERY 6 MONTH
STARTS '2010-07-01 00:00:00' -- 1)
DO
BEGIN
   
   SET @controllo = 0;
   CALL CalcolaReportVendite(@controllo);
   
   
    IF @controllo = 1 THEN
	 SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Errore nel refresh materialized view non aggiornata';
    END IF;

END $$
DELIMITER ;
     
/*
1) si imposta questo 'START' in modo tale da far partire l'event dall'inizio di luglio e a dicembre in modo tale da avere informazioni 
ogni 6 mesi 
*/
     
   