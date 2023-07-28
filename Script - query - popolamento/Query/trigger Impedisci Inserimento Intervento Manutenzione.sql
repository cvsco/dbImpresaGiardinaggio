/*trigger per evitare che di inserire diversi interventi di manutenzioni eseguiti sulla stessa pianta ma con tipo di richiesta
differente*/

DELIMITER $$
CREATE TRIGGER ImpedisciInserimentoInterventoManutenzione
BEFORE INSERT ON RichiesteManutenzione FOR EACH ROW
BEGIN
   
   IF EXISTS (SELECT *
              FROM RichiesteManutenzione RM
              WHERE RM.CodScheda = NEW.CodScheda
                 AND RM.TipoRichiesta <> NEW.TipoRichiesta) THEN
	  SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tipo di richiesta errata';
    END IF;

END $$
DELIMITER ;
   
   