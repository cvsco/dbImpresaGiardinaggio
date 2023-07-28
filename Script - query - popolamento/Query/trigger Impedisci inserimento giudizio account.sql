/*impedisce l'inserimento di un giudizio se il post è stato giudicato da chi lo ha scritto*/
DELIMITER $$
CREATE TRIGGER ImpedisciInserimentoGiudizioAccount
BEFORE INSERT ON Giudizio FOR EACH ROW
BEGIN

  DECLARE controllo INTEGER DEFAULT 0;
  
  SET controllo = (SELECT COUNT(*)
				   FROM Post P
                   WHERE P.CodPost = NEW.CodPost
                     AND P.Nickname = NEW.Nickname);
  
  IF controllo = 1 THEN
    SIGNAL SQLSTATE '45000'
      SET  MESSAGE_TEXT = 'Inserimento non effettuato perchè account proprietario del post';
  END IF;
  
END $$
DELIMITER ;
    