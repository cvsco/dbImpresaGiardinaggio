DELIMITER $$
CREATE PROCEDURE Refresh_MV_ReportDiagnosticaElementi(OUT esito INTEGER)
BEGIN
  
    DECLARE esito INTEGER DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN 
         SET esito = 1;
         SELECT 'Si è verificato un errore : materialized view non aggiornata';
	  END ;
      
	TRUNCATE TABLE MV_ReportDiagnosticaElementi;
    
    INSERT INTO MV_ReportDiagnosticaElementi
      SELECT CP.CodPianta, ER.Nome, ER.Concentrazione, ER.Data, ER.Ora
      FROM ElementiRilevati ER INNER JOIN CatalogoPiante CP USING(CodContenitore)
      WHERE ER.Data = CURRENT_DATE();
END $$
DELIMITER ;