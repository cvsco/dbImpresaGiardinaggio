-- drop trigger InserimentoVaso;
DELIMITER $$
CREATE TRIGGER InserimentoVaso
AFTER INSERT ON PiantaSelezionata FOR EACH ROW
BEGIN

   DECLARE _controllo INTEGER DEFAULT 0;
  
   SET _controllo = (SELECT COUNT(*)
					 FROM Settore S
                     WHERE S.CodSettore = NEW.CodSettore
                        AND S.Tipo = 'pavimentato');
   
   IF _controllo = 1 THEN
     INSERT INTO VasoProgettazione (Forma, AsseX, AsseY, CodPianta) -- variabili che deve impostare l'utente
     VALUES(NULL, NULL, NULL, NEW.CodPianta); 
   END IF;

END $$
DELIMITER ;