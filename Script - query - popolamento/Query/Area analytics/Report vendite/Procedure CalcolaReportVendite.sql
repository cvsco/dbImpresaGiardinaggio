-- drop procedure CalcolaReportVendite;
DELIMITER $$
CREATE PROCEDURE CalcolaReportVendite(OUT controllo INTEGER)
BEGIN
  
  DECLARE controllo INTEGER DEFAULT 0;
  
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
      SET controllo = 1;
      SELECT 'Si è verificato un errore : materialized view non aggiornata';
	END ;
    
  TRUNCATE TABLE ReportVendite;
  
  INSERT INTO ReportVendite
    SELECT P.Nome, COUNT(O.CodOrdine) 
    FROM CatalogoPiante CP INNER JOIN Pianta P ON CP.Nome = P.Nome 
       LEFT OUTER JOIN Ordine O ON CP.CodPianta = O.CodPianta
    WHERE YEAR(O.TimeStamp) = YEAR(CURRENT_DATE())
       AND MONTH(O.TimeStamp) BETWEEN MONTH(CURRENT_DATE()) - 5 AND MONTH(CURRENT_DATE())
	GROUP BY P.Nome;
END $$
DELIMITER ;