-- drop trigger InserimentoPeriodiPiante;

DELIMITER $$
CREATE TRIGGER InserimentoPeriodiPiante
BEFORE INSERT ON PeriodiPianta FOR EACH ROW
BEGIN

   DECLARE _meseInizioVeg INTEGER DEFAULT 0;
   DECLARE _meseFineVeg INTEGER DEFAULT 0;

-- si trovano i mesi di inizio e fine del periodo vegetativo della pianta
   SELECT MeseInizio, MeseFine INTO _meseInizioVeg, _meseInizioVeg
   FROM PeriodiPianta
   WHERE Nome = NEW.Nome
      AND Tipologia = 'Vegetativo';

   IF EXISTS (SELECT *
              FROM PeriodiPianta
              WHERE Nome = NEW.Nome
                 AND (Tipologia = 'Fruttificativo' OR Tipologia = 'Fioritura')
				 AND (MeseInizio < _meseInizioVeg OR MeseFine > _meseInizioVeg)) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Mesi di fioritura e/o fruttificazioni devono essere compresi nel periodo vegetativo';
   END IF;
END $$
DELIMITER ;