/*visualizzare il numero di piante contenute in una determinata sezione*/

/*Senza ridondanza*/
DELIMITER $$
CREATE PROCEDURE Operazione6(IN _sezione VARCHAR(45))
BEGIN
   
   SELECT COUNT(*)
   FROM Sezioni S INNER JOIN Ripiani R USING(CodSezione)
     INNER JOIN Contenitore C USING(CodRipiano)
	 INNER JOIN CatalogoPiante CP USING(CodContenitore)
   WHERE S.CodSezione = _sezione;
   
END $$
DELIMITER ;