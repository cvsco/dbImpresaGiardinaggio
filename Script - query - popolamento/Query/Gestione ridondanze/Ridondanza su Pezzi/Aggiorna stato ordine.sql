DELIMITER $$
CREATE TRIGGER AggiornaCatalogo 
AFTER UPDATE ON Ordine FOR EACH ROW
BEGIN
  
   DECLARE _sezione VARCHAR(45) DEFAULT '';
   
   IF NEW.Stato = 'evaso' THEN
   
     -- ricaviamo il codice della sezione dove si trovava la pianta
     SELECT CodSezione INTO _sezione
     FROM CatalogoPiante CP INNER JOIN Contenitore C USING(CodContenitore)
        INNER JOIN Ripiani R USING(CodRipiano)
     WHERE CP.CodPianta = NEW.CodPianta;

     -- modifichiamo il valore di "venduta" e liberiamo il contenitore dove si trovava la pianta
     UPDATE CatalogoPiante
       SET Venduta = 'si', CodContenitore = NULL 
       WHERE CodPianta = NEW.CodPianta;

     -- aggiorniamo la ridondanza che ci indica il numero di piante presente nella sezione corrente
     UPDATE Sezioni 
       SET Pezzi = Pezzi - 1
       WHERE CodSezione = _sezione;
   END IF;
   
END $$
DELIMITER ;