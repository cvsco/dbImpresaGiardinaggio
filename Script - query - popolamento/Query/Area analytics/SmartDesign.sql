/*Procedure per la gestione della funzionalità dello smart design :

_indiceManutenzione : valore massimo del range per l'indice di manutenzione richiesto;
_settore : primary key del settore per cui il cliente ha richiesto la funzionalità di smart design;
_costoMax : indica la fascia di prezzo massimo che possono avere le piante che andranno nel risultato;
_periodiFiorituraMultipli : varibile che indica se il cliente desidera piante con più periodi di fioritura (valori possibili 'si' o 'no');
_terreno : indicherà il tipo di terreno di cui è composto il settore corrente (valore presente solo nel caso in cui il settore è in piana terra);
*/
-- drop procedure SmartDesign;
DELIMITER $$
CREATE PROCEDURE SmartDesign(IN _indiceManutenzione DOUBLE, _settore VARCHAR(45), _terreno VARCHAR(45), _costoMax DOUBLE, _periodiFiorituraMultipli VARCHAR(45))
BEGIN
    
    DECLARE _areaSezione DOUBLE DEFAULT 0;
    DECLARE _oreSole INTEGER DEFAULT 0;
    
    SELECT Area, OreSole INTO _areaSezione, _oreSole
    FROM Settore
    WHERE CodSettore = _settore;
	
    DROP TABLE IF EXISTS PossibiliPiante;
    
    CREATE TEMPORARY TABLE PossibiliPiante (
       Nome VARCHAR(45) NOT NULL,
       CodiceCatalogo VARCHAR(45) NOT NULL,
       Prezzo VARCHAR(45) NOT NULL,
       IndiceManutenzione DOUBLE,
	   PRIMARY KEY(CodiceCatalogo)
	) ENGINE = InnoDB DEFAULT CHARSET = latin1;
       
   
    INSERT INTO PossibiliPiante
	  SELECT P.Nome, CP.CodPianta, CP.Prezzo, P.IndiceManutenzione
      FROM Pianta P INNER JOIN CatalogoPiante CP USING(Nome)
        INNER JOIN Illuminazione I USING(CodIlluminazione)
      WHERE P.IndiceManutenzione <= _indiceManutenzione
         AND CP.Prezzo <= _costoMax
         AND P.CodTerreno = _terreno
         AND P.DimensioneMassima <= _areaSezione
         AND I.OreLuceVegetativo <= _oreSole;
    
   
     IF _periodiFiorituraMultipli = 'si' THEN
       BEGIN 
          SELECT DISTINCT POS.Nome,  POS.CodiceCatalogo, POS.Prezzo, POS.IndiceManutenzione, CalcoloCostoManutenzione(POS.CodiceCatalogo) AS CostoManutenzione
		  FROM PossibiliPiante POS INNER JOIN PeriodiPianta PP USING(Nome)
          WHERE PP.Tipologia = 'Fioritura'
             AND EXISTS(SELECT *
						FROM PeriodiPianta PP2
                        WHERE PP2.Tipologia = 'Fioritura'
                           AND PP2.Nome = POS.Nome
                           AND (PP2.MeseInizio <> PP.MeseInizio OR PP2.MeseFine <> PP.MeseFine));
	   END ;
	 ELSE
        SELECT DISTINCT *, CalcoloCostoManutenzione(POS.CodiceCatalogo) AS CostoManutenzione
        FROM PossibiliPiante POS;
	 END IF;

END $$
DELIMITER ;
                       