DELIMITER $$
CREATE PROCEDURE Refresh_MV_ReportManutenzione(OUT controllo INTEGER)
BEGIN
   
   DECLARE controllo INTEGER DEFAULT 0;
   
   DECLARE EXIT HANDLER FOR SQLEXCEPTION
     BEGIN
       SET controllo = 1;
	   SELECT 'Si è verificato un errore : materialized view non aggiornata';
	 END ;
     
   TRUNCATE TABLE MV_ReportManutenzione;
   
   INSERT INTO MV_ReportManutenzione
     SELECT RM.CodScheda, RM.TipoIntervento
     FROM RichiesteManutenzione RM
     WHERE (YEAR(RM.Scadenza) = YEAR(CURRENT_DATE()) AND MONTH(RM.Scadenza) = MONTH(CURRENT_DATE()))
       OR (YEAR(RM.Prenotazione) = YEAR(CURRENT_DATE()) AND MONTH(RM.Prenotazione) = MONTH(CURRENT_DATE()))
       OR Periodicita = MONTH(CURRENT_DATE());
   
END $$
DELIMITER ;