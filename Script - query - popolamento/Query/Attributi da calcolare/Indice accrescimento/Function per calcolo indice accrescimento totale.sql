/*calcolo dell'indice di accrescimento totale */
/*calcolo dell'indice di accrescimento totale, per trovare quello solo di riposo o aereo  bisognerà calcolarlo alla chiamata della funzione
moltiplicando il primo per 30% e il secondo per 70%*/
-- drop function CalcoloIndiceAccrescimento;

DELIMITER $$
CREATE FUNCTION CalcoloIndiceAccrescimento(_quantitaRiposo DOUBLE, _quantitaVegetativo DOUBLE, _periodicitaRiposo INTEGER,
                                     _periodicitaVegetativo INTEGER, _oreRiposo INTEGER, _oreVegetativo INTEGER, _numeroMesiVeg INTEGER, 
                                     _numeroMesiRip INTEGER, _dimMassima DOUBLE)
RETURNS DOUBLE DETERMINISTIC
BEGIN
  
  DECLARE _esigenzeIrrigazione DOUBLE DEFAULT 0;
  DECLARE _esigenzeIlluminazione DOUBLE DEFAULT 0;
  
-- caclcolo dell'equazione (2.0)
  SET _esigenzeIrrigazione = (_quantitaRiposo * (_periodicitaRiposo + 1))/_numeroMesiRip + (_quantitaVegetativo * _periodicitaVegetativo)/_numeroMesiVeg;
  
-- calcolo dell'equazione (2.1)                                 
  SET _esigenzeIlluminazione = _oreRiposo/_numeroMesiRip + _oreVegetativo/_numeroMesiVeg;
                            
-- calcolo dell'equazione (3.0)
  RETURN (_dimMassima + 2)/(_esigenzeIrrigazione + _esigenzeIlluminazione);

END $$
DELIMITER ;