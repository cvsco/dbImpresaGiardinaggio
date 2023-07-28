DELIMITER $$
CREATE TRIGGER InserisciVaso
AFTER UPDATE ON Schede FOR EACH ROW
BEGIN
   
   IF NEW.Collocata = 'Vaso' THEN
     INSERT INTO Vaso(Forma, DimX, DimY, CodScheda)
       VALUES(NULL, NULL, NULL, NEW.CodScheda);
   END IF;

END $$
DELIMITER ;