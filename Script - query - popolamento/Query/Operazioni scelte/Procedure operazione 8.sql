/*visualizzare le informazioni sugli elementi chimici da disciogliere nel terreno di una determinata pianta*/
-- drop procedure Operazione8;
DELIMITER $$
CREATE PROCEDURE Operazione8(IN _pianta VARCHAR(45))
BEGIN
   
   SELECT ED.NomeElemento, ED.Concentrazione
   FROM Pianta P NATURAL JOIN Terreno T
     NATURAL JOIN ElementiDisciolti ED 
   WHERE P.Nome = _pianta;

END $$
DELIMITER ;