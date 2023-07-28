-- drop procedure Refresh_MV_ReportDiagnosticaSintomi;
DELIMITER $$
CREATE PROCEDURE Refresh_MV_ReportDiagnosticaSintomi(OUT esito INTEGER)
BEGIN
  
    DECLARE esito INTEGER DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN 
         SET esito = 1;
         SELECT 'Si è verificato un errore : materialized view non aggiornata';
	  END ;
      
	TRUNCATE TABLE MV_ReportDiagnosticaSintomi;
    
    INSERT INTO MV_ReportDiagnosticaSintomi
      SELECT SR.CodPianta, CodSintomo, SR.Data, SR.Ora
      FROM SintomiRilevati SR
      WHERE SR.Data = CURRENT_DATE();
END $$
DELIMITER ;