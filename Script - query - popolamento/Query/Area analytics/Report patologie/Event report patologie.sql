DELIMITER $$
CREATE EVENT AggiornaMV_ReportPatologie 
ON SCHEDULE EVERY 6 MONTH
DO
BEGIN
   
   SET @controllo = 0;
   CALL Refresh_MV_ReportManutenzione(@controllo);
    
    IF @controllo = 1 THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore nel refresh materialized view non aggiornata';
    END IF;

END $$
DELIMITER ;