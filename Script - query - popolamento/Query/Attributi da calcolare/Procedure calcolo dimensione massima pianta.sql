-- drop procedure CalcoloDimensioneMassimaPianta;
DELIMITER $$
CREATE PROCEDURE CalcoloDimensioneMassimaPianta(IN _pianta VARCHAR(45), IN _peso DOUBLE, IN _pesoSpecifico DOUBLE)
BEGIN
   
   DECLARE _dimensionePianta DOUBLE(4, 3) DEFAULT 0;
   
   SET _dimensionePianta = _peso/_pesoSpecifico;
   
   UPDATE Pianta
      SET DimensioneMassima = _dimensionePianta
      WHERE Nome = _pianta;
END $$
DELIMITER ;