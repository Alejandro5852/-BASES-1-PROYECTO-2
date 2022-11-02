-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema proyecto2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyecto2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto2` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema proyecto2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyecto2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `proyecto2` ;

-- -----------------------------------------------------
-- Table `proyecto2`.`tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`tipo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto2`.`log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fechaRegistro` DATETIME NOT NULL DEFAULT NOW(),
  `descripcion` BLOB NOT NULL,
  `tipo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_log_tipo_idx` (`tipo_id` ASC) VISIBLE,
  CONSTRAINT `fk_log_tipo`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `proyecto2`.`tipo` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `proyecto2` ;

-- -----------------------------------------------------
-- Table `proyecto2`.`carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`carrera` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fechaRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nombre` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto2`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`curso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fechaRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `codigo` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(500) NOT NULL,
  `creditosN` INT NOT NULL,
  `creditosO` INT NOT NULL,
  `esObligatorio` INT NOT NULL DEFAULT '1',
  `carrera_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  INDEX `fk_curso_carrera1_idx` (`carrera_id` ASC) VISIBLE,
  CONSTRAINT `fk_curso_carrera1`
    FOREIGN KEY (`carrera_id`)
    REFERENCES `proyecto2`.`carrera` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto2`.`docente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`docente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fechaRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `registroSIIF` VARCHAR(100) NOT NULL,
  `nombres` VARCHAR(500) NOT NULL,
  `apellidos` VARCHAR(500) NOT NULL,
  `fechaNacimiento` DATETIME NOT NULL,
  `correo` VARCHAR(500) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `direccion` BLOB NOT NULL,
  `dpi` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `dpi_UNIQUE` (`dpi` ASC) VISIBLE,
  UNIQUE INDEX `registroSIIF_UNIQUE` (`registroSIIF` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto2`.`habilitacioncurso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`habilitacioncurso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ciclo` VARCHAR(45) NOT NULL,
  `fechaRegistro` DATETIME NOT NULL,
  `cupoMaximo` INT NOT NULL,
  `estudiantesAsignados` INT NOT NULL,
  `seccion` VARCHAR(5) NOT NULL,
  `curso_id` INT NOT NULL,
  `docente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_habilitacionCurso_curso1_idx` (`curso_id` ASC) VISIBLE,
  INDEX `fk_habilitacionCurso_docente1_idx` (`docente_id` ASC) VISIBLE,
  CONSTRAINT `fk_habilitacionCurso_curso1`
    FOREIGN KEY (`curso_id`)
    REFERENCES `proyecto2`.`curso` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_habilitacionCurso_docente1`
    FOREIGN KEY (`docente_id`)
    REFERENCES `proyecto2`.`docente` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto2`.`acta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`acta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fechaRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `habilitacionCurso_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_acta_habilitacionCurso1_idx` (`habilitacionCurso_id` ASC) VISIBLE,
  CONSTRAINT `fk_acta_habilitacionCurso1`
    FOREIGN KEY (`habilitacionCurso_id`)
    REFERENCES `proyecto2`.`habilitacioncurso` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto2`.`estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`estudiante` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fechaRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `carnet` VARCHAR(45) NOT NULL,
  `nombres` VARCHAR(500) NOT NULL,
  `apellidos` VARCHAR(500) NOT NULL,
  `fechaNacimiento` DATETIME NOT NULL,
  `correo` VARCHAR(500) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `direccion` BLOB NOT NULL,
  `dpi` VARCHAR(13) NOT NULL,
  `creditos` INT NOT NULL DEFAULT '0',
  `carrera_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `carnet_UNIQUE` (`carnet` ASC) VISIBLE,
  UNIQUE INDEX `dpi_UNIQUE` (`dpi` ASC) VISIBLE,
  INDEX `fk_estudiante_carrera_idx` (`carrera_id` ASC) VISIBLE,
  CONSTRAINT `fk_estudiante_carrera`
    FOREIGN KEY (`carrera_id`)
    REFERENCES `proyecto2`.`carrera` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto2`.`asignacioncurso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`asignacioncurso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fechaRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `habilitacionCurso_id` INT NOT NULL,
  `estudiante_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_asignacionCurso_habilitacionCurso1_idx` (`habilitacionCurso_id` ASC) VISIBLE,
  INDEX `fk_asignacionCurso_estudiante1_idx` (`estudiante_id` ASC) VISIBLE,
  CONSTRAINT `fk_asignacionCurso_estudiante1`
    FOREIGN KEY (`estudiante_id`)
    REFERENCES `proyecto2`.`estudiante` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_asignacionCurso_habilitacionCurso1`
    FOREIGN KEY (`habilitacionCurso_id`)
    REFERENCES `proyecto2`.`habilitacioncurso` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto2`.`desasignacioncurso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`desasignacioncurso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fechaRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estudiante_id` INT NOT NULL,
  `habilitacionCurso_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_desAsignacionCurso_estudiante1_idx` (`estudiante_id` ASC) VISIBLE,
  INDEX `fk_desAsignacionCurso_habilitacionCurso1_idx` (`habilitacionCurso_id` ASC) VISIBLE,
  CONSTRAINT `fk_desAsignacionCurso_estudiante1`
    FOREIGN KEY (`estudiante_id`)
    REFERENCES `proyecto2`.`estudiante` (`id`),
  CONSTRAINT `fk_desAsignacionCurso_habilitacionCurso1`
    FOREIGN KEY (`habilitacionCurso_id`)
    REFERENCES `proyecto2`.`habilitacioncurso` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto2`.`horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`horario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fechaRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dia` VARCHAR(500) NOT NULL,
  `horario` VARCHAR(500) NOT NULL,
  `habilitacionCurso_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_horario_habilitacionCurso1_idx` (`habilitacionCurso_id` ASC) VISIBLE,
  CONSTRAINT `fk_horario_habilitacionCurso1`
    FOREIGN KEY (`habilitacionCurso_id`)
    REFERENCES `proyecto2`.`habilitacioncurso` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `proyecto2`.`nota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto2`.`nota` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fechaRegistro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nota` DECIMAL(15,4) NOT NULL DEFAULT '0.0000',
  `habilitacionCurso_id` INT NOT NULL,
  `estudiante_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nota_habilitacionCurso1_idx` (`habilitacionCurso_id` ASC) VISIBLE,
  INDEX `fk_nota_estudiante1_idx` (`estudiante_id` ASC) VISIBLE,
  CONSTRAINT `fk_nota_estudiante1`
    FOREIGN KEY (`estudiante_id`)
    REFERENCES `proyecto2`.`estudiante` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_nota_habilitacionCurso1`
    FOREIGN KEY (`habilitacionCurso_id`)
    REFERENCES `proyecto2`.`habilitacioncurso` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
