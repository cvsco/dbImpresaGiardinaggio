-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Progetto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Progetto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Progetto` DEFAULT CHARACTER SET latin1 ;
USE `Progetto` ;

-- -----------------------------------------------------
-- Table `Progetto`.`Sede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Sede` (
  `CodSede` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Indirizzo` VARCHAR(45) NULL,
  `Citta` VARCHAR(45) NULL,
  `NumeroDipendenti` INT NULL,
  PRIMARY KEY (`CodSede`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Serre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Serre` (
  `CodSerra` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Capacita` INT NULL,
  `Altezza` DOUBLE NULL,
  `Indirizzo` VARCHAR(45) NULL,
  `Lunghezza` DOUBLE NULL,
  `Larghezza` DOUBLE NULL,
  `CodSede` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodSerra`),
  INDEX `fk_Serre_Sede_idx` (`CodSede` ASC),
  CONSTRAINT `fk_Serre_Sede`
    FOREIGN KEY (`CodSede`)
    REFERENCES `Progetto`.`Sede` (`CodSede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`RilevamentiSerra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`RilevamentiSerra` (
  `CodSerra` VARCHAR(45) NOT NULL,
  `TimeStamp` VARCHAR(45) NOT NULL,
  `Temperatura` DOUBLE NULL,
  `Irrigazione` DOUBLE NULL,
  `Illuminazione` DOUBLE NULL,
  PRIMARY KEY (`CodSerra`, `TimeStamp`),
  CONSTRAINT `fk_RilevamentiSerra_Serre1`
    FOREIGN KEY (`CodSerra`)
    REFERENCES `Progetto`.`Serre` (`CodSerra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Sezioni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Sezioni` (
  `CodSezione` VARCHAR(45) NOT NULL,
  `Capienza` INT NULL,
  `Nome` VARCHAR(45) NULL,
  `Pezzi` INT NULL DEFAULT 0,
  `LivIrrigazione` DOUBLE NULL,
  `LivIlluminazione` DOUBLE NULL,
  `LivTemperatura` DOUBLE NULL,
  `LivUmidita` DOUBLE NULL,
  `CodSerra` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodSezione`),
  INDEX `fk_Sezioni_RilevamentiSerra1_idx` (`CodSerra` ASC),
  CONSTRAINT `fk_Sezioni_RilevamentiSerra1`
    FOREIGN KEY (`CodSerra`)
    REFERENCES `Progetto`.`RilevamentiSerra` (`CodSerra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Ripiani`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Ripiani` (
  `CodRipiano` VARCHAR(45) NOT NULL,
  `Capacita` INT NULL,
  `CodSezione` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodRipiano`),
  INDEX `fk_Ripiani_Sezioni1_idx` (`CodSezione` ASC),
  CONSTRAINT `fk_Ripiani_Sezioni1`
    FOREIGN KEY (`CodSezione`)
    REFERENCES `Progetto`.`Sezioni` (`CodSezione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Contenitore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Contenitore` (
  `CodContenitore` VARCHAR(45) NOT NULL,
  `Volume` DOUBLE NULL,
  `LivIrrigazione` DOUBLE NULL,
  `LivIdratazione` DOUBLE NULL,
  `CodRipiano` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodContenitore`),
  INDEX `fk_Contenitore_Ripiani1_idx` (`CodRipiano` ASC),
  CONSTRAINT `fk_Contenitore_Ripiani1`
    FOREIGN KEY (`CodRipiano`)
    REFERENCES `Progetto`.`Ripiani` (`CodRipiano`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`RilevazioniSensori`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`RilevazioniSensori` (
  `CodContenitore` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL,
  `InfoUmidita` DOUBLE NULL,
  `InfoGas` DOUBLE NULL,
  PRIMARY KEY (`CodContenitore`, `TimeStamp`),
  CONSTRAINT `fk_RilevazioniSensori_Contenitore1`
    FOREIGN KEY (`CodContenitore`)
    REFERENCES `Progetto`.`Contenitore` (`CodContenitore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Elementi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Elementi` (
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`ElementiRilevati`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`ElementiRilevati` (
  `CodContenitore` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL,
  `Concentrazione` DOUBLE NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodContenitore`, `TimeStamp`, `Nome`),
  INDEX `fk_ElementiRilevati_Elementi1_idx` (`Nome` ASC),
  CONSTRAINT `fk_ElementiRilevati_RilevazioniSensori1`
    FOREIGN KEY (`CodContenitore` , `TimeStamp`)
    REFERENCES `Progetto`.`RilevazioniSensori` (`CodContenitore` , `TimeStamp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ElementiRilevati_Elementi1`
    FOREIGN KEY (`Nome`)
    REFERENCES `Progetto`.`Elementi` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Terreno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Terreno` (
  `CodTerreno` VARCHAR(45) NOT NULL,
  `PH` DOUBLE NULL,
  PRIMARY KEY (`CodTerreno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Irrigazione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Irrigazione` (
  `CodIrrigazione` VARCHAR(45) NOT NULL,
  `QuantitaRiposo` DOUBLE NULL,
  `QuantitaVegetativo` DOUBLE NULL,
  `PeriodicitaRiposo` INTEGER NULL,
  `PeriodicitaVegetativo` INTEGER NULL,
  PRIMARY KEY (`CodIrrigazione`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Illuminazione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Illuminazione` (
  `CodIlluminazione` VARCHAR(45) NOT NULL,
  `Esposizione` VARCHAR(45) NULL,
  `TipoLuce` VARCHAR(45) NULL,
  `OreLuceVegetativo` INT NULL,
  `OreLuceRiposo` INT NULL,
  PRIMARY KEY (`CodIlluminazione`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Genere`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Genere` (
  `Nome` VARCHAR(45) NOT NULL,
  `TempMinima` DOUBLE NULL,
  `TempMassima` DOUBLE NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Pianta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Pianta` (
  `Nome` VARCHAR(45) NOT NULL,
  `Dioica` VARCHAR(45) NULL,
  `DimensioneMassima` DOUBLE NULL,
  `Cultivar` VARCHAR(45) NULL,
  `SempreVerde` VARCHAR(45) NULL,
  `IndiceManutenzione` DOUBLE NULL,
  `Infestante` VARCHAR(45) NULL,
  `IndiceAccRadicale` DOUBLE NULL,
  `IndiceAccAereo` DOUBLE NULL,
  `CodTerreno` VARCHAR(45) NOT NULL,
  `CodIrrigazione` VARCHAR(45) NOT NULL,
  `CodIlluminazione` VARCHAR(45) NOT NULL,
  `NomeGenere` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nome`),
  INDEX `fk_Pianta_Terreno1_idx` (`CodTerreno` ASC),
  INDEX `fk_Pianta_Irrigazione1_idx` (`CodIrrigazione` ASC),
  INDEX `fk_Pianta_Illuminazione1_idx` (`CodIlluminazione` ASC),
  INDEX `fk_Pianta_Genere1_idx` (`NomeGenere` ASC),
  CONSTRAINT `fk_Pianta_Terreno1`
    FOREIGN KEY (`CodTerreno`)
    REFERENCES `Progetto`.`Terreno` (`CodTerreno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pianta_Irrigazione1`
    FOREIGN KEY (`CodIrrigazione`)
    REFERENCES `Progetto`.`Irrigazione` (`CodIrrigazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pianta_Illuminazione1`
    FOREIGN KEY (`CodIlluminazione`)
    REFERENCES `Progetto`.`Illuminazione` (`CodIlluminazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pianta_Genere1`
    FOREIGN KEY (`NomeGenere`)
    REFERENCES `Progetto`.`Genere` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`CatalogoPiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`CatalogoPiante` (
  `CodPianta` VARCHAR(45) NOT NULL,
  `Prezzo` DOUBLE NULL,
  `Venduta` VARCHAR(45) NOT NULL DEFAULT 'no',
  `DimensioneAerea` DOUBLE NULL,
  `DimensioneRadicale` DOUBLE NULL,
  `Quarantena` VARCHAR(45) NULL DEFAULT 'no',
  `CodContenitore` VARCHAR(45) NULL,
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodPianta`),
  INDEX `fk_CatalogoPiante_Contenitore1_idx` (`CodContenitore` ASC),
  INDEX `fk_CatalogoPiante_Pianta1_idx` (`Nome` ASC),
  CONSTRAINT `fk_CatalogoPiante_Contenitore1`
    FOREIGN KEY (`CodContenitore`)
    REFERENCES `Progetto`.`Contenitore` (`CodContenitore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CatalogoPiante_Pianta1`
    FOREIGN KEY (`Nome`)
    REFERENCES `Progetto`.`Pianta` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Sintomi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Sintomi` (
  `CodSintomo` VARCHAR(45) NOT NULL,
  `Descrizione` VARCHAR(200) NULL,
  PRIMARY KEY (`CodSintomo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`SintomiRilevati`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`SintomiRilevati` (
  `Data` DATE NOT NULL,
  `CodPianta` VARCHAR(45) NOT NULL,
  `CodSintomo` VARCHAR(45) NOT NULL,
  `Ora` TIME NOT NULL,
  PRIMARY KEY (`TimeStamp`, `CodPianta`, `CodSintomo`, `Ora`),
  INDEX `fk_SintomiRilevati_CatalogoPiante1_idx` (`CodPianta` ASC),
  INDEX `fk_SintomiRilevati_Sintomi1_idx` (`CodSintomo` ASC),
  CONSTRAINT `fk_SintomiRilevati_CatalogoPiante1`
    FOREIGN KEY (`CodPianta`)
    REFERENCES `Progetto`.`CatalogoPiante` (`CodPianta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SintomiRilevati_Sintomi1`
    FOREIGN KEY (`CodSintomo`)
    REFERENCES `Progetto`.`Sintomi` (`CodSintomo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Foto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Foto` (
  `NomeFile` VARCHAR(45) NOT NULL,
  `Dimensione` DOUBLE NULL,
  `Data` DATE NULL,
  `CodSintomo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NomeFile`),
  INDEX `fk_table1_Sintomi1_idx` (`CodSintomo` ASC),
  CONSTRAINT `fk_table1_Sintomi1`
    FOREIGN KEY (`CodSintomo`)
    REFERENCES `Progetto`.`Sintomi` (`CodSintomo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Prodotto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Prodotto` (
  `Nome` VARCHAR(45) NOT NULL,
  `GiorniNeutralizzazione` INT NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Trattamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Trattamento` (
  `CodTrattamento` VARCHAR(45) NOT NULL,
  `Data` DATE NULL,
  `Posologia` DOUBLE NULL,
  `CodPianta` VARCHAR(45) NOT NULL,
  `NomeProdotto` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodTrattamento`),
  INDEX `fk_Trattamento_CatalogoPiante1_idx` (`CodPianta` ASC),
  INDEX `fk_Trattamento_Prodotto1_idx` (`NomeProdotto` ASC),
  CONSTRAINT `fk_Trattamento_CatalogoPiante1`
    FOREIGN KEY (`CodPianta`)
    REFERENCES `Progetto`.`CatalogoPiante` (`CodPianta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Trattamento_Prodotto1`
    FOREIGN KEY (`NomeProdotto`)
    REFERENCES `Progetto`.`Prodotto` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Account` (
  `Nickname` VARCHAR(45) NOT NULL,
  `Cognome` VARCHAR(45) NULL,
  `Nome` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Citta` VARCHAR(45) NULL,
  `Credibilita` DOUBLE NOT NULL DEFAULT 0,
  `Domanda` VARCHAR(45) NULL,
  `Risposta` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  PRIMARY KEY (`Nickname`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Ordine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Ordine` (
  `CodOrdine` VARCHAR(45) NOT NULL,
  `TimeStamp` DATE NULL,
  `Stato` VARCHAR(45) NULL,
  `CodPianta` VARCHAR(45) NOT NULL,
  `Nickname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodOrdine`),
  INDEX `fk_Ordine_CatalogoPiante1_idx` (`CodPianta` ASC),
  INDEX `fk_Ordine_Account1_idx` (`Nickname` ASC),
  CONSTRAINT `fk_Ordine_CatalogoPiante1`
    FOREIGN KEY (`CodPianta`)
    REFERENCES `Progetto`.`CatalogoPiante` (`CodPianta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordine_Account1`
    FOREIGN KEY (`Nickname`)
    REFERENCES `Progetto`.`Account` (`Nickname`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Schede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Schede` (
  `CodScheda` VARCHAR(45) NOT NULL,
  `Collocata` VARCHAR(45) NULL,
  `CodOrdine` VARCHAR(45) NOT NULL,
  `Nickname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodScheda`),
  INDEX `fk_Schede_Ordine1_idx` (`CodOrdine` ASC),
  INDEX `fk_Schede_Account1_idx` (`Nickname` ASC),
  CONSTRAINT `fk_Schede_Ordine1`
    FOREIGN KEY (`CodOrdine`)
    REFERENCES `Progetto`.`Ordine` (`CodOrdine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Schede_Account1`
    FOREIGN KEY (`Nickname`)
    REFERENCES `Progetto`.`Account` (`Nickname`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Vaso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Vaso` (
  `CodVaso` INT NOT NULL AUTO_INCREMENT,
  `Forma` VARCHAR(45) NULL,
  `DimX` DOUBLE NULL,
  `DimY` DOUBLE NULL,
  `CodScheda` INT NOT NULL,
  PRIMARY KEY (`CodVaso`),
  INDEX `fk_Vaso_Schede1_idx` (`CodScheda` ASC),
  CONSTRAINT `fk_Vaso_Schede1`
    FOREIGN KEY (`CodScheda`)
    REFERENCES `Progetto`.`Schede` (`CodScheda`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Post` (
  `CodPost` VARCHAR(45) NOT NULL,
  `Testo` VARCHAR(100) NULL,
  `Thread` VARCHAR(45) NULL,
  `Risposta` VARCHAR(100) NULL,
  `TimeStamp` DATETIME NULL,
  `Nickname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodPost`),
  INDEX `fk_Post_Account1_idx` (`Nickname` ASC),
  CONSTRAINT `fk_Post_Account1`
    FOREIGN KEY (`Nickname`)
    REFERENCES `Progetto`.`Account` (`Nickname`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Link` (
  `Indirizzo` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Indirizzo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Collegamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Collegamento` (
  `Indirizzo` VARCHAR(200) NOT NULL,
  `CodPost` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Indirizzo`, `CodPost`),
  INDEX `fk_Collegamento_Post1_idx` (`CodPost` ASC),
  CONSTRAINT `fk_Collegamento_Link1`
    FOREIGN KEY (`Indirizzo`)
    REFERENCES `Progetto`.`Link` (`Indirizzo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Collegamento_Post1`
    FOREIGN KEY (`CodPost`)
    REFERENCES `Progetto`.`Post` (`CodPost`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Valutazioni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Giudizio` (
  `CodPost` VARCHAR(45) NOT NULL,
  `Nickname` VARCHAR(45) NOT NULL,
  `Voto` INT NULL,
  PRIMARY KEY (`CodPost`, `Nickname`),
  INDEX `fk_Giudizio_Account1_idx` (`Nickname` ASC),
  CONSTRAINT `fk_Giudizio_Post1`
    FOREIGN KEY (`CodPost`)
    REFERENCES `Progetto`.`Post` (`CodPost`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Giudizio_Account1`
    FOREIGN KEY (`Nickname`)
    REFERENCES `Progetto`.`Account` (`Nickname`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`SpazioVerde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`SpazioVerde` (
  `CodSpazio` VARCHAR(45) NOT NULL,
  `Area` DOUBLE NULL,
  `Nickname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodSpazio`),
  INDEX `fk_SpazioVerde_Account1_idx` (`Nickname` ASC),
  CONSTRAINT `fk_SpazioVerde_Account1`
    FOREIGN KEY (`Nickname`)
    REFERENCES `Progetto`.`Account` (`Nickname`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Settore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Settore` (
  `CodSettore` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NULL,
  `OreSole` INT NULL,
  `Area` DOUBLE NULL,
  `CodSpazio` VARCHAR(45) NOT NULL,
  `PuntoCardinale` VARCHAR(45) NULL,
  PRIMARY KEY (`CodSettore`),
  INDEX `fk_Settore_SpazioVerde1_idx` (`CodSpazio` ASC),
  CONSTRAINT `fk_Settore_SpazioVerde1`
    FOREIGN KEY (`CodSpazio`)
    REFERENCES `Progetto`.`SpazioVerde` (`CodSpazio`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Segmenti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Segmenti` (
  `CodSegmento` VARCHAR(45) NOT NULL,
  `Xiniziale` DOUBLE NULL,
  `Yiniziale` DOUBLE NULL,
  `Xfinale` DOUBLE NULL,
  `Yfinale` DOUBLE NULL,
  PRIMARY KEY (`CodSegmento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`ComposizioneSettore`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`ComposizioneSettore` (
  `CodSettore` VARCHAR(45) NOT NULL,
  `CodSegmento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodSettore`, `CodSegmento`),
  INDEX `fk_ComposizioneSettore_Segmenti1_idx` (`CodSegmento` ASC),
  CONSTRAINT `fk_ComposizioneSettore_Settore1`
    FOREIGN KEY (`CodSettore`)
    REFERENCES `Progetto`.`Settore` (`CodSettore`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ComposizioneSettore_Segmenti1`
    FOREIGN KEY (`CodSegmento`)
    REFERENCES `Progetto`.`Segmenti` (`CodSegmento`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`PiantaSelezionata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`PiantaSelezionata` (
  `CodPianta` VARCHAR(45) NOT NULL,
  `Raggio` DOUBLE NULL,
  `AsseX` DOUBLE NULL,
  `AsseY` DOUBLE NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `CodSettore` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodPianta`),
  INDEX `fk_PiantaSelezionata_Pianta1_idx` (`Nome` ASC),
  INDEX `fk_PiantaSelezionata_Settore1_idx` (`CodSettore` ASC),
  CONSTRAINT `fk_PiantaSelezionata_Pianta1`
    FOREIGN KEY (`Nome`)
    REFERENCES `Progetto`.`Pianta` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PiantaSelezionata_Settore1`
    FOREIGN KEY (`CodSettore`)
    REFERENCES `Progetto`.`Settore` (`CodSettore`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`VasoProgettazione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`VasoProgettazione` (
  `CodVaso` INT NOT NULL AUTO_INCREMENT,
  `Forma` VARCHAR(45) NULL,
  `AsseX` DOUBLE NULL,
  `AsseY` DOUBLE NULL,
  `CodPianta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodVaso`),
  INDEX `fk_VasoProgettazione_PiantaSelezionata1_idx` (`CodPianta` ASC),
  CONSTRAINT `fk_VasoProgettazione_PiantaSelezionata1`
    FOREIGN KEY (`CodPianta`)
    REFERENCES `Progetto`.`PiantaSelezionata` (`CodPianta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Preferiti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Preferiti` (
  `NomePianta` VARCHAR(45) NOT NULL,
  `Nickname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NomePianta`, `Nickname`),
  INDEX `fk_Preferiti_Account1_idx` (`Nickname` ASC),
  CONSTRAINT `fk_Preferiti_Pianta1`
    FOREIGN KEY (`NomePianta`)
    REFERENCES `Progetto`.`Pianta` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Preferiti_Account1`
    FOREIGN KEY (`Nickname`)
    REFERENCES `Progetto`.`Account` (`Nickname`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`ElementiDisciolti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`ElementiDisciolti` (
  `CodTerreno` VARCHAR(45) NOT NULL,
  `NomeElemento` VARCHAR(45) NOT NULL,
  `Concentrazione` VARCHAR(45) NULL,
  PRIMARY KEY (`CodTerreno`, `NomeElemento`),
  INDEX `fk_ElementiDisciolti_Elementi1_idx` (`NomeElemento` ASC),
  CONSTRAINT `fk_ElementiDisciolti_Terreno1`
    FOREIGN KEY (`CodTerreno`)
    REFERENCES `Progetto`.`Terreno` (`CodTerreno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ElementiDisciolti_Elementi1`
    FOREIGN KEY (`NomeElemento`)
    REFERENCES `Progetto`.`Elementi` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Componenti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Componenti` (
  `NomeComponente` VARCHAR(45) NOT NULL,
  `Permeabilità` VARCHAR(45) NULL,
  `Consistenza` VARCHAR(45) NULL,
  PRIMARY KEY (`NomeComponente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`ComposizioneTerreno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`ComposizioneTerreno` (
  `CodTerreno` VARCHAR(45) NOT NULL,
  `NomeComponente` VARCHAR(45) NOT NULL,
  `Concentrazione` VARCHAR(45) NULL,
  PRIMARY KEY (`CodTerreno`, `NomeComponente`),
  INDEX `fk_ComposizioneTerreno_Componenti1_idx` (`NomeComponente` ASC),
  CONSTRAINT `fk_ComposizioneTerreno_Terreno1`
    FOREIGN KEY (`CodTerreno`)
    REFERENCES `Progetto`.`Terreno` (`CodTerreno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ComposizioneTerreno_Componenti1`
    FOREIGN KEY (`NomeComponente`)
    REFERENCES `Progetto`.`Componenti` (`NomeComponente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Periodi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Periodi` (
  `MeseInizio` INT NOT NULL,
  `MeseFine` INT NOT NULL,
  PRIMARY KEY (`MeseInizio`, `MeseFine`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`PeriodiPianta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`PeriodiPianta` (
  `Nome` VARCHAR(45) NOT NULL,
  `MeseInizio` INT NOT NULL,
  `MeseFine` INT NOT NULL,
  `Tipologia` VARCHAR(45) NULL,
  PRIMARY KEY (`Nome`, `MeseInizio`, `MeseFine`),
  INDEX `fk_PeriodiPianta_Pianta1_idx` (`Nome` ASC),
  CONSTRAINT `fk_PeriodiPianta_Periodi1`
    FOREIGN KEY (`MeseInizio` , `MeseFine`)
    REFERENCES `Progetto`.`Periodi` (`MeseInizio` , `MeseFine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PeriodiPianta_Pianta1`
    FOREIGN KEY (`Nome`)
    REFERENCES `Progetto`.`Pianta` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Concimazione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Concimazione` (
  `CodConcimazione` VARCHAR(45) NOT NULL,
  `TipoSomministrazione` VARCHAR(45) NULL,
  `MeseInizio` INT NULL,
  `MeseFine` INT NULL,
  `NomeElemento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodConcimazione`),
  INDEX `fk_Concimazione_Elementi1_idx` (`NomeElemento` ASC),
  CONSTRAINT `fk_Concimazione_Elementi1`
    FOREIGN KEY (`NomeElemento`)
    REFERENCES `Progetto`.`Elementi` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`InterventoConcimazione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`InterventoConcimazione` (
  `NomePianta` VARCHAR(45) NOT NULL,
  `CodConcimazione` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NomePianta`, `CodConcimazione`),
  INDEX `fk_InterventoConcimazione_Pianta1_idx` (`NomePianta` ASC),
  INDEX `fk_InterventoConcimazione_Concimazione1_idx` (`CodConcimazione` ASC),
  CONSTRAINT `fk_InterventoConcimazione_Pianta1`
    FOREIGN KEY (`NomePianta`)
    REFERENCES `Progetto`.`Pianta` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InterventoConcimazione_Concimazione1`
    FOREIGN KEY (`CodConcimazione`)
    REFERENCES `Progetto`.`Concimazione` (`CodConcimazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`InfoSomministrazioni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`InfoSomministrazioni` (
  `CodConcimazione` VARCHAR(45) NOT NULL,
  `NumSomministrazioni` INT NOT NULL,
  `Quantita` DOUBLE NOT NULL,
  PRIMARY KEY (`CodConcimazione`, `NumSomministrazioni`, `Quantita`),
  CONSTRAINT `fk_InfoSomministrazioni_Concimazione1`
    FOREIGN KEY (`CodConcimazione`)
    REFERENCES `Progetto`.`Concimazione` (`CodConcimazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Somministrazione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Somministrazione` (
  `NumSomministrazioni` INT NOT NULL,
  `Quantita` DOUBLE NOT NULL,
  PRIMARY KEY (`NumSomministrazioni`, `Quantita`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Interventi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Interventi` (
  `CodIntervento` VARCHAR(45) NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Descrizione` VARCHAR(200) NULL,
  PRIMARY KEY (`CodIntervento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`InterventiManutenzione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`InterventiManutenzione` (
  `CodIntervento` VARCHAR(45) NOT NULL,
  `NomeGenere` VARCHAR(45) NOT NULL,
  `MeseInizio` INT NULL,
  `MeseFine` INT NULL,
  PRIMARY KEY (`CodIntervento`, `NomeGenere`),
  INDEX `fk_InterventiManutenzione_Genere1_idx` (`NomeGenere` ASC),
  INDEX `fk_InterventiManutenzione_Interventi1_idx` (`CodIntervento` ASC),
  CONSTRAINT `fk_InterventiManutenzione_Genere1`
    FOREIGN KEY (`NomeGenere`)
    REFERENCES `Progetto`.`Genere` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InterventiManutenzione_Interventi1`
    FOREIGN KEY (`CodIntervento`)
    REFERENCES `Progetto`.`Interventi` (`CodIntervento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`RichiesteManutenzione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`RichiesteManutenzione` (
  `CodManutenzione` VARCHAR(45) NOT NULL,
  `Costo` INT NULL,
  `TipoRichiesta` VARCHAR(45) NULL,
  `TipoIntervento` VARCHAR(45) NULL,
  `Scadenza` DATE NULL,
  `Prenotazione` DATE NULL,
  `Periodicita` INT NULL,
  `CodScheda` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodManutenzione`),
  INDEX `fk_RichiesteManutenzione_Schede1_idx` (`CodScheda` ASC),
  CONSTRAINT `fk_RichiesteManutenzione_Schede1`
    FOREIGN KEY (`CodScheda`)
    REFERENCES `Progetto`.`Schede` (`CodScheda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`RichiesteIntervento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`RichiesteIntervento` (
  `CodIntervento` VARCHAR(45) NOT NULL,
  `CodManutenzione` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodIntervento`, `CodManutenzione`),
  INDEX `fk_RichiesteIntervento_RichiesteManutenzione1_idx` (`CodManutenzione` ASC),
  CONSTRAINT `fk_RichiesteIntervento_Interventi1`
    FOREIGN KEY (`CodIntervento`)
    REFERENCES `Progetto`.`Interventi` (`CodIntervento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RichiesteIntervento_RichiesteManutenzione1`
    FOREIGN KEY (`CodManutenzione`)
    REFERENCES `Progetto`.`RichiesteManutenzione` (`CodManutenzione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`RichiestaConcimazione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`RichiestaConcimazione` (
  `CodConcimazione` VARCHAR(45) NOT NULL,
  `CodManutenzione` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CodConcimazione`, `CodManutenzione`),
  INDEX `fk_RichiestaConcimazione_RichiesteManutenzione1_idx` (`CodManutenzione` ASC),
  CONSTRAINT `fk_RichiestaConcimazione_Concimazione1`
    FOREIGN KEY (`CodConcimazione`)
    REFERENCES `Progetto`.`Concimazione` (`CodConcimazione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RichiestaConcimazione_RichiesteManutenzione1`
    FOREIGN KEY (`CodManutenzione`)
    REFERENCES `Progetto`.`RichiesteManutenzione` (`CodManutenzione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`TrattamentiPreventivi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`TrattamentiPreventivi` (
  `CodManutenzione` VARCHAR(45) NOT NULL,
  `NomeProdotto` VARCHAR(45) NOT NULL,
  `Dose` DOUBLE NULL,
  PRIMARY KEY (`CodManutenzione`, `NomeProdotto`),
  INDEX `fk_TrattamentiPreventivi_Prodotto1_idx` (`NomeProdotto` ASC),
  CONSTRAINT `fk_TrattamentiPreventivi_RichiesteManutenzione1`
    FOREIGN KEY (`CodManutenzione`)
    REFERENCES `Progetto`.`RichiesteManutenzione` (`CodManutenzione`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TrattamentiPreventivi_Prodotto1`
    FOREIGN KEY (`NomeProdotto`)
    REFERENCES `Progetto`.`Prodotto` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`PeriodiInutilizzo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`PeriodiInutilizzo` (
  `NomeProdotto` VARCHAR(45) NOT NULL,
  `MeseInizio` INT NOT NULL,
  `MeseFine` INT NOT NULL,
  PRIMARY KEY (`NomeProdotto`, `MeseInizio`, `MeseFine`),
  INDEX `fk_PeriodiInutilizzo_Periodi1_idx` (`MeseInizio` ASC, `MeseFine` ASC),
  CONSTRAINT `fk_PeriodiInutilizzo_Prodotto1`
    FOREIGN KEY (`NomeProdotto`)
    REFERENCES `Progetto`.`Prodotto` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PeriodiInutilizzo_Periodi1`
    FOREIGN KEY (`MeseInizio` , `MeseFine`)
    REFERENCES `Progetto`.`Periodi` (`MeseInizio` , `MeseFine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`AgentePatogeno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`AgentePatogeno` (
  `Nome` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Indicazione`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Indicazione` (
  `NomeAgentePatogeno` VARCHAR(45) NOT NULL,
  `NomeProdotto` VARCHAR(45) NOT NULL,
  `TipoSomministrazione` VARCHAR(45) NULL,
  `DosaggioConsigliato` DOUBLE NULL,
  PRIMARY KEY (`NomeAgentePatogeno`, `NomeProdotto`),
  INDEX `fk_Indicazione_Prodotto1_idx` (`NomeProdotto` ASC),
  CONSTRAINT `fk_Indicazione_AgentePatogeno1`
    FOREIGN KEY (`NomeAgentePatogeno`)
    REFERENCES `Progetto`.`AgentePatogeno` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Indicazione_Prodotto1`
    FOREIGN KEY (`NomeProdotto`)
    REFERENCES `Progetto`.`Prodotto` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`PrincipioAttivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`PrincipioAttivo` (
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`BasatoSu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`BasatoSu` (
  `NomePrincipioAttivo` VARCHAR(45) NOT NULL,
  `NomeProdotto` VARCHAR(45) NOT NULL,
  `Concentrazione` DOUBLE NULL,
  PRIMARY KEY (`NomePrincipioAttivo`, `NomeProdotto`),
  INDEX `fk_BasatoSu_Prodotto1_idx` (`NomeProdotto` ASC),
  CONSTRAINT `fk_BasatoSu_PrincipioAttivo1`
    FOREIGN KEY (`NomePrincipioAttivo`)
    REFERENCES `Progetto`.`PrincipioAttivo` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BasatoSu_Prodotto1`
    FOREIGN KEY (`NomeProdotto`)
    REFERENCES `Progetto`.`Prodotto` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`Patologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`Patologia` (
  `Nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`CausaPatologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`CausaPatologia` (
  `NomePatologia` VARCHAR(45) NOT NULL,
  `NomeAgentePatogeno` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NomePatologia`, `NomeAgentePatogeno`),
  INDEX `fk_CausaPatologia_AgentePatogeno1_idx` (`NomeAgentePatogeno` ASC),
  CONSTRAINT `fk_CausaPatologia_Patologia1`
    FOREIGN KEY (`NomePatologia`)
    REFERENCES `Progetto`.`Patologia` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CausaPatologia_AgentePatogeno1`
    FOREIGN KEY (`NomeAgentePatogeno`)
    REFERENCES `Progetto`.`AgentePatogeno` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`PatologiePianta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`PatologiePianta` (
  `NomePianta` VARCHAR(45) NOT NULL,
  `NomePatologia` VARCHAR(45) NOT NULL,
  `Periodo` VARCHAR(45) NULL,
  `Probabilita` DOUBLE NULL,
  PRIMARY KEY (`NomePianta`, `NomePatologia`),
  INDEX `fk_PatologiePianta_Patologia1_idx` (`NomePatologia` ASC),
  CONSTRAINT `fk_PatologiePianta_Pianta1`
    FOREIGN KEY (`NomePianta`)
    REFERENCES `Progetto`.`Pianta` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PatologiePianta_Patologia1`
    FOREIGN KEY (`NomePatologia`)
    REFERENCES `Progetto`.`Patologia` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Progetto`.`SintomiPatologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progetto`.`SintomiPatologia` (
  `NomePatologia` VARCHAR(45) NOT NULL,
  `CodSintomo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NomePatologia`, `CodSintomo`),
  INDEX `fk_SintomiPatologia_Sintomi1_idx` (`CodSintomo` ASC),
  CONSTRAINT `fk_SintomiPatologia_Patologia1`
    FOREIGN KEY (`NomePatologia`)
    REFERENCES `Progetto`.`Patologia` (`Nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SintomiPatologia_Sintomi1`
    FOREIGN KEY (`CodSintomo`)
    REFERENCES `Progetto`.`Sintomi` (`CodSintomo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
