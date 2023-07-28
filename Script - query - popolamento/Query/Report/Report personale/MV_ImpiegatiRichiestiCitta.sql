/*Materialized view reclutamento del personale*/

CREATE TABLE MV_ImpiegatiRichiestiCitta (
   Citta VARCHAR(45) NOT NULL,
   NumDipendenti INTEGER NOT NULL,
   PRIMARY KEY(Citta)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

