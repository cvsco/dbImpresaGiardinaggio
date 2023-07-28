DELIMITER $$
CREATE PROCEDURE ContaImpiegatiRichiesti(IN controllo INTEGER)
BEGIN
  
  DECLARE controllo INTEGER DEFAULT 0;
  
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN 
         SET controllo = 1;
         SELECT 'Si è verificato un errore : materialized view non aggiornata';
	  END ;
      
  TRUNCATE TABLE MV_ImpiegatiRichiestiCitta;
    
  INSERT INTO MV_ImpiegatiRichiestiCitta
    SELECT A.Citta, COUNT(*) * 2 -- almeno due dipendenti per ogni intervento di manutenzione
    FROM RichiesteManutenzione RM NATURAL JOIN Schede S
        INNER JOIN Account A USING(Nickname)
	WHERE (YEAR(RM.Scadenza) = YEAR(CURRENT_DATE()) AND MONTH(RM.Scadenza) = MONTH(CURRENT_DATE()))
       OR (YEAR(RM.Prenotazione) = YEAR(CURRENT_DATE()) AND MONTH(RM.Prenotazione) = MONTH(CURRENT_DATE()))
       OR Periodicita = MONTH(CURRENT_DATE())
	GROUP BY A.Citta;

END $$
DELIMITER ;