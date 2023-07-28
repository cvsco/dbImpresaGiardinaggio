-- drop function CalcolaCredibilita;

DELIMITER $$
CREATE FUNCTION CalcolaCredibilita (_nickname VARCHAR(45))
RETURNS DOUBLE NOT DETERMINISTIC
BEGIN
  
  DECLARE credibilita_ DOUBLE DEFAULT 0; -- variabile da restituire
  DECLARE finito INTEGER DEFAULT 0;
  DECLARE _codPost VARCHAR(45);
  DECLARE _media DOUBLE DEFAULT 0;
  DECLARE _numeroPost INTEGER DEFAULT 0;
  DECLARE _sommaMedia DOUBLE(2,1) DEFAULT 0;
  
  DECLARE PostRisposta CURSOR FOR
    SELECT P.CodPost, AVG(V.Voto)
    FROM Post P INNER JOIN Valutazioni V USING(CodPost) -- 1)
    WHERE P.Nickname = _nickname 
    GROUP BY P.CodPost;
  
  DECLARE CONTINUE HANDLER 
    FOR NOT FOUND SET finito = 1;

  OPEN PostRisposta;
  
  scan:LOOP
    FETCH PostRisposta INTO _codPost, _media;
    
    IF finito = 1 THEN
      LEAVE scan;
	END IF;
    
    SET _numeroPost = _numeroPost + 1;
    SET _sommaMedia = _sommaMedia + _media;
  END LOOP scan;
  
  CLOSE PostRisposta;
  
  SET credibilita_ = _sommaMedia/_numeroPost;
  
  RETURN credibilita_;
END $$
DELIMITER ;