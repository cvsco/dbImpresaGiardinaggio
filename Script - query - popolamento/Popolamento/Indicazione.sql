/*NomeAgentePatogeno varchar(45) PK 
NomeProdotto varchar(45) PK 
TipoSomministrazione varchar(45) 
DosaggioConsigliato double*/

INSERT INTO Indicazione
VALUES('Collicotrico', 'Fenicrit', 'irrigazione', 5),
('Ascomiceti', 'Amylo-X', 'nebulizzare', 3),
('Bruchi', 'Afidina quick', 'nebuluzzare', 1.3),
('Cimici', 'Nephorin', 'nebulizzare', 1.5),
('Cocciniglia', 'Ciperbloc', 'nebulizzare', 1.2),
('Mosca bianca', 'Suscon', 'irrigazione', 5);

INSERT INTO indicazione
VALUES('Oidium', 'Cifoblok', 'entrambe', 3),
('Ragnetti rossi', 'Nephorin', 'nebulizzare', 1),
('Saprofiti', 'Cyprus 25', 'irrigazione', 1.5);

INSERT INTO indicazione
VALUES('Afidi', 'Ciperbloc', 'nebulizzazione', 5),
('Peronosporacee', 'Tri-base fun', 'entrambe', 8);
