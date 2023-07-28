/*La loggica sarà che per ogni nuova pianta che vogliamo inserire verifichiamo se gli elementi complessivi di cui ha bisogno la 
nuova pianta sono gli stessi di cui hanno bisogno le altre piante presenti nel settore corrente. Se questa cosa è verificata
allora eseguiamo la funzione "CalcolaDistanzaMinima" tra la nuova pianta ed ogni altra pianta presente nel settore*/
-- drop procedure CalcolaDistanzaMinima;
DELIMITER $$
CREATE PROCEDURE CalcolaDistanzaMinima(IN _pianta1 VARCHAR(45), IN _pianta2 VARCHAR(45))
BEGIN
  
  DECLARE _media1 DOUBLE DEFAULT 0;
  DECLARE _media2 DOUBLE DEFAULT 0;
  DECLARE _dimMax1 DOUBLE DEFAULT 0;
  DECLARE _dimMax2 DOUBLE DEFAULT 0;
  DECLARE _infestante1 VARCHAR(45) DEFAULT '';
  DECLARE _infestante2 VARCHAR(45) DEFAULT '';
  DECLARE distanzaMinima_ DOUBLE DEFAULT 0;

# calcolo dell'equazione (2.2) per la prima e la seconda pianta  
  SET _media1 = (SELECT AVG(ED.Concentrazione)
				 FROM Pianta P NATURAL JOIN ElementiDisciolti ED
                 WHERE P.Nome = _pianta1);
  
  SET _media2 = (SELECT AVG(ED.Concentrazione)
				 FROM Pianta P NATURAL JOIN ElementiDisciolti ED
                 WHERE P.Nome = _pianta2);
  
# calcolo della dimensione massima della prima e della seconda pianta
  SELECT P.DimensioneMassima, P.Infestante INTO _dimMax1, _infestante1 
  FROM Pianta P
  WHERE P.Nome = _pianta1;
  
  SELECT P.DimensioneMassima, P.Infestante INTO _dimMax2, _infestante2 
  FROM Pianta P
  WHERE P.Nome = _pianta2;

# calcolo del valore della distanza minima fra le due piante
  IF _infestante1 = 'si' OR _infestante2 = 'si' THEN
    SELECT ((IF(_dimMax1 >= _dimMax2, _dimMax1 - _dimMax2, _dimMax2 - _dimMax1) + 100)/(_media1 + _media2)) * 2 AS DistanzaMinima;
  ELSE
	SELECT (IF(_dimMax1 >= _dimMax2, _dimMax1 - _dimMax2, _dimMax2 - _dimMax1) + 100)/(_media1 + _media2) AS DistanzaMinima;
  END IF;
   
END $$
DELIMITER ;