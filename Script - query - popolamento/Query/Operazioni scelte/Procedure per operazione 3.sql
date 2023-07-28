/*visualizzare la “Credibilità” di un determinato utente*/

/*Senza ridondanza*/
-- drop procedure Operazione3;
DELIMITER $$
CREATE PROCEDURE Operazione3(IN _nickname VARCHAR(45))
BEGIN
    
    DECLARE valutazione_ DOUBLE(2,1) DEFAULT 0;
    
    DECLARE finito INTEGER DEFAULT 0;
    DECLARE _post VARCHAR(45) DEFAULT 0;
    DECLARE _mediaVoti DOUBLE DEFAULT 0;
    DECLARE _numeroPost DOUBLE(2,1) DEFAULT 0;
  
    -- troviamo i post dell'account inserito in input
	DECLARE PostPubblicati CURSOR FOR
      SELECT P.CodPost, AVG(V.Voto)
      FROM Post P INNER JOIN Valutazioni V USING(CodPost)
      WHERE P.Nickname = _nickname AND P.Risposta = 'si'
	  GROUP BY P.CodPost;
      
	DECLARE CONTINUE HANDLER
      FOR NOT FOUND SET finito = 1;
      
	OPEN PostPubblicati;
    
    scan:LOOP
      FETCH PostPubblicati INTO _post, _mediaVoti;
      
      IF finito = 1 THEN 
        LEAVE scan;
	  END IF;
      
      SET valutazione_ = valutazione_ + _mediaVoti;
      SET _numeroPost = _numeroPost + 1;
      
      END LOOP scan;
      
      CLOSE PostPubblicati;
      
      SET valutazione_ = valutazione_/_numeroPost;      
      
      SELECT valutazione_;
      
END $$
DELIMITER ;

/*Con ridondanza*/
/*
DELIMITER $$
CREATE PROCEDURE Operazione2(IN _nickname VARCHAR(45))
BEGIN
    
   SELECT A.Giudizio
   FROM Account A
   WHERE A.Nickname = _nickaname;
      
END $$
DELIMITER ;
*/