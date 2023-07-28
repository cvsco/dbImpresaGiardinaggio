/*impedirà di inserire valutazioni su post che non sono di risposta*/
DELIMITER $$
CREATE TRIGGER ImpedisciInserimentoGiudizio
BEFORE INSERT ON Giudizio FOR EACH ROW
BEGIN

  DECLARE controllo INTEGER DEFAULT 0;
  
  SET controllo = (SELECT COUNT(*)
                   FROM Post P
                   WHERE P.CodPost = NEW.CodPost AND P.Risposta = 'no');
  
  IF controllo = 1 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Il post non è di risposta non è possibile assegnargli un voto';
  END IF;
  
END $$
DELIMITER ;