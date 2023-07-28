-- drop table MV_ReportVendite;
DELIMITER $$
CREATE TABLE MV_ReportVendite (
   NomePianta VARCHAR(45) NOT NULL,
   OrdiniSemestre INTEGER NOT NULL,
   PRIMARY KEY(NomePianta)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;
