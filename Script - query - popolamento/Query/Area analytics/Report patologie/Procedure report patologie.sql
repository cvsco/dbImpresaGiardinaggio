DELIMITER $$
CREATE PROCEDURE Refresh_MV_ReportPatologie(OUT controllo INTEGER)
BEGIN
  
   DECLARE controllo INTEGER DEFAULT 0;
   
   DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN 
      SET controllo = 1;
      SELECT 'Si è verificato un errore : materialized view non aggiornata';
	END ;
    
   TRUNCATE TABLE MV_ReportPatologie;
   
   INSERT INTO MV_ReportPatologie
     SELECT D.CodPianta, COUNT(*)
     FROM (SELECT SR.CodPianta, SP.NomePatologia
           FROM SintomiRilevati SR INNER JOIN SintomiPatologia SP USING(CodSintomo)
		   GROUP BY SR.CodPianta, SP.NomePatologia
           HAVING COUNT(DISTINCT SP.CodSintomo) = (SELECT COUNT(*)
                                                   FROM SintomiPatologia SP1
                                                   WHERE SP1.NomePatologia = SP.NomePatologia)) AS D
	 GROUP BY D.CodPianta;

END $$
DELIMITER ;