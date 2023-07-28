-- drop trigger AggiornaNumeroPianteSezione;

DELIMITER $$
CREATE TRIGGER AggiornaNumeroPianteSezione
AFTER INSERT ON CatalogoPiante FOR EACH ROW
BEGIN
    
    DECLARE _sezione VARCHAR(45) DEFAULT '';

-- troviamo la sezione dove è stata inserita la pianta
    SELECT R.CodSezione INTO _sezione
    FROM Contenitore C INNER JOIN Ripiani R USING(CodRipiano) -- 1)
    WHERE C.CodContenitore = NEW.CodContenitore; -- 2)
    
    UPDATE Sezioni
    SET Pezzi = Pezzi + 1
    WHERE CodSezione = _sezione;
END $$
DELIMITER ;

/*
1) cerchiamo per ogni contenitore il ripiano dove si trova

2) identificando il contenitore nel quale è stata inserita la nuova pianta riusciamo a risalire attraverso il join anche alla
  sezione dove si trova
*/
