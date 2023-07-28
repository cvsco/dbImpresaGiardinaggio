-- drop trigger InserisciScheda;
DELIMITER $$
CREATE TRIGGER InserisciScheda 
AFTER INSERT ON Ordine FOR EACH ROW
BEGIN
   
   IF NEW.Stato = 'evaso' THEN
     INSERT INTO schede (Collocata, CodOrdine, Nickname)
       VALUES(NULL, NEW.CodOrdine, NEW.Nickname);
   END IF;
   
END $$
DELIMITER ;


