-- drop trigger AggiornaCredibilita;

DELIMITER $$
CREATE TRIGGER AggiornaCredibilita
AFTER INSERT ON Valutazioni FOR EACH ROW

BEGIN

  DECLARE _nickname VARCHAR(45) DEFAULT '';
  DECLARE credibilita_ DOUBLE DEFAULT 0;
  
  -- cerchiamo il proprietario del post che ha ricevuto il nuovo voto
  SELECT P.Nickname INTO _nickname
  FROM Post P
  WHERE P.CodPost = NEW.CodPost;
  
  SET credibilita_ = CalcolaCredibilita(_nickname);
  
  UPDATE Account
  SET Credibilita = credibilita_
  WHERE Nickname = _nickname;
END $$
DELIMITER ;  
/*
1) dato che saranno solo i post di risposta a ricevere i voti possiamo anche evitare 
   di specificare che i post da analizzare devono essere di risposta*/