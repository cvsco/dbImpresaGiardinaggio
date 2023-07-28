/*Materialized view per il report di diagnostica*/

CREATE TABLE MV_ReportDiagnosticaSintomi(
   CodPianta VARCHAR(45) NOT NULL,
   SintomoRilevato VARCHAR(45) NOT NULL,
   DataRilevazione DATE NOT NULL,
   OraRilevazione TIME NOT NULL,
   PRIMARY KEY(CodPianta)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

  