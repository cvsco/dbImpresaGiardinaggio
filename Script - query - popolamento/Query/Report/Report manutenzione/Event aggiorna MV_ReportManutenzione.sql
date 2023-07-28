DELIMITER $$
CREATE EVENT AggiornaMV_ReportManutenzione 
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    
    SET @controllo = 0;
    CALL Refresh_MV_ReportManutenzione(@controllo);
    
    IF @controllo = 1 THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Personale non sufficiente per gestire tutte le richieste di manutenzione di questo mese';
    END IF;

END $$
DELIMITER ;