/* Pianta (Nome, Dioica, DimensioneMassima, Cultivar, SempreVerde,
 IndiceManutenzione, Infestante, IndAccRadicale, IndAccAereo, CodTerreno, CodIrrigazione, CodIlluminazione, NomeGenere)*/

INSERT INTO pianta
VALUES('Ficus benjamina', 'no', 0, 'no', 'si', 0, 'no', 0, 0, 'ter1', 'ir1', 'il1', 'Ficus');

INSERT INTO pianta
VALUES('Ficus comune', 'no', 0, 'no', 'si', 0, 'no', 0, 0, 'ter4', 'ir1', 'il2', 'Ficus');

INSERT INTO Pianta
VALUES('Ficus pumila', 'no', 0, 'no', 'si', 0, 'si', 0, 0, 'ter5', 'ir3', 'il4', 'Ficus');

INSERT INTO Pianta
VALUES('Humulus lupulus', 'si', 0, 'no', 'no', 0, 'no', 0, 0, 'ter8', 'ir9', 'il6', 'Cannabaceae');

INSERT INTO Pianta
VALUES('Taxus baccata', 'si', 0, 'no', 'si', 0, 'no', 0, 0, 'ter7', 'ir5', 'il8', 'Conifere');

INSERT INTO pianta
VALUES('Betula pendula', 'no', 0, 'no', 'no', 0, 'no', 0, 0, 'ter8', 'ir2', 'il9', 'Betulla');

INSERT INTO Pianta
VALUES('Catalpa bungei', 'no', 0, 'no', 'si', 0, 'no', 0, 0, 'ter3', 'ir4', 'il5', 'Catalpa');

INSERT INTO Pianta
VALUES('Acacia baileyana', 'no', 0, 'no', 'no', 0, 'no', 0, 0, 'ter6', 'ir4', 'il3', 'Acacia');

INSERT INTO pianta
VALUES('Sophora davidii', 'no', 0, 'no', 'si', 0, 'no', 0, 0, 'ter4', 'ir6', 'il7', 'Sophora');

INSERT INTO pianta
VALUES('Aesculus hippocastanum', 'no', 0, 'no', 'si', 0, 'no', 0, 0, 'ter4', 'ir3', 'il5', 'Sophora');

INSERT INTO Pianta
VALUES('Corylus colurna', 'no', 0, 'no', 'no', 0, 'si', 0, 0, 'ter6', 'ir8', 'il6', 'Corylus');

INSERT INTO Pianta
VALUES('Corylus maxima', 'no', 0, 'no', 'si', 0, 'si', 0, 0, 'ter7', 'ir3', 'il8', 'Corylus');

INSERT INTO pianta
VALUES('Tilia cordata', 'no', 0, 'no', 'si', 0, 'si', 0, 0, 'ter1', 'ir8', 'il1', 'Tilia');

INSERT INTO Pianta
VALUES('Cercis canadensis', 'no', 0, 'no', 'no', 0, 'no', 0, 0, 'ter4', 'ir7', 'il2', 'Cercis');

-- calcolo delle dimensioni delle piante
CALL CalcoloDimensioneMassimaPianta('Acacia baileyana', 150, 550);
CALL CalcoloDimensioneMassimaPianta('Aesculus hippocastanum', 400, 900);
CALL CalcoloDimensioneMassimaPianta('Betula pendula', 200, 750);
CALL CalcoloDimensioneMassimaPianta('Catalpa bungei', 125, 400);
CALL CalcoloDimensioneMassimaPianta('Cercis canadensis', 100, 300);
CALL CalcoloDimensioneMassimaPianta('Corylus colurna', 1000, 1050);
CALL CalcoloDimensioneMassimaPianta('Corylus maxima', 500, 600);
CALL CalcoloDimensioneMassimaPianta('Ficus benjamina', 8, 100);
CALL CalcoloDimensioneMassimaPianta('Ficus pumila', 15, 130);
CALL CalcoloDimensioneMassimaPianta('Humulus lupulus', 10, 110);
CALL CalcoloDimensioneMassimaPianta('Sophora davidii', 15, 125);
CALL CalcoloDimensioneMassimaPianta('Taxus baccata', 25, 150);
CALL CalcoloDimensioneMassimaPianta('Tilia cordata', 1100, 1200);

-- calcolo indici di accrescimento e manutenzione (calcolare sempre prima quello di accrescimento che ci serve per la manutenzione)
CALL IndiceAccrescimento('Tilia cordata');
CALL IndiceManutenzione('Tilia cordata');

CALL IndiceAccrescimento('Ficus benjamina');
CALL IndiceManutenzione('Ficus benjamina');

CALL IndiceAccrescimento('Corylus maxima');
CALL IndiceManutenzione('Corylus maxima');

CALL IndiceAccrescimento('Cercis canadensis');
CALL IndiceManutenzione('Cercis canadensis');

CALL IndiceAccrescimento('Corylus colurna');
CALL IndiceManutenzione('Corylus colurna');

CALL IndiceAccrescimento('Aesculus hippocastanum');
CALL IndiceManutenzione('Aesculus hippocastanum');

CALL IndiceAccrescimento('Acacia baileyana');
CALL IndiceManutenzione('Acacia baileyana');

CALL IndiceAccrescimento('Betula pendula');
CALL IndiceManutenzione('Betula pendula');

CALL IndiceAccrescimento('Catalpa bungei');
CALL IndiceManutenzione('Catalpa bungei');

CALL IndiceAccrescimento('Ficus pumila');
CALL IndiceManutenzione('Ficus pumila');

CALL IndiceAccrescimento('Humulus lupulus');
CALL IndiceManutenzione('Humulus lupulus');

CALL IndiceAccrescimento('Sophora davidii');
CALL IndiceManutenzione('Sophora davidii');

CALL IndiceAccrescimento('Taxus baccata');
CALL IndiceManutenzione('Taxus baccata');