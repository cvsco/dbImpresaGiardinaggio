/*trigger che controlla le richieste di manutenzione :

Cioè non ci possono essere nella tabella "richieste manutenzione" una scheda con tipi di richieste di manutenzioni diverse.
Ad una scheda non possono corrispondere contemporaneamente tipi di richiesta "su richiesta*, "programmata" o "automatica"
ma solo una di queste*/
DELIMITER $$
CREATE TRIGGER ImpedisciInserimentoRichiestaManutenzione
BEFORE INSERT ON richiestemanutenzione FOR EACH ROW
BEGIN
   
   IF EXISTS (SELECT *
              FROM RichiesteManutenzione RM
              WHERE RM.CodScheda = NEW.CodScheda
                 AND RM.TipoRichiesta <> NEW.CodScheda) THEN 
	 SIGNAL SQLSTATE '45000'
       SET MESSAGE_TEXT = 'Tipo di richiesta inserito non appartenente alla scheda corrente';
	END IF;
END $$
DELIMITER ;