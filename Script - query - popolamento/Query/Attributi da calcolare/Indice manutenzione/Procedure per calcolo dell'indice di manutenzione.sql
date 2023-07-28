/*funzione per il calcolo dell'indice di manutenzione di una pianta*/
-- drop procedure IndiceManutenzione;

DELIMITER $$
CREATE PROCEDURE IndiceManutenzione(IN _nome VARCHAR(45))
BEGIN
  
  DECLARE indManutenzione_ DOUBLE(3,1) DEFAULT 0;
  
  -- varibili per le esigenze di irrigazione
  DECLARE _quantitaRiposo DOUBLE DEFAULT 0; -- Qr
  DECLARE _quantitaVeg DOUBLE DEFAULT 0; -- Qv
  DECLARE _periodicitaRiposo INTEGER DEFAULT 0; -- Pr
  DECLARE _periodicitaVeg INTEGER DEFAULT 0; -- Pv
  
  -- variabili per le esigenze di illuminazione
  DECLARE _oreRiposo DOUBLE DEFAULT 0; -- ore di luce nel periodo di riposo (Or)
  DECLARE _oreVeg DOUBLE DEFAULT 0; -- ore di luce nel periodo vegetativo (Ov)
  
  -- variabili per i periodi
  DECLARE _numeroMesiVeg INTEGER DEFAULT 0; -- numero mesi del periodo vegetativo (V)
  DECLARE _numeroMesiRip INTEGER DEFAULT 0; -- numero mesi del periodo di riposo (R)
  
  DECLARE _media DOUBLE DEFAULT 0; -- valore finale della formula (2.3)
  DECLARE _interventi DOUBLE DEFAULT 0; -- variabilie I della formula (2.4)
  DECLARE _sommaIndiceAccrescimento DOUBLE DEFAULT 0; -- somma fra gli indici di accrescimento fra parentesi nella formula (2.4)

# ricerca delle variabili per il calcolo delle esigenze di irrigazione ed illuminazione (Qr, Qv, Pv, Pr, Ov, Or)
  SELECT IR.QuantitaRiposo, IR.QuantitaVegetativo, IR.PeriodicitaVegetativo, IR.PeriodicitaRiposo, IL.OreLuceVegetativo, IL.OreLuceRiposo INTO _quantitaRiposo, _quantitaVeg, _periodicitaVeg, _periodicitaRiposo, _oreVeg, _oreRiposo
  FROM Pianta P NATURAL JOIN Irrigazione IR
     NATURAL JOIN Illuminazione IL 
  WHERE P.Nome = _nome;
  
# si trovano i valori delle variabili R e V
  SELECT IF(MeseInizio > MeseFine, 12 - (MeseInizio - MeseFine) + 1, MeseFine - MeseInizio) INTO _numeroMesiVeg -- 1)
  FROM PeriodiPianta
  WHERE Nome = _nome AND Tipologia = 'Vegetativo';
    
  SELECT IF(MeseInizio > MeseFine, 12 - (MeseInizio - MeseFine) + 1, MeseFine - MeseInizio) INTO _numeroMesiRip -- 1)
  FROM PeriodiPianta
  WHERE Nome = _nome AND Tipologia = 'Riposo';
  
# calcolo dell'equazione (2.2)
  SET _media = (SELECT AVG(ED.Concentrazione)
				FROM Pianta P NATURAL JOIN ElementiDisciolti ED
                WHERE P.Nome = _nome);

# contiamo il numero di interventi di manutenzione che devono essere effettuati sulla pianta corrente
  SET _interventi = (SELECT COUNT(*)
                     FROM Pianta P INNER JOIN Genere G ON P.NomeGenere = G.Nome
                        INNER JOIN InterventiManutenzione IM ON G.Nome = IM.NomeGenere 
                        INNER JOIN InterventoConcimazione IC ON P.Nome = IC.NomePianta
                     WHERE P.Nome = _nome);
					
  SET _sommaIndiceAccrescimento = (SELECT P.IndAccRadicale + P.IndAccAereo
                                   FROM Pianta P
                                   WHERE P.Nome = _nome);
                                   
  SELECT CalcoloIndiceManutenzione(_quantitaRiposo, _quantitaVeg, _periodicitaVeg, _periodicitaRiposo, _oreVeg, _oreRiposo, _numeroMesiVeg, _numeroMesiRip, _media, _interventi, _sommaIndiceAccrescimento) INTO indManutenzione_;
  
  UPDATE Pianta
    SET IndiceManutenzione = indManutenzione_
    WHERE Nome = _nome;
    
END $$
DELIMITER ;
 
/*
1) l'IF è stato inserito per far fronte al problema in cui il mese di inizio del periodo è più grande del mese di fine ad esempio 
nel periodo tra dicembre e febbraio o novembre e marzo ecc. 
È per questo che viene adottata la seguente formula : 12 - (MeseInizio - MeseFine) + 1
in cui si riesce a sapere con precisione il numero di mesi che intercorrono fra i due valori considerando anche gli estremi.
*/
