/*Materialized view per il report di ordini.*/
-- drop table mv_reportordini;

CREATE TABLE MV_ReportOrdini (
  NomePianta VARCHAR(45) NOT  NULL,
  QuantitaRichieste VARCHAR(45) NOT NULL,
  Stato VARCHAR(45) NOT NULL, -- per gli ordini pendenti
  PRIMARY KEY(NomePianta)  
) ENGINE = InnoDB DEFAULT CHARSET = latin1;