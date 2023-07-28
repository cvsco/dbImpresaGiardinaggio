/*calcolo dell'indice di accrescimento aereo e radicale*/

-- drop procedure IndiceAccrescimento;

DELIMITER $$
CREATE PROCEDURE IndiceAccrescimento(IN _nome VARCHAR(45))
BEGIN

    DECLARE indiceAccrescimento_ DOUBLE(3,1) DEFAULT 0;
    DECLARE _dimMassima DOUBLE DEFAULT 0; -- dimensione massima della pianta
    
-- variabili per le esigenze di irrigazione
    DECLARE _quantitaRiposo DOUBLE DEFAULT 0; -- Qr
    DECLARE _periodicitaRiposo DOUBLE DEFAULT 0; -- Pr
    DECLARE _quantitaVeg DOUBLE DEFAULT 0; -- Qv
    DECLARE _periodicitaVeg DOUBLE DEFAULT 0; -- Pv

-- variabili per le esigenze di illuminazione
    DECLARE _oreRiposo INTEGER DEFAULT 0; -- Or
    DECLARE _oreVeg INTEGER DEFAULT 0; -- Ov

-- variabili per i periodi
    DECLARE _numeroMesiVeg INTEGER DEFAULT 0; -- V
    DECLARE _numeroMesiRip INTEGER DEFAULT 0; -- R
  
    SELECT IR.QuantitaRiposo, IR.QuantitaVegetativo, IR.PeriodicitaVegetativo, IR.PeriodicitaRiposo, IL.OreLuceVegetativo, IL.OreLuceRiposo INTO _quantitaRiposo, _quantitaVeg, _periodicitaVeg, _periodicitaRiposo, _oreVeg, _oreRiposo
    FROM Pianta P NATURAL JOIN Irrigazione IR
       NATURAL JOIN Illuminazione IL 
    WHERE P.Nome = _nome;
    
    SELECT IF(MeseInizio > MeseFine, 12 - (MeseInizio - MeseFine) + 1, MeseFine - MeseInizio) INTO _numeroMesiVeg
    FROM PeriodiPianta
    WHERE Nome = _nome AND Tipologia = 'Vegetativo';
    
    SELECT IF(MeseInizio > MeseFine, 12 - (MeseInizio - MeseFine) + 1, MeseFine - MeseInizio) INTO _numeroMesiRip
    FROM PeriodiPianta
    WHERE Nome = _nome AND Tipologia = 'Riposo';
    
    SELECT DimensioneMassima INTO _dimMassima 
    FROM Pianta 
    WHERE Nome = _nome;
    
    SELECT CalcoloIndiceAccrescimento(_quantitaRiposo, _quantitaVeg, _periodicitaRiposo, _periodicitaVeg, _oreRiposo, _oreVeg, _numeroMesiVeg, _numeroMesiRip, _dimMassima) INTO indiceAccrescimento_;
    
    UPDATE Pianta
      SET IndAccAereo = 0.7 * indiceAccrescimento_
      WHERE Nome = _nome;
	
    UPDATE Pianta
      SET IndAccRadicale = 0.3 * indiceAccrescimento_
      WHERE Nome = _nome; 
END $$
DELIMITER ;
    
    
       