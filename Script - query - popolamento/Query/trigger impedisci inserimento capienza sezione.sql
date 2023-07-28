/*serve per impedire di inserire una capieza di una sezione che supera la capacità della serra o una capienza che sommota 
a quelle delle altre sezioni della stessa serra supera la capacità della serra*/
-- drop trigger ImpedisciInserimentoCapienzaSezione;

DELIMITER $$
CREATE TRIGGER ImpedisciInserimentoCapienzaSezione
BEFORE INSERT ON Sezioni FOR EACH ROW
BEGIN

  DECLARE _capacitaSerra INTEGER DEFAULT 0;
  DECLARE _sommaCapienze INTEGER DEFAULT 0;
  
  -- recuperiamo la capienza della serra dove vogliamo effettuare l'inserimento della nuova sezione
  SELECT S.Capacita INTO _capacitaSerra
  FROM Serre S
  WHERE S.CodSerra = NEW.CodSerra;
  
  -- somma delle capienze delle sezioni inserite fino ad ora + la nuova capienza
  SELECT SUM(SE.Capienza) + NEW.Capienza INTO _sommaCapienze
  FROM Sezioni SE
  WHERE SE.CodSerra = NEW.CodSerra;
  
  IF (NEW.Capienza > _capacitaSerra OR _sommaCapienze > _capacitaSerra) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Capienza inserita troppo grande per la serra selezionata';
  END IF;
  
END $$
DELIMITER ;