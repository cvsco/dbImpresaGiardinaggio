-- DROP PROCEDURE IF EXISTS Refresh_MV_ReportOrdini;

DELIMITER $$
CREATE PROCEDURE Refresh_MV_ReportOrdini(OUT esito INTEGER)
BEGIN
    -- esito vale 1 se si verifica un errore
    DECLARE esito INTEGER DEFAULT 0;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN 
         SET esito = 1;
         SELECT 'Si è verificato un errore : materialized view non aggiornata';
	  END ;
      
	-- flushing della materialized view 
    TRUNCATE TABLE MV_ReportOrdini;
    
    INSERT INTO MV_ReportOrdini
      SELECT CP.Nome, COUNT(*)
      FROM Ordine O INNER JOIN CatalogoPiante CP USING(CodPianta)
      WHERE O.Stato = 'Pendente'
		 OR O.TimeStamp BETWEEN CURRENT_DATE() - INTERVAL 7 DAY AND CURRENT_DATE()
      GROUP BY CP.Nome;
   
END $$
DELIMITER ;