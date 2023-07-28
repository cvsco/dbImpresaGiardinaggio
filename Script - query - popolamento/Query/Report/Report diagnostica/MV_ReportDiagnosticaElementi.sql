/*Materialized view per il report di diagnostica*/

CREATE TABLE MV_ReportDiagnosticaElementi(
   CodPianta VARCHAR(45) NOT NULL,
   ElementoRilevato VARCHAR(45) NOT NULL,
   Quantita DOUBLE NOT NULL,
   DataRilevazione DATE NOT NULL,
   OraRilevazione TIME NOT NULL,
   PRIMARY KEY(CodPianta)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
