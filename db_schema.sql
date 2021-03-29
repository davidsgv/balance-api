-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema finanzas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema finanzas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `finanzas` DEFAULT CHARACTER SET utf8 ;
USE `finanzas` ;

-- -----------------------------------------------------
-- Table `finanzas`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finanzas`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(250) NOT NULL,
  `apellido` VARCHAR(250) NOT NULL,
  `correo` VARCHAR(300) NOT NULL,
  `password` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `finanzas`.`cuenta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finanzas`.`cuenta` (
  `idcuenta` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(45) NULL,
  `saldo` BIGINT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `nombre` VARCHAR(250) NOT NULL,
  `descripcion` VARCHAR(500) NULL,
  PRIMARY KEY (`idcuenta`),
  INDEX `fk_cuentas_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_cuentas_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `finanzas`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `finanzas`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finanzas`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idcategoria`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `finanzas`.`movimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finanzas`.`movimiento` (
  `idmovimiento` INT NOT NULL AUTO_INCREMENT,
  `valor` BIGINT NOT NULL,
  `fecha` TIMESTAMP(2) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `descripcion` VARCHAR(300) NULL,
  `cuentas_idcuentas` INT NOT NULL,
  `categoria_idcategoria` INT NOT NULL,
  `tipo` ENUM("ingreso", "egreso") NULL,
  PRIMARY KEY (`idmovimiento`),
  INDEX `fk_gastos_cuentas_idx` (`cuentas_idcuentas` ASC) VISIBLE,
  INDEX `fk_gastos_categoria1_idx` (`categoria_idcategoria` ASC) VISIBLE,
  CONSTRAINT `fk_gastos_cuentas`
    FOREIGN KEY (`cuentas_idcuentas`)
    REFERENCES `finanzas`.`cuenta` (`idcuenta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gastos_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `finanzas`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
INSERT_METHOD = LAST;


-- -----------------------------------------------------
-- Table `finanzas`.`sesiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finanzas`.`sesiones` (
  `idsesiones` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  `token` VARCHAR(900) NOT NULL,
  `especificaciones_dispositivo` VARCHAR(900) NOT NULL,
  PRIMARY KEY (`idsesiones`),
  INDEX `fk_sesiones_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_sesiones_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `finanzas`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `finanzas`.`deuda_prestamo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finanzas`.`deuda_prestamo` (
  `iddeuda` INT NOT NULL,
  `valor` BIGINT NOT NULL,
  `interes` INT NOT NULL,
  `nombre_prestador` VARCHAR(500) NULL,
  `usuario_idusuario` INT NOT NULL,
  `tipo` ENUM("deuda", "prestamo") NOT NULL,
  PRIMARY KEY (`iddeuda`),
  INDEX `fk_deuda_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_deuda_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `finanzas`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `finanzas`.`suscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finanzas`.`suscripcion` (
  `idsuscripcion` INT NOT NULL,
  `nombre` VARCHAR(250) NOT NULL,
  `descripcion` VARCHAR(1000) NULL,
  `valor` BIGINT NOT NULL,
  `fecha_pago` DATE NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idsuscripcion`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  INDEX `fk_suscripcion_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_suscripcion_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `finanzas`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
