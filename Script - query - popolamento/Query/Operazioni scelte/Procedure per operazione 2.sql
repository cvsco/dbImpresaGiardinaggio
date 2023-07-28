-- drop procedure Operazione2;

DELIMITER $$
CREATE PROCEDURE Operazione2(IN _pianta VARCHAR(45))
BEGIN

  CREATE TEMPORARY TABLE IF NOT EXISTS PossibiliPatologie (
    CodPatologia VARCHAR(45) NOT NULL,
    Periodo VARCHAR(45) NOT NULL,
    Probabilita DOUBLE NOT NULL,
    NomeProdotto VARCHAR(45) NOT NULL,
    GiorniNeutralizzazione INTEGER NOT NULL,
    PRIMARY KEY(CodPatologia, NomeProdotto)
  ) ENGINE = InnoDB DEFAULT CHARSET = latin1;
  
  INSERT INTO PossibiliPatologie
    SELECT PP.NomePatologia, PP.Periodo, PP.Probabilita, P.Nome, P.GiorniNeutralizzazione
    FROM PatologiePianta PP INNER JOIN CausaPatologia CP USING(NomePatologia)
       INNER JOIN Indicazione I USING(NomeAgentePatogeno)
       INNER JOIN Prodotto P ON I.NomeProdotto = P.Nome
	WHERE PP.NomePianta = _pianta;
    
  SELECT *
  FROM PossibiliPatologie;
END $$
DELIMITER ;    
  