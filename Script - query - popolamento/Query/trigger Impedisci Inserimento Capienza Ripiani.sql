-- drop trigger ImpedisciInserimentoCapienzaRipiani;

DELIMITER $$
CREATE TRIGGER ImpedisciInserimentoCapienzaRipiani
BEFORE INSERT ON Ripiani FOR EACH ROW
BEGIN

  DECLARE _capienzaSezione INTEGER DEFAULT 0;
  DECLARE _sommaCapacitaRipiani INTEGER DEFAULT 0;
  
  -- recuperiamo la capacità della sezione dove vogliamo effettuare l'inserimento del nuovo ripiano
  SELECT S.Capienza INTO _capienzaSezione
  FROM Sezioni S
  WHERE S.CodSezione = NEW.CodSezione;
  
  -- somma delle capienze dei ripiani inseriti fino ad ora + la nuova capienza del nuovo ripiano
  SELECT SUM(R.Capacita) + NEW.Capacita INTO _sommaCapacitaRipiani
  FROM Ripiani R
  WHERE R.CodSezione = NEW.CodSezione;
  
  IF (NEW.Capacita > _capienzaSezione OR _sommaCapacitaRipiani > _capienzaSezione) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Capienza inserita troppo grande per la serra selezionata';
  END IF;
END $$
DELIMITER ;
  