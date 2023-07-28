DELIMITER $$
CREATE FUNCTION CalcoloCostoManutenzione(_pianta VARCHAR(45))
RETURNS DOUBLE NOT DETERMINISTIC
BEGIN
   
   DECLARE costoManutenzione_ DOUBLE default NULL;
   
   SELECT AVG(RM.Costo) INTO costoManutenzione_
   FROM Ordine O INNER JOIN Schede S USING(CodOrdine)
      INNER JOIN RichiesteManutenzione RM USING(CodScheda)
   WHERE O.CodPianta = _pianta;
   
   RETURN costoManutenzione_;
END $$
DELIMITER ;