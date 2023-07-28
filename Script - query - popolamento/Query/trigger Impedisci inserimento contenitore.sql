/*trigger che si attiva quando si vuole usare un contenitore già occupato*/
DELIMITER $$
CREATE TRIGGER ImpedisciInserimentoContenitore
BEFORE INSERT ON catalogopiante FOR EACH ROW
BEGIN
   
   IF EXISTS(SELECT *
             FROM CatalogoPiante CP
             WHERE CP.CodContenitore = NEW.CodContenitore) THEN
	 SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Contenitore già occupato';
   END IF;

END $$
DELIMITER ;