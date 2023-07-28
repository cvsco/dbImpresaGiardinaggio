DELIMITER $$
CREATE TRIGGER CancellaVoto
AFTER DELETE ON Valutazioni FOR EACH ROW
BEGIN
  
  DECLARE _nickname VARCHAR(45) DEFAULT '';
  DECLARE credibilita_ DOUBLE DEFAULT 0;
  
# cerchiamo il proprietario del post di cui abbimo cancellato un voto
  SELECT P.Nickname INTO _nickname
  FROM Post P
  WHERE P.CodPost = OLD.CodPost;
  
  SET credibilita_ = CalcolaCredibilita(_nickname);
  
  UPDATE Account
  SET Credibilita = credibilita_
  WHERE Nickname = _nickname;

END $$
DELIMITER ;