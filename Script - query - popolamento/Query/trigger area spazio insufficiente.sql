/*trigger che controlla che lo spazio della sezione inserita non superi l'area dello spazio verde, e anche
controlla che l'area totale degli spazi inseriti non superi quella dello spazio verde*/

-- drop trigger AreaSpazioInsufficiente;
DELIMITER $$
create trigger AreaSpazioInsufficiente
BEFORE INSERT ON Settore FOR EACH ROW
BEGIN

   DECLARE _areaSpazio DOUBLE DEFAULT 0;
   DECLARE _sommaAreaSezioni DOUBLE DEFAULT 0;
   
   SELECT SV.Area INTO _areaSpazio
   FROM SpazioVerde SV
   WHERE SV.CodSpazio = NEW.CodSpazio;
   
   SELECT SUM(S.Area) + NEW.Area INTO _sommaAreaSezioni
   FROM Settore S
   WHERE S.CodSpazio = NEW.CodSpazio;
   
   IF (_areaSpazio < _sommaAreaSezioni) THEN
	 SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Area del settore troppo grande';
   END IF;

END $$
DELIMITER ;