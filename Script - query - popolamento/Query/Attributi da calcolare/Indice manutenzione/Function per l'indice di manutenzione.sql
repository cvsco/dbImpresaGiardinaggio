-- drop function CalcoloIndiceManutenzione;

DELIMITER $$
CREATE FUNCTION  CalcoloIndiceManutenzione(_quantitaRiposo DOUBLE, _quantitaVeg DOUBLE, _periodicitaVeg INTEGER,
                                 _periodicitaRiposo INTEGER, _oreVeg INTEGER, _oreRiposo INTEGER, _numeroMesiVeg INTEGER, _numeroMesiRip INTEGER, _media DOUBLE, _interventi INTEGER, _sommaIndiceAccrescimento DOUBLE)
RETURNS DOUBLE NOT DETERMINISTIC
BEGIN

   DECLARE _esigenzeIrrigazione DOUBLE DEFAULT 0;
   DECLARE _esigenzeIlluminazione DOUBLE DEFAULT 0;
   DECLARE _esigenze DOUBLE DEFAULT 0;
  
-- caclcolo dell'equazione (2.0)
   SET _esigenzeIrrigazione = (_quantitaRiposo * (_periodicitaRiposo + 1))/_numeroMesiRip + (_quantitaVeg * _periodicitaVeg)/_numeroMesiVeg;
  
-- calcolo dell'equazione (2.1)                                 
   SET _esigenzeIlluminazione = _oreRiposo/_numeroMesiRip + _oreVeg/_numeroMesiVeg;
   
-- calcolo equazione (2.3)
   SET _esigenze = _esigenzeIlluminazione + _esigenzeIrrigazione + _media;
   
   RETURN _esigenze + (_interventi * _sommaIndiceAccrescimento);
   
END $$
DELIMITER ;