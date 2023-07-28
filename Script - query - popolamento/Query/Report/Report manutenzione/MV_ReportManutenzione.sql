/*Materialized view sulla manutenzione*/

CREATE TABLE MV_ReportManutenzione (
  CodScheda VARCHAR(45) NOT NULL,
  TipoIntervento VARCHAR(45) NOT NULL,
  PRIMARY KEY(CodScheda)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;


