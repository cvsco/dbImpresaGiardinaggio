DELIMITER $$
CREATE TABLE MV_ReportPatologie (
  CodPianta VARCHAR(45) NOT NULL,
  NumPatologieContratte INTEGER NOT NULL,
  PRIMARY KEY(NomePianta)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;