/*il livello di irrigazione deve essere diverso da un contenitore all'altro*/
-- drop trigger LivIrrigazioneContenitori;

DELIMITER $$
CREATE TRIGGER LivIrrigazioneContenitori
BEFORE INSERT ON Contenitore FOR EACH ROW
BEGIN

   IF EXISTS(SELECT *
             FROM Contenitore C
             WHERE C.LivIrrigazione = NEW.LivIrrigazione) THEN
	SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'contenitore con quel livello di irrigazione già presente nel database';
   END IF;
END $$
DELIMITER ;