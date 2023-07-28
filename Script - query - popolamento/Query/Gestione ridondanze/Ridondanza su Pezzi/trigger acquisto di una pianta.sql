/*bisogna modificare alcuni valori quando una pinata viene venduta, 
cioè quando viene effettuato un nuovo ordine da parte di un utente,
l'attributo "Venduta" di una pianta viene modificato in 'si' :

1) bisogna liberare il contenitore dove si trovava impostando a NULL l'attributo CodContenitore della tabella CatalogoPiante

2) bisogna aggiornare il numero di piante contenute nella sezione dove si trovava la pianta*/

-- drop trigger EffettuaOrdine;

DELIMITER $$
CREATE TRIGGER EffettuaOrdine
AFTER INSERT ON Ordine FOR EACH ROW
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
     