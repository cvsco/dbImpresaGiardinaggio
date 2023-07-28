DELIMITER $$
CREATE EVENT AggiornaReportDiagnosticaElementi
ON SCHEDULE EVERY 1 DAY
STARTS '2017-03-25 23:55:00'
DO
BEGIN
     
     SET @esito = 0;
     CALL Refresh_MV_ReportDiagnosticaElementi(@esito);
     
     IF @esito = 1 THEN
       SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT = 'Errore nel refresh';
	END IF;
END $$
DELIMITER ;