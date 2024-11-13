-- MySQL Script generated by MySQL Workbench
-- Wed Nov 13 18:34:23 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Centre_Formation
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Centre_Formation
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Centre_Formation` DEFAULT CHARACTER SET utf8 ;
USE `Centre_Formation` ;

-- -----------------------------------------------------
-- Table `Centre_Formation`.`Session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Centre_Formation`.`Session` (
  `CodeSess` INT NOT NULL,
  `nomSess` VARCHAR(45) NOT NULL,
  `datedebut` DATE NOT NULL,
  `datefin` DATE NOT NULL,
  PRIMARY KEY (`CodeSess`),
  UNIQUE INDEX `Codesess_UNIQUE` (`CodeSess` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Centre_Formation`.`Inscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Centre_Formation`.`Inscription` (
  `numCINEtu` INT NOT NULL,
  `CodeSess` INT NOT NULL,
  `typeCours` LONGTEXT NOT NULL,
  `Session_CodeSess` INT NOT NULL,
  PRIMARY KEY (`numCINEtu`, `CodeSess`),
  UNIQUE INDEX `numCINEtu_UNIQUE` (`numCINEtu` ASC) VISIBLE,
  UNIQUE INDEX `CodeSess_UNIQUE` (`CodeSess` ASC) VISIBLE,
  INDEX `fk_Inscription_Session1_idx` (`Session_CodeSess` ASC) VISIBLE,
  CONSTRAINT `fk_Inscription_Session1`
    FOREIGN KEY (`Session_CodeSess`)
    REFERENCES `Centre_Formation`.`Session` (`CodeSess`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Centre_Formation`.`Etudiant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Centre_Formation`.`Etudiant` (
  `NumCINETu` INT NOT NULL,
  `NomETu` VARCHAR(45) NOT NULL,
  `PrenomETu` VARCHAR(45) NOT NULL,
  `Date_naissance` DATE NOT NULL,
  `AdresseETu` VARCHAR(45) NOT NULL,
  `VilleETu` VARCHAR(45) NOT NULL,
  `NiveauETu` VARCHAR(45) NOT NULL,
  `Inscription_numCINEtu` INT NOT NULL,
  `Inscription_CodeSess` INT NOT NULL,
  PRIMARY KEY (`NumCINETu`),
  UNIQUE INDEX `NumCINETu_UNIQUE` (`NumCINETu` ASC) VISIBLE,
  INDEX `fk_Etudiant_Inscription_idx` (`Inscription_numCINEtu` ASC, `Inscription_CodeSess` ASC) VISIBLE,
  CONSTRAINT `fk_Etudiant_Inscription`
    FOREIGN KEY (`Inscription_numCINEtu` , `Inscription_CodeSess`)
    REFERENCES `Centre_Formation`.`Inscription` (`numCINEtu` , `CodeSess`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Centre_Formation`.`Appartenance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Centre_Formation`.`Appartenance` (
  `CodeForm` INT NOT NULL,
  `CodeSpec` INT NOT NULL,
  PRIMARY KEY (`CodeForm`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Centre_Formation`.`Formation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Centre_Formation`.`Formation` (
  `CodeForm` INT NOT NULL,
  `titreForm` VARCHAR(45) NOT NULL,
  `dureeForm` INT(3) NOT NULL,
  `dateForm` DATE NOT NULL,
  `Session_CodeSess` INT NOT NULL,
  `Appartenance_CodeForm` INT NOT NULL,
  PRIMARY KEY (`CodeForm`, `Appartenance_CodeForm`),
  INDEX `fk_Formation_Session1_idx` (`Session_CodeSess` ASC) VISIBLE,
  INDEX `fk_Formation_Appartenance1_idx` (`Appartenance_CodeForm` ASC) VISIBLE,
  CONSTRAINT `fk_Formation_Session1`
    FOREIGN KEY (`Session_CodeSess`)
    REFERENCES `Centre_Formation`.`Session` (`CodeSess`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Formation_Appartenance1`
    FOREIGN KEY (`Appartenance_CodeForm`)
    REFERENCES `Centre_Formation`.`Appartenance` (`CodeForm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Centre_Formation`.`Specialite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Centre_Formation`.`Specialite` (
  `CodeSpec` INT NOT NULL,
  `nomSpec` VARCHAR(45) NOT NULL,
  `descSpec` TEXT(100) NOT NULL,
  `active` INT NOT NULL,
  `Appartenance_CodeForm` INT NOT NULL,
  PRIMARY KEY (`CodeSpec`),
  UNIQUE INDEX `CodeSpec_UNIQUE` (`CodeSpec` ASC) VISIBLE,
  INDEX `fk_Specialite_Appartenance1_idx` (`Appartenance_CodeForm` ASC) VISIBLE,
  CONSTRAINT `fk_Specialite_Appartenance1`
    FOREIGN KEY (`Appartenance_CodeForm`)
    REFERENCES `Centre_Formation`.`Appartenance` (`CodeForm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
