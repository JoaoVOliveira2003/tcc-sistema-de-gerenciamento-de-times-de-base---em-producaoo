
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tcc
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tcc` ;

-- -----------------------------------------------------
-- Schema tcc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tcc` DEFAULT CHARACTER SET utf8mb4 ;
USE `tcc` ;

-- -----------------------------------------------------
-- Table `tcc`.`nacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`nacao` ;

CREATE TABLE IF NOT EXISTS `tcc`.`nacao` (
  `cod_nacao` SMALLINT NOT NULL,
  `sigla_nacao` CHAR(3) NULL,
  PRIMARY KEY (`cod_nacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`estado` ;

CREATE TABLE IF NOT EXISTS `tcc`.`estado` (
  `cod_estado` SMALLINT NOT NULL,
  `cod_nacao` SMALLINT NULL,
  `desc_estado` VARCHAR(50) NULL,
  `sigla_estado` CHAR(3) NULL,
  `nacao_cod_nacao` SMALLINT NOT NULL,
  `nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `nacao_cod_nacao1` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_estado`, `nacao_cod_nacao`, `nacao_nacao_midia_cod_nacao`, `nacao_cod_nacao1`),
  INDEX `fk_estado_nacao1_idx` (`nacao_cod_nacao1` ASC) VISIBLE,
  CONSTRAINT `fk_estado_nacao1`
    FOREIGN KEY (`nacao_cod_nacao1`)
    REFERENCES `tcc`.`nacao` (`cod_nacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`municipio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`municipio` ;

CREATE TABLE IF NOT EXISTS `tcc`.`municipio` (
  `cod_municipio` INT NOT NULL,
  `cod_estado` SMALLINT NULL,
  `cod_nacao` SMALLINT NULL,
  `desc_municipio` VARCHAR(50) NULL,
  `sigla_municipio` CHAR(3) NULL,
  `estado_cod_estado` SMALLINT NOT NULL,
  `estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_municipio`, `estado_cod_estado`, `estado_nacao_cod_nacao`, `estado_nacao_nacao_midia_cod_nacao`, `estado_nacao_cod_nacao1`),
  INDEX `fk_municipio_estado1_idx` (`estado_cod_estado` ASC, `estado_nacao_cod_nacao` ASC, `estado_nacao_nacao_midia_cod_nacao` ASC, `estado_nacao_cod_nacao1` ASC) VISIBLE,
  CONSTRAINT `fk_municipio_estado1`
    FOREIGN KEY (`estado_cod_estado` , `estado_nacao_cod_nacao` , `estado_nacao_nacao_midia_cod_nacao` , `estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`estado` (`cod_estado` , `nacao_cod_nacao` , `nacao_nacao_midia_cod_nacao` , `nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`ca﻿dastro_Identificacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`ca﻿dastro_Identificacao` ;

CREATE TABLE IF NOT EXISTS `tcc`.`ca﻿dastro_Identificacao` (
  `cod_usuario` INT NOT NULL,
  `nome` INT NULL,
  `cpf` VARCHAR(11) NULL,
  `ativo` CHAR(1) NULL,
  `cod_municipio` SMALLINT NULL,
  `cod_estado` SMALLINT NULL,
  `cod_nacao` SMALLINT NULL,
  `municipio_cod_municipio` INT NOT NULL,
  `municipio_estado_cod_estado` SMALLINT NOT NULL,
  `municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_usuario`, `municipio_cod_municipio`, `municipio_estado_cod_estado`, `municipio_estado_nacao_cod_nacao`, `municipio_estado_nacao_nacao_midia_cod_nacao`, `municipio_estado_nacao_cod_nacao1`),
  UNIQUE INDEX `cod_usuario_UNIQUE` (`cod_usuario` ASC) VISIBLE,
  INDEX `fk_ca﻿dastro_Identificacao_municipio1_idx` (`municipio_cod_municipio` ASC, `municipio_estado_cod_estado` ASC, `municipio_estado_nacao_cod_nacao` ASC, `municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  CONSTRAINT `fk_ca﻿dastro_Identificacao_municipio1`
    FOREIGN KEY (`municipio_cod_municipio` , `municipio_estado_cod_estado` , `municipio_estado_nacao_cod_nacao` , `municipio_estado_nacao_nacao_midia_cod_nacao` , `municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`municipio` (`cod_municipio` , `estado_cod_estado` , `estado_nacao_cod_nacao` , `estado_nacao_nacao_midia_cod_nacao` , `estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`login_usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`login_usuario` ;

CREATE TABLE IF NOT EXISTS `tcc`.`login_usuario` (
  `cod_usuarui` INT NOT NULL,
  `email_usuario` VARCHAR(50) NULL,
  `senha` VARCHAR(50) NULL,
  `Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  PRIMARY KEY (`cod_usuarui`, `Ca﻿dastro_Identificacao_cod_usuario`),
  UNIQUE INDEX `cod_usuarui_UNIQUE` (`cod_usuarui` ASC) VISIBLE,
  INDEX `fk_login_usuario_Ca﻿dastro_Identificacao_idx` (`Ca﻿dastro_Identificacao_cod_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_login_usuario_Ca﻿dastro_Identificacao`
    FOREIGN KEY (`Ca﻿dastro_Identificacao_cod_usuario`)
    REFERENCES `tcc`.`ca﻿dastro_Identificacao` (`cod_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`role_cadastro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`role_cadastro` ;

CREATE TABLE IF NOT EXISTS `tcc`.`role_cadastro` (
  `cod_usuario` INT NOT NULL,
  `cod_tipoRole` INT NULL,
  `tipo_role_cod_tipoRole` INT NOT NULL,
  `ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `municipio_cod_municipio` INT NOT NULL,
  `municipio_estado_cod_estado` SMALLINT NOT NULL,
  `municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_usuario`, `tipo_role_cod_tipoRole`, `ca﻿dastro_Identificacao_cod_usuario`, `municipio_cod_municipio`, `municipio_estado_cod_estado`, `municipio_estado_nacao_cod_nacao`, `municipio_estado_nacao_nacao_midia_cod_nacao`, `municipio_estado_nacao_cod_nacao1`),
  INDEX `fk_role_cadastro_ca﻿dastro_Identificacao1_idx` (`ca﻿dastro_Identificacao_cod_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_role_cadastro_ca﻿dastro_Identificacao1`
    FOREIGN KEY (`ca﻿dastro_Identificacao_cod_usuario`)
    REFERENCES `tcc`.`ca﻿dastro_Identificacao` (`cod_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`tipo_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`tipo_role` ;

CREATE TABLE IF NOT EXISTS `tcc`.`tipo_role` (
  `cod_tipoRole` INT NOT NULL,
  `desc_tipoRole` VARCHAR(100) NULL,
  `abrev_tipoRole` CHAR(10) NULL,
  `ativo` CHAR(1) NULL,
  `role_cadastro_cod_usuario` INT NOT NULL,
  `role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  PRIMARY KEY (`cod_tipoRole`, `role_cadastro_cod_usuario`, `role_cadastro_tipo_role_cod_tipoRole`),
  INDEX `fk_tipo_role_role_cadastro1_idx` (`role_cadastro_cod_usuario` ASC, `role_cadastro_tipo_role_cod_tipoRole` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_role_role_cadastro1`
    FOREIGN KEY (`role_cadastro_cod_usuario` , `role_cadastro_tipo_role_cod_tipoRole`)
    REFERENCES `tcc`.`role_cadastro` (`cod_usuario` , `tipo_role_cod_tipoRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`item_menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`item_menu` ;

CREATE TABLE IF NOT EXISTS `tcc`.`item_menu` (
  `cod_tipoRole` INT NOT NULL,
  `cod_itemMenu` INT NOT NULL,
  `href` VARCHAR(200) NULL,
  `id` VARCHAR(200) NULL,
  `role` VARCHAR(200) NULL,
  `label` VARCHAR(200) NULL,
  `tipo_role_cod_tipoRole` INT NOT NULL,
  PRIMARY KEY (`cod_tipoRole`, `cod_itemMenu`, `tipo_role_cod_tipoRole`),
  INDEX `fk_item_menu_tipo_role1_idx` (`tipo_role_cod_tipoRole` ASC) VISIBLE,
  CONSTRAINT `fk_item_menu_tipo_role1`
    FOREIGN KEY (`tipo_role_cod_tipoRole`)
    REFERENCES `tcc`.`tipo_role` (`cod_tipoRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`subitem_menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`subitem_menu` ;

CREATE TABLE IF NOT EXISTS `tcc`.`subitem_menu` (
  `cod_itemSubMenu` INT NOT NULL,
  `cod_itemMenu` INT NULL,
  `href` VARCHAR(200) NULL,
  `label` VARCHAR(200) NULL,
  `item_menu_cod_tipoRole` INT NOT NULL,
  `item_menu_cod_itemMenu` INT NOT NULL,
  `item_menu_tipo_role_cod_tipoRole` INT NOT NULL,
  PRIMARY KEY (`cod_itemSubMenu`, `item_menu_cod_tipoRole`, `item_menu_cod_itemMenu`, `item_menu_tipo_role_cod_tipoRole`),
  INDEX `fk_subitem_menu_item_menu1_idx` (`item_menu_cod_tipoRole` ASC, `item_menu_cod_itemMenu` ASC, `item_menu_tipo_role_cod_tipoRole` ASC) VISIBLE,
  CONSTRAINT `fk_subitem_menu_item_menu1`
    FOREIGN KEY (`item_menu_cod_tipoRole` , `item_menu_cod_itemMenu` , `item_menu_tipo_role_cod_tipoRole`)
    REFERENCES `tcc`.`item_menu` (`cod_tipoRole` , `cod_itemMenu` , `tipo_role_cod_tipoRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`nacao_midia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`nacao_midia` ;

CREATE TABLE IF NOT EXISTS `tcc`.`nacao_midia` (
  `cod_nacao` INT NOT NULL,
  `local_midia` VARCHAR(100) NULL,
  `nacao_cod_nacao` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_nacao`, `nacao_cod_nacao`),
  INDEX `fk_nacao_midia_nacao1_idx` (`nacao_cod_nacao` ASC) VISIBLE,
  CONSTRAINT `fk_nacao_midia_nacao1`
    FOREIGN KEY (`nacao_cod_nacao`)
    REFERENCES `tcc`.`nacao` (`cod_nacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`staff` ;

CREATE TABLE IF NOT EXISTS `tcc`.`staff` (
  `cod_staff` INT NOT NULL,
  `tipo_role` INT NULL,
  `ativo` CHAR(1) NULL,
  `role_cadastro_cod_usuario` INT NOT NULL,
  `role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `role_cadastro_cod_usuario1` INT NOT NULL,
  `role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_staff`, `role_cadastro_cod_usuario`, `role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `role_cadastro_tipo_role_cod_tipoRole`, `role_cadastro_cod_usuario1`, `role_cadastro_tipo_role_cod_tipoRole1`, `role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `role_cadastro_municipio_cod_municipio`, `role_cadastro_municipio_estado_cod_estado`, `role_cadastro_municipio_estado_nacao_cod_nacao`, `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `role_cadastro_municipio_estado_nacao_cod_nacao1`),
  INDEX `fk_staff_role_cadastro1_idx` (`role_cadastro_cod_usuario1` ASC, `role_cadastro_tipo_role_cod_tipoRole1` ASC, `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `role_cadastro_municipio_cod_municipio` ASC, `role_cadastro_municipio_estado_cod_estado` ASC, `role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  CONSTRAINT `fk_staff_role_cadastro1`
    FOREIGN KEY (`role_cadastro_cod_usuario1` , `role_cadastro_tipo_role_cod_tipoRole1` , `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_municipio_cod_municipio` , `role_cadastro_municipio_estado_cod_estado` , `role_cadastro_municipio_estado_nacao_cod_nacao` , `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`role_cadastro` (`cod_usuario` , `tipo_role_cod_tipoRole` , `ca﻿dastro_Identificacao_cod_usuario` , `municipio_cod_municipio` , `municipio_estado_cod_estado` , `municipio_estado_nacao_cod_nacao` , `municipio_estado_nacao_nacao_midia_cod_nacao` , `municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`admistrador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`admistrador` ;

CREATE TABLE IF NOT EXISTS `tcc`.`admistrador` (
  `cod_admistrador` INT NOT NULL,
  `ativo` CHAR(1) NULL,
  `tipo_role` INT NULL,
  `role_cadastro_cod_usuario` INT NOT NULL,
  `role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `role_cadastro_cod_usuario1` INT NOT NULL,
  `role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_admistrador`, `role_cadastro_cod_usuario`, `role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `role_cadastro_tipo_role_cod_tipoRole`, `role_cadastro_cod_usuario1`, `role_cadastro_tipo_role_cod_tipoRole1`, `role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `role_cadastro_municipio_cod_municipio`, `role_cadastro_municipio_estado_cod_estado`, `role_cadastro_municipio_estado_nacao_cod_nacao`, `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `role_cadastro_municipio_estado_nacao_cod_nacao1`),
  INDEX `fk_admistrador_role_cadastro1_idx` (`role_cadastro_cod_usuario1` ASC, `role_cadastro_tipo_role_cod_tipoRole1` ASC, `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `role_cadastro_municipio_cod_municipio` ASC, `role_cadastro_municipio_estado_cod_estado` ASC, `role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  CONSTRAINT `fk_admistrador_role_cadastro1`
    FOREIGN KEY (`role_cadastro_cod_usuario1` , `role_cadastro_tipo_role_cod_tipoRole1` , `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_municipio_cod_municipio` , `role_cadastro_municipio_estado_cod_estado` , `role_cadastro_municipio_estado_nacao_cod_nacao` , `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`role_cadastro` (`cod_usuario` , `tipo_role_cod_tipoRole` , `ca﻿dastro_Identificacao_cod_usuario` , `municipio_cod_municipio` , `municipio_estado_cod_estado` , `municipio_estado_nacao_cod_nacao` , `municipio_estado_nacao_nacao_midia_cod_nacao` , `municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`midia_jogador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`midia_jogador` ;

CREATE TABLE IF NOT EXISTS `tcc`.`midia_jogador` (
  `cod_jogador` INT NOT NULL,
  `local_midia` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_jogador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`treino_jogador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`treino_jogador` ;

CREATE TABLE IF NOT EXISTS `tcc`.`treino_jogador` (
  `cod_jogador` INT NOT NULL,
  `cod_treino` INT NULL,
  PRIMARY KEY (`cod_jogador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`Treino`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`Treino` ;

CREATE TABLE IF NOT EXISTS `tcc`.`Treino` (
  `cod_treino` INT NOT NULL,
  `cod_staff` INT NULL,
  `tempo_treino` CHAR(10) NULL,
  `cod_esporte` INT NULL,
  `staff_cod_staff` INT NOT NULL,
  `staff_role_cadastro_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `esporte_cod_esporte` INT NOT NULL,
  `staff_cod_staff1` INT NOT NULL,
  `staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `treino_jogador_cod_jogador` INT NOT NULL,
  PRIMARY KEY (`cod_treino`, `staff_cod_staff`, `staff_role_cadastro_cod_usuario`, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `staff_role_cadastro_tipo_role_cod_tipoRole`, `esporte_cod_esporte`, `staff_cod_staff1`, `staff_role_cadastro_cod_usuario1`, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `staff_role_cadastro_tipo_role_cod_tipoRole1`, `staff_role_cadastro_cod_usuario11`, `staff_role_cadastro_tipo_role_cod_tipoRole11`, `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `staff_role_cadastro_municipio_cod_municipio`, `staff_role_cadastro_municipio_estado_cod_estado`, `staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `treino_jogador_cod_jogador`),
  INDEX `fk_Treino_staff1_idx` (`staff_cod_staff1` ASC, `staff_role_cadastro_cod_usuario1` ASC, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `staff_role_cadastro_cod_usuario11` ASC, `staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `staff_role_cadastro_municipio_cod_municipio` ASC, `staff_role_cadastro_municipio_estado_cod_estado` ASC, `staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  INDEX `fk_Treino_treino_jogador1_idx` (`treino_jogador_cod_jogador` ASC) VISIBLE,
  CONSTRAINT `fk_Treino_staff1`
    FOREIGN KEY (`staff_cod_staff1` , `staff_role_cadastro_cod_usuario1` , `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `staff_role_cadastro_tipo_role_cod_tipoRole1` , `staff_role_cadastro_cod_usuario11` , `staff_role_cadastro_tipo_role_cod_tipoRole11` , `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_municipio_cod_municipio` , `staff_role_cadastro_municipio_estado_cod_estado` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`staff` (`cod_staff` , `role_cadastro_cod_usuario` , `role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_tipo_role_cod_tipoRole` , `role_cadastro_cod_usuario1` , `role_cadastro_tipo_role_cod_tipoRole1` , `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_municipio_cod_municipio` , `role_cadastro_municipio_estado_cod_estado` , `role_cadastro_municipio_estado_nacao_cod_nacao` , `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `role_cadastro_municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treino_treino_jogador1`
    FOREIGN KEY (`treino_jogador_cod_jogador`)
    REFERENCES `tcc`.`treino_jogador` (`cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`esporte`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`esporte` ;

CREATE TABLE IF NOT EXISTS `tcc`.`esporte` (
  `cod_esporte` INT NOT NULL,
  `desc_esporte` VARCHAR(50) NULL,
  `Treino_cod_treino` INT NOT NULL,
  `Treino_staff_cod_staff` INT NOT NULL,
  `Treino_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `Treino_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `Treino_esporte_cod_esporte` INT NOT NULL,
  `Treino_staff_cod_staff1` INT NOT NULL,
  `Treino_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `Treino_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `Treino_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `Treino_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `Treino_treino_jogador_cod_jogador` INT NOT NULL,
  PRIMARY KEY (`cod_esporte`, `Treino_cod_treino`, `Treino_staff_cod_staff`, `Treino_staff_role_cadastro_cod_usuario`, `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole`, `Treino_esporte_cod_esporte`, `Treino_staff_cod_staff1`, `Treino_staff_role_cadastro_cod_usuario1`, `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1`, `Treino_staff_role_cadastro_cod_usuario11`, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11`, `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `Treino_staff_role_cadastro_municipio_cod_municipio`, `Treino_staff_role_cadastro_municipio_estado_cod_estado`, `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `Treino_treino_jogador_cod_jogador`),
  INDEX `fk_esporte_Treino1_idx` (`Treino_cod_treino` ASC, `Treino_staff_cod_staff` ASC, `Treino_staff_role_cadastro_cod_usuario` ASC, `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `Treino_esporte_cod_esporte` ASC, `Treino_staff_cod_staff1` ASC, `Treino_staff_role_cadastro_cod_usuario1` ASC, `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `Treino_staff_role_cadastro_cod_usuario11` ASC, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `Treino_staff_role_cadastro_municipio_cod_municipio` ASC, `Treino_staff_role_cadastro_municipio_estado_cod_estado` ASC, `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC, `Treino_treino_jogador_cod_jogador` ASC) VISIBLE,
  CONSTRAINT `fk_esporte_Treino1`
    FOREIGN KEY (`Treino_cod_treino` , `Treino_staff_cod_staff` , `Treino_staff_role_cadastro_cod_usuario` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `Treino_esporte_cod_esporte` , `Treino_staff_cod_staff1` , `Treino_staff_role_cadastro_cod_usuario1` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `Treino_staff_role_cadastro_cod_usuario11` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_municipio_cod_municipio` , `Treino_staff_role_cadastro_municipio_estado_cod_estado` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `Treino_treino_jogador_cod_jogador`)
    REFERENCES `tcc`.`Treino` (`cod_treino` , `staff_cod_staff` , `staff_role_cadastro_cod_usuario` , `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_tipo_role_cod_tipoRole` , `esporte_cod_esporte` , `staff_cod_staff1` , `staff_role_cadastro_cod_usuario1` , `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `staff_role_cadastro_tipo_role_cod_tipoRole1` , `staff_role_cadastro_cod_usuario11` , `staff_role_cadastro_tipo_role_cod_tipoRole11` , `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_municipio_cod_municipio` , `staff_role_cadastro_municipio_estado_cod_estado` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `treino_jogador_cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`posicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`posicao` ;

CREATE TABLE IF NOT EXISTS `tcc`.`posicao` (
  `cod_posicao` INT NOT NULL,
  `cod_esporte` INT NULL,
  `desc_posicao` VARCHAR(100) NULL,
  `sigla_posicao` CHAR(5) NULL,
  `esporte_cod_esporte` INT NOT NULL,
  `esporte_Treino_cod_treino` INT NOT NULL,
  `esporte_Treino_staff_cod_staff` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `esporte_Treino_esporte_cod_esporte` INT NOT NULL,
  `esporte_Treino_staff_cod_staff1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `esporte_Treino_treino_jogador_cod_jogador` INT NOT NULL,
  PRIMARY KEY (`cod_posicao`, `esporte_cod_esporte`, `esporte_Treino_cod_treino`, `esporte_Treino_staff_cod_staff`, `esporte_Treino_staff_role_cadastro_cod_usuario`, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole`, `esporte_Treino_esporte_cod_esporte`, `esporte_Treino_staff_cod_staff1`, `esporte_Treino_staff_role_cadastro_cod_usuario1`, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1`, `esporte_Treino_staff_role_cadastro_cod_usuario11`, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11`, `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `esporte_Treino_staff_role_cadastro_municipio_cod_municipio`, `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado`, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `esporte_Treino_treino_jogador_cod_jogador`),
  INDEX `fk_posicao_esporte1_idx` (`esporte_cod_esporte` ASC, `esporte_Treino_cod_treino` ASC, `esporte_Treino_staff_cod_staff` ASC, `esporte_Treino_staff_role_cadastro_cod_usuario` ASC, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `esporte_Treino_esporte_cod_esporte` ASC, `esporte_Treino_staff_cod_staff1` ASC, `esporte_Treino_staff_role_cadastro_cod_usuario1` ASC, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `esporte_Treino_staff_role_cadastro_cod_usuario11` ASC, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC, `esporte_Treino_treino_jogador_cod_jogador` ASC) VISIBLE,
  CONSTRAINT `fk_posicao_esporte1`
    FOREIGN KEY (`esporte_cod_esporte` , `esporte_Treino_cod_treino` , `esporte_Treino_staff_cod_staff` , `esporte_Treino_staff_role_cadastro_cod_usuario` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `esporte_Treino_esporte_cod_esporte` , `esporte_Treino_staff_cod_staff1` , `esporte_Treino_staff_role_cadastro_cod_usuario1` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `esporte_Treino_staff_role_cadastro_cod_usuario11` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `esporte_Treino_treino_jogador_cod_jogador`)
    REFERENCES `tcc`.`esporte` (`cod_esporte` , `Treino_cod_treino` , `Treino_staff_cod_staff` , `Treino_staff_role_cadastro_cod_usuario` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `Treino_esporte_cod_esporte` , `Treino_staff_cod_staff1` , `Treino_staff_role_cadastro_cod_usuario1` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `Treino_staff_role_cadastro_cod_usuario11` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_municipio_cod_municipio` , `Treino_staff_role_cadastro_municipio_estado_cod_estado` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `Treino_treino_jogador_cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`fichaMedica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`fichaMedica` ;

CREATE TABLE IF NOT EXISTS `tcc`.`fichaMedica` (
  `cod_jogador` INT NOT NULL,
  `altura` CHAR(3) NULL,
  `peso` CHAR(3) NULL,
  `tipoSanguineo` VARCHAR(3) NULL,
  `restricoes_medicas` VARCHAR(100) NULL,
  `alergias` VARCHAR(100) NULL,
  `data_atualizacao` DATETIME NULL,
  PRIMARY KEY (`cod_jogador`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`jogador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`jogador` ;

CREATE TABLE IF NOT EXISTS `tcc`.`jogador` (
  `cod_jogador` INT NOT NULL,
  `tipo_role` INT NULL,
  `ativo` CHAR(1) NULL,
  `data_nascimento` DATE NULL,
  `posicao` INT NULL,
  `esporte` INT NULL,
  `midia_jogador_cod_jogador` INT NOT NULL,
  `treino_jogador_cod_jogador` INT NOT NULL,
  `posicao_cod_posicao` INT NOT NULL,
  `posicao_esporte_cod_esporte` INT NOT NULL,
  `posicao_esporte_Treino_cod_treino` INT NOT NULL,
  `posicao_esporte_Treino_staff_cod_staff` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `posicao_esporte_Treino_esporte_cod_esporte` INT NOT NULL,
  `posicao_esporte_Treino_staff_cod_staff1` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `posicao_esporte_Treino_treino_jogador_cod_jogador` INT NOT NULL,
  `esporte_cod_esporte` INT NOT NULL,
  `esporte_Treino_cod_treino` INT NOT NULL,
  `esporte_Treino_staff_cod_staff` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `esporte_Treino_esporte_cod_esporte` INT NOT NULL,
  `esporte_Treino_staff_cod_staff1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `esporte_Treino_treino_jogador_cod_jogador` INT NOT NULL,
  `fichaMedica_cod_jogador` INT NOT NULL,
  `role_cadastro_cod_usuario` INT NOT NULL,
  `role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_jogador`, `midia_jogador_cod_jogador`, `treino_jogador_cod_jogador`, `posicao_cod_posicao`, `posicao_esporte_cod_esporte`, `posicao_esporte_Treino_cod_treino`, `posicao_esporte_Treino_staff_cod_staff`, `posicao_esporte_Treino_staff_role_cadastro_cod_usuario`, `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole`, `posicao_esporte_Treino_esporte_cod_esporte`, `posicao_esporte_Treino_staff_cod_staff1`, `posicao_esporte_Treino_staff_role_cadastro_cod_usuario1`, `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1`, `posicao_esporte_Treino_staff_role_cadastro_cod_usuario11`, `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11`, `posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio`, `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado`, `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `posicao_esporte_Treino_treino_jogador_cod_jogador`, `esporte_cod_esporte`, `esporte_Treino_cod_treino`, `esporte_Treino_staff_cod_staff`, `esporte_Treino_staff_role_cadastro_cod_usuario`, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole`, `esporte_Treino_esporte_cod_esporte`, `esporte_Treino_staff_cod_staff1`, `esporte_Treino_staff_role_cadastro_cod_usuario1`, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1`, `esporte_Treino_staff_role_cadastro_cod_usuario11`, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11`, `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `esporte_Treino_staff_role_cadastro_municipio_cod_municipio`, `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado`, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `esporte_Treino_treino_jogador_cod_jogador`, `fichaMedica_cod_jogador`, `role_cadastro_cod_usuario`, `role_cadastro_tipo_role_cod_tipoRole`, `role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `role_cadastro_municipio_cod_municipio`, `role_cadastro_municipio_estado_cod_estado`, `role_cadastro_municipio_estado_nacao_cod_nacao`, `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `role_cadastro_municipio_estado_nacao_cod_nacao1`),
  INDEX `fk_jogador_midia_jogador1_idx` (`midia_jogador_cod_jogador` ASC) VISIBLE,
  INDEX `fk_jogador_treino_jogador1_idx` (`treino_jogador_cod_jogador` ASC) VISIBLE,
  INDEX `fk_jogador_posicao1_idx` (`posicao_cod_posicao` ASC, `posicao_esporte_cod_esporte` ASC, `posicao_esporte_Treino_cod_treino` ASC, `posicao_esporte_Treino_staff_cod_staff` ASC, `posicao_esporte_Treino_staff_role_cadastro_cod_usuario` ASC, `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `posicao_esporte_Treino_esporte_cod_esporte` ASC, `posicao_esporte_Treino_staff_cod_staff1` ASC, `posicao_esporte_Treino_staff_role_cadastro_cod_usuario1` ASC, `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `posicao_esporte_Treino_staff_role_cadastro_cod_usuario11` ASC, `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` ASC, `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` ASC, `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC, `posicao_esporte_Treino_treino_jogador_cod_jogador` ASC) VISIBLE,
  INDEX `fk_jogador_esporte1_idx` (`esporte_cod_esporte` ASC, `esporte_Treino_cod_treino` ASC, `esporte_Treino_staff_cod_staff` ASC, `esporte_Treino_staff_role_cadastro_cod_usuario` ASC, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `esporte_Treino_esporte_cod_esporte` ASC, `esporte_Treino_staff_cod_staff1` ASC, `esporte_Treino_staff_role_cadastro_cod_usuario1` ASC, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `esporte_Treino_staff_role_cadastro_cod_usuario11` ASC, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC, `esporte_Treino_treino_jogador_cod_jogador` ASC) VISIBLE,
  INDEX `fk_jogador_fichaMedica1_idx` (`fichaMedica_cod_jogador` ASC) VISIBLE,
  INDEX `fk_jogador_role_cadastro1_idx` (`role_cadastro_cod_usuario` ASC, `role_cadastro_tipo_role_cod_tipoRole` ASC, `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `role_cadastro_municipio_cod_municipio` ASC, `role_cadastro_municipio_estado_cod_estado` ASC, `role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  CONSTRAINT `fk_jogador_midia_jogador1`
    FOREIGN KEY (`midia_jogador_cod_jogador`)
    REFERENCES `tcc`.`midia_jogador` (`cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_treino_jogador1`
    FOREIGN KEY (`treino_jogador_cod_jogador`)
    REFERENCES `tcc`.`treino_jogador` (`cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_posicao1`
    FOREIGN KEY (`posicao_cod_posicao` , `posicao_esporte_cod_esporte` , `posicao_esporte_Treino_cod_treino` , `posicao_esporte_Treino_staff_cod_staff` , `posicao_esporte_Treino_staff_role_cadastro_cod_usuario` , `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `posicao_esporte_Treino_esporte_cod_esporte` , `posicao_esporte_Treino_staff_cod_staff1` , `posicao_esporte_Treino_staff_role_cadastro_cod_usuario1` , `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `posicao_esporte_Treino_staff_role_cadastro_cod_usuario11` , `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `posicao_esporte_Treino_treino_jogador_cod_jogador`)
    REFERENCES `tcc`.`posicao` (`cod_posicao` , `esporte_cod_esporte` , `esporte_Treino_cod_treino` , `esporte_Treino_staff_cod_staff` , `esporte_Treino_staff_role_cadastro_cod_usuario` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `esporte_Treino_esporte_cod_esporte` , `esporte_Treino_staff_cod_staff1` , `esporte_Treino_staff_role_cadastro_cod_usuario1` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `esporte_Treino_staff_role_cadastro_cod_usuario11` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `esporte_Treino_treino_jogador_cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_esporte1`
    FOREIGN KEY (`esporte_cod_esporte` , `esporte_Treino_cod_treino` , `esporte_Treino_staff_cod_staff` , `esporte_Treino_staff_role_cadastro_cod_usuario` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `esporte_Treino_esporte_cod_esporte` , `esporte_Treino_staff_cod_staff1` , `esporte_Treino_staff_role_cadastro_cod_usuario1` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `esporte_Treino_staff_role_cadastro_cod_usuario11` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `esporte_Treino_treino_jogador_cod_jogador`)
    REFERENCES `tcc`.`esporte` (`cod_esporte` , `Treino_cod_treino` , `Treino_staff_cod_staff` , `Treino_staff_role_cadastro_cod_usuario` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `Treino_esporte_cod_esporte` , `Treino_staff_cod_staff1` , `Treino_staff_role_cadastro_cod_usuario1` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `Treino_staff_role_cadastro_cod_usuario11` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_municipio_cod_municipio` , `Treino_staff_role_cadastro_municipio_estado_cod_estado` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `Treino_treino_jogador_cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_fichaMedica1`
    FOREIGN KEY (`fichaMedica_cod_jogador`)
    REFERENCES `tcc`.`fichaMedica` (`cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_role_cadastro1`
    FOREIGN KEY (`role_cadastro_cod_usuario` , `role_cadastro_tipo_role_cod_tipoRole` , `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_municipio_cod_municipio` , `role_cadastro_municipio_estado_cod_estado` , `role_cadastro_municipio_estado_nacao_cod_nacao` , `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`role_cadastro` (`cod_usuario` , `tipo_role_cod_tipoRole` , `ca﻿dastro_Identificacao_cod_usuario` , `municipio_cod_municipio` , `municipio_estado_cod_estado` , `municipio_estado_nacao_cod_nacao` , `municipio_estado_nacao_nacao_midia_cod_nacao` , `municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`nota_jogador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`nota_jogador` ;

CREATE TABLE IF NOT EXISTS `tcc`.`nota_jogador` (
  `cod_notaJogador` INT NOT NULL,
  `cod_jogador` INT NULL,
  `cod_staff` VARCHAR(45) NULL,
  `ativo` CHAR(1) NULL,
  `nota_jogador` CHAR(3) NULL,
  `staff_cod_staff` INT NOT NULL,
  `staff_role_cadastro_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `jogador_cod_jogador` INT NOT NULL,
  PRIMARY KEY (`cod_notaJogador`, `staff_cod_staff`, `staff_role_cadastro_cod_usuario`, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `staff_role_cadastro_tipo_role_cod_tipoRole`, `staff_role_cadastro_cod_usuario1`, `staff_role_cadastro_tipo_role_cod_tipoRole1`, `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `staff_role_cadastro_municipio_cod_municipio`, `staff_role_cadastro_municipio_estado_cod_estado`, `staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `jogador_cod_jogador`),
  INDEX `fk_nota_jogador_staff1_idx` (`staff_cod_staff` ASC, `staff_role_cadastro_cod_usuario` ASC, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `staff_role_cadastro_cod_usuario1` ASC, `staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `staff_role_cadastro_municipio_cod_municipio` ASC, `staff_role_cadastro_municipio_estado_cod_estado` ASC, `staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  INDEX `fk_nota_jogador_jogador1_idx` (`jogador_cod_jogador` ASC) VISIBLE,
  CONSTRAINT `fk_nota_jogador_staff1`
    FOREIGN KEY (`staff_cod_staff` , `staff_role_cadastro_cod_usuario` , `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_tipo_role_cod_tipoRole` , `staff_role_cadastro_cod_usuario1` , `staff_role_cadastro_tipo_role_cod_tipoRole1` , `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_municipio_cod_municipio` , `staff_role_cadastro_municipio_estado_cod_estado` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`staff` (`cod_staff` , `role_cadastro_cod_usuario` , `role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_tipo_role_cod_tipoRole` , `role_cadastro_cod_usuario1` , `role_cadastro_tipo_role_cod_tipoRole1` , `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_municipio_cod_municipio` , `role_cadastro_municipio_estado_cod_estado` , `role_cadastro_municipio_estado_nacao_cod_nacao` , `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `role_cadastro_municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_jogador_jogador1`
    FOREIGN KEY (`jogador_cod_jogador`)
    REFERENCES `tcc`.`jogador` (`cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`tipo_instituicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`tipo_instituicao` ;

CREATE TABLE IF NOT EXISTS `tcc`.`tipo_instituicao` (
  `cod_tipoInstituicao` INT NOT NULL,
  `desc_tipoInstituicao` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_tipoInstituicao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`instituicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`instituicao` ;

CREATE TABLE IF NOT EXISTS `tcc`.`instituicao` (
  `cod_instituicao` INT NOT NULL,
  `desc_instituicao` VARCHAR(100) NULL,
  `ativo` CHAR(1) NULL,
  `cod_tipoInstituicao` INT NULL,
  `instituicaocol` VARCHAR(45) NULL,
  `tipo_instituicao_cod_tipoInstituicao` INT NOT NULL,
  PRIMARY KEY (`cod_instituicao`, `tipo_instituicao_cod_tipoInstituicao`),
  INDEX `fk_instituicao_tipo_instituicao1_idx` (`tipo_instituicao_cod_tipoInstituicao` ASC) VISIBLE,
  CONSTRAINT `fk_instituicao_tipo_instituicao1`
    FOREIGN KEY (`tipo_instituicao_cod_tipoInstituicao`)
    REFERENCES `tcc`.`tipo_instituicao` (`cod_tipoInstituicao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`admistrador_instituicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`admistrador_instituicao` ;

CREATE TABLE IF NOT EXISTS `tcc`.`admistrador_instituicao` (
  `cod_admistrador` INT NOT NULL,
  `cod_instituicao` INT NULL,
  `admistrador_cod_admistrador` INT NOT NULL,
  `admistrador_role_cadastro_cod_usuario` INT NOT NULL,
  `admistrador_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `admistrador_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `admistrador_role_cadastro_cod_usuario1` INT NOT NULL,
  `admistrador_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `admistrador_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `admistrador_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `admistrador_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `admistrador_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `instituicao_cod_instituicao` INT NOT NULL,
  PRIMARY KEY (`cod_admistrador`, `admistrador_cod_admistrador`, `admistrador_role_cadastro_cod_usuario`, `admistrador_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `admistrador_role_cadastro_tipo_role_cod_tipoRole`, `admistrador_role_cadastro_cod_usuario1`, `admistrador_role_cadastro_tipo_role_cod_tipoRole1`, `admistrador_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `admistrador_role_cadastro_municipio_cod_municipio`, `admistrador_role_cadastro_municipio_estado_cod_estado`, `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao`, `admistrador_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao1`, `instituicao_cod_instituicao`),
  INDEX `fk_admistrador_instituicao_admistrador1_idx` (`admistrador_cod_admistrador` ASC, `admistrador_role_cadastro_cod_usuario` ASC, `admistrador_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `admistrador_role_cadastro_tipo_role_cod_tipoRole` ASC, `admistrador_role_cadastro_cod_usuario1` ASC, `admistrador_role_cadastro_tipo_role_cod_tipoRole1` ASC, `admistrador_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `admistrador_role_cadastro_municipio_cod_municipio` ASC, `admistrador_role_cadastro_municipio_estado_cod_estado` ASC, `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `admistrador_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  INDEX `fk_admistrador_instituicao_instituicao1_idx` (`instituicao_cod_instituicao` ASC) VISIBLE,
  CONSTRAINT `fk_admistrador_instituicao_admistrador1`
    FOREIGN KEY (`admistrador_cod_admistrador` , `admistrador_role_cadastro_cod_usuario` , `admistrador_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `admistrador_role_cadastro_tipo_role_cod_tipoRole` , `admistrador_role_cadastro_cod_usuario1` , `admistrador_role_cadastro_tipo_role_cod_tipoRole1` , `admistrador_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `admistrador_role_cadastro_municipio_cod_municipio` , `admistrador_role_cadastro_municipio_estado_cod_estado` , `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao` , `admistrador_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`admistrador` (`cod_admistrador` , `role_cadastro_cod_usuario` , `role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_tipo_role_cod_tipoRole` , `role_cadastro_cod_usuario1` , `role_cadastro_tipo_role_cod_tipoRole1` , `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_municipio_cod_municipio` , `role_cadastro_municipio_estado_cod_estado` , `role_cadastro_municipio_estado_nacao_cod_nacao` , `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `role_cadastro_municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_admistrador_instituicao_instituicao1`
    FOREIGN KEY (`instituicao_cod_instituicao`)
    REFERENCES `tcc`.`instituicao` (`cod_instituicao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`subInstituicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`subInstituicao` ;

CREATE TABLE IF NOT EXISTS `tcc`.`subInstituicao` (
  `cod_instituicao` INT NOT NULL,
  `cod_subInstituicao` INT NULL,
  `ativo` CHAR(1) NULL,
  `desc_subInstituicao` VARCHAR(100) NULL,
  `cod_municipio` INT NULL,
  `cod_estado` SMALLINT NULL,
  `cod_nacao` SMALLINT NULL,
  `instituicao_cod_instituicao` INT NOT NULL,
  `instituicao_tipo_instituicao_cod_tipoInstituicao` INT NOT NULL,
  `municipio_cod_municipio` INT NOT NULL,
  `municipio_estado_cod_estado` SMALLINT NOT NULL,
  `municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `instituicao_cod_instituicao1` INT NOT NULL,
  `instituicao_tipo_instituicao_cod_tipoInstituicao1` INT NOT NULL,
  `municipio_cod_municipio1` INT NOT NULL,
  `municipio_estado_cod_estado1` SMALLINT NOT NULL,
  `municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `municipio_estado_nacao_nacao_midia_cod_nacao1` INT NOT NULL,
  `municipio_estado_nacao_cod_nacao11` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_instituicao`, `instituicao_cod_instituicao`, `instituicao_tipo_instituicao_cod_tipoInstituicao`, `municipio_cod_municipio`, `municipio_estado_cod_estado`, `municipio_estado_nacao_cod_nacao`, `municipio_estado_nacao_nacao_midia_cod_nacao`, `instituicao_cod_instituicao1`, `instituicao_tipo_instituicao_cod_tipoInstituicao1`, `municipio_cod_municipio1`, `municipio_estado_cod_estado1`, `municipio_estado_nacao_cod_nacao1`, `municipio_estado_nacao_nacao_midia_cod_nacao1`, `municipio_estado_nacao_cod_nacao11`),
  INDEX `fk_subInstituicao_instituicao1_idx` (`instituicao_cod_instituicao1` ASC, `instituicao_tipo_instituicao_cod_tipoInstituicao1` ASC) VISIBLE,
  INDEX `fk_subInstituicao_municipio1_idx` (`municipio_cod_municipio1` ASC, `municipio_estado_cod_estado1` ASC, `municipio_estado_nacao_cod_nacao1` ASC, `municipio_estado_nacao_nacao_midia_cod_nacao1` ASC, `municipio_estado_nacao_cod_nacao11` ASC) VISIBLE,
  CONSTRAINT `fk_subInstituicao_instituicao1`
    FOREIGN KEY (`instituicao_cod_instituicao1` , `instituicao_tipo_instituicao_cod_tipoInstituicao1`)
    REFERENCES `tcc`.`instituicao` (`cod_instituicao` , `tipo_instituicao_cod_tipoInstituicao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subInstituicao_municipio1`
    FOREIGN KEY (`municipio_cod_municipio1` , `municipio_estado_cod_estado1` , `municipio_estado_nacao_cod_nacao1` , `municipio_estado_nacao_nacao_midia_cod_nacao1` , `municipio_estado_nacao_cod_nacao11`)
    REFERENCES `tcc`.`municipio` (`cod_municipio` , `estado_cod_estado` , `estado_nacao_cod_nacao` , `estado_nacao_nacao_midia_cod_nacao` , `estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`subInstituto_staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`subInstituto_staff` ;

CREATE TABLE IF NOT EXISTS `tcc`.`subInstituto_staff` (
  `cod_staff` INT NOT NULL,
  `cod_instituto` INT NULL,
  `cod_subInstituto` INT NULL,
  `staff_cod_staff` INT NOT NULL,
  `staff_role_cadastro_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `subInstituicao_cod_instituicao` INT NOT NULL,
  `subInstituicao_instituicao_cod_instituicao` INT NOT NULL,
  `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` INT NOT NULL,
  `subInstituicao_municipio_cod_municipio` INT NOT NULL,
  `subInstituicao_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `subInstituicao_instituicao_cod_instituicao1` INT NOT NULL,
  `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` INT NOT NULL,
  `subInstituicao_municipio_cod_municipio1` INT NOT NULL,
  `subInstituicao_municipio_estado_cod_estado1` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` INT NOT NULL,
  `subInstituicao_municipio_estado_nacao_cod_nacao11` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_staff`, `staff_cod_staff`, `staff_role_cadastro_cod_usuario`, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `staff_role_cadastro_tipo_role_cod_tipoRole`, `staff_role_cadastro_cod_usuario1`, `staff_role_cadastro_tipo_role_cod_tipoRole1`, `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `staff_role_cadastro_municipio_cod_municipio`, `staff_role_cadastro_municipio_estado_cod_estado`, `staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `subInstituicao_cod_instituicao`, `subInstituicao_instituicao_cod_instituicao`, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao`, `subInstituicao_municipio_cod_municipio`, `subInstituicao_municipio_estado_cod_estado`, `subInstituicao_municipio_estado_nacao_cod_nacao`, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao`, `subInstituicao_instituicao_cod_instituicao1`, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1`, `subInstituicao_municipio_cod_municipio1`, `subInstituicao_municipio_estado_cod_estado1`, `subInstituicao_municipio_estado_nacao_cod_nacao1`, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1`, `subInstituicao_municipio_estado_nacao_cod_nacao11`),
  INDEX `fk_subInstituto_staff_staff1_idx` (`staff_cod_staff` ASC, `staff_role_cadastro_cod_usuario` ASC, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `staff_role_cadastro_cod_usuario1` ASC, `staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `staff_role_cadastro_municipio_cod_municipio` ASC, `staff_role_cadastro_municipio_estado_cod_estado` ASC, `staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  INDEX `fk_subInstituto_staff_subInstituicao1_idx` (`subInstituicao_cod_instituicao` ASC, `subInstituicao_instituicao_cod_instituicao` ASC, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` ASC, `subInstituicao_municipio_cod_municipio` ASC, `subInstituicao_municipio_estado_cod_estado` ASC, `subInstituicao_municipio_estado_nacao_cod_nacao` ASC, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `subInstituicao_instituicao_cod_instituicao1` ASC, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` ASC, `subInstituicao_municipio_cod_municipio1` ASC, `subInstituicao_municipio_estado_cod_estado1` ASC, `subInstituicao_municipio_estado_nacao_cod_nacao1` ASC, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` ASC, `subInstituicao_municipio_estado_nacao_cod_nacao11` ASC) VISIBLE,
  CONSTRAINT `fk_subInstituto_staff_staff1`
    FOREIGN KEY (`staff_cod_staff` , `staff_role_cadastro_cod_usuario` , `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_tipo_role_cod_tipoRole` , `staff_role_cadastro_cod_usuario1` , `staff_role_cadastro_tipo_role_cod_tipoRole1` , `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_municipio_cod_municipio` , `staff_role_cadastro_municipio_estado_cod_estado` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`staff` (`cod_staff` , `role_cadastro_cod_usuario` , `role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_tipo_role_cod_tipoRole` , `role_cadastro_cod_usuario1` , `role_cadastro_tipo_role_cod_tipoRole1` , `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_municipio_cod_municipio` , `role_cadastro_municipio_estado_cod_estado` , `role_cadastro_municipio_estado_nacao_cod_nacao` , `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `role_cadastro_municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_subInstituto_staff_subInstituicao1`
    FOREIGN KEY (`subInstituicao_cod_instituicao` , `subInstituicao_instituicao_cod_instituicao` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` , `subInstituicao_municipio_cod_municipio` , `subInstituicao_municipio_estado_cod_estado` , `subInstituicao_municipio_estado_nacao_cod_nacao` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` , `subInstituicao_instituicao_cod_instituicao1` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` , `subInstituicao_municipio_cod_municipio1` , `subInstituicao_municipio_estado_cod_estado1` , `subInstituicao_municipio_estado_nacao_cod_nacao1` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` , `subInstituicao_municipio_estado_nacao_cod_nacao11`)
    REFERENCES `tcc`.`subInstituicao` (`cod_instituicao` , `instituicao_cod_instituicao` , `instituicao_tipo_instituicao_cod_tipoInstituicao` , `municipio_cod_municipio` , `municipio_estado_cod_estado` , `municipio_estado_nacao_cod_nacao` , `municipio_estado_nacao_nacao_midia_cod_nacao` , `instituicao_cod_instituicao1` , `instituicao_tipo_instituicao_cod_tipoInstituicao1` , `municipio_cod_municipio1` , `municipio_estado_cod_estado1` , `municipio_estado_nacao_cod_nacao1` , `municipio_estado_nacao_nacao_midia_cod_nacao1` , `municipio_estado_nacao_cod_nacao11`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`admistrador_subInstituto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`admistrador_subInstituto` ;

CREATE TABLE IF NOT EXISTS `tcc`.`admistrador_subInstituto` (
  `cod_admistrador` INT NOT NULL,
  `cod_instituto` VARCHAR(45) NULL,
  `cod_subInstituicao` VARCHAR(45) NULL,
  `admistrador_cod_admistrador` INT NOT NULL,
  `admistrador_role_cadastro_cod_usuario` INT NOT NULL,
  `admistrador_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `admistrador_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `admistrador_role_cadastro_cod_usuario1` INT NOT NULL,
  `admistrador_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `admistrador_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `admistrador_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `admistrador_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `admistrador_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `subInstituicao_cod_instituicao` INT NOT NULL,
  `subInstituicao_instituicao_cod_instituicao` INT NOT NULL,
  `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` INT NOT NULL,
  `subInstituicao_municipio_cod_municipio` INT NOT NULL,
  `subInstituicao_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `subInstituicao_instituicao_cod_instituicao1` INT NOT NULL,
  `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` INT NOT NULL,
  `subInstituicao_municipio_cod_municipio1` INT NOT NULL,
  `subInstituicao_municipio_estado_cod_estado1` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` INT NOT NULL,
  `subInstituicao_municipio_estado_nacao_cod_nacao11` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_admistrador`, `admistrador_cod_admistrador`, `admistrador_role_cadastro_cod_usuario`, `admistrador_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `admistrador_role_cadastro_tipo_role_cod_tipoRole`, `admistrador_role_cadastro_cod_usuario1`, `admistrador_role_cadastro_tipo_role_cod_tipoRole1`, `admistrador_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `admistrador_role_cadastro_municipio_cod_municipio`, `admistrador_role_cadastro_municipio_estado_cod_estado`, `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao`, `admistrador_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao1`, `subInstituicao_cod_instituicao`, `subInstituicao_instituicao_cod_instituicao`, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao`, `subInstituicao_municipio_cod_municipio`, `subInstituicao_municipio_estado_cod_estado`, `subInstituicao_municipio_estado_nacao_cod_nacao`, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao`, `subInstituicao_instituicao_cod_instituicao1`, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1`, `subInstituicao_municipio_cod_municipio1`, `subInstituicao_municipio_estado_cod_estado1`, `subInstituicao_municipio_estado_nacao_cod_nacao1`, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1`, `subInstituicao_municipio_estado_nacao_cod_nacao11`),
  INDEX `fk_admistrador_subInstituto_admistrador1_idx` (`admistrador_cod_admistrador` ASC, `admistrador_role_cadastro_cod_usuario` ASC, `admistrador_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `admistrador_role_cadastro_tipo_role_cod_tipoRole` ASC, `admistrador_role_cadastro_cod_usuario1` ASC, `admistrador_role_cadastro_tipo_role_cod_tipoRole1` ASC, `admistrador_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `admistrador_role_cadastro_municipio_cod_municipio` ASC, `admistrador_role_cadastro_municipio_estado_cod_estado` ASC, `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `admistrador_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  INDEX `fk_admistrador_subInstituto_subInstituicao1_idx` (`subInstituicao_cod_instituicao` ASC, `subInstituicao_instituicao_cod_instituicao` ASC, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` ASC, `subInstituicao_municipio_cod_municipio` ASC, `subInstituicao_municipio_estado_cod_estado` ASC, `subInstituicao_municipio_estado_nacao_cod_nacao` ASC, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `subInstituicao_instituicao_cod_instituicao1` ASC, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` ASC, `subInstituicao_municipio_cod_municipio1` ASC, `subInstituicao_municipio_estado_cod_estado1` ASC, `subInstituicao_municipio_estado_nacao_cod_nacao1` ASC, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` ASC, `subInstituicao_municipio_estado_nacao_cod_nacao11` ASC) VISIBLE,
  CONSTRAINT `fk_admistrador_subInstituto_admistrador1`
    FOREIGN KEY (`admistrador_cod_admistrador` , `admistrador_role_cadastro_cod_usuario` , `admistrador_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `admistrador_role_cadastro_tipo_role_cod_tipoRole` , `admistrador_role_cadastro_cod_usuario1` , `admistrador_role_cadastro_tipo_role_cod_tipoRole1` , `admistrador_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `admistrador_role_cadastro_municipio_cod_municipio` , `admistrador_role_cadastro_municipio_estado_cod_estado` , `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao` , `admistrador_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `admistrador_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`admistrador` (`cod_admistrador` , `role_cadastro_cod_usuario` , `role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_tipo_role_cod_tipoRole` , `role_cadastro_cod_usuario1` , `role_cadastro_tipo_role_cod_tipoRole1` , `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_municipio_cod_municipio` , `role_cadastro_municipio_estado_cod_estado` , `role_cadastro_municipio_estado_nacao_cod_nacao` , `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `role_cadastro_municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_admistrador_subInstituto_subInstituicao1`
    FOREIGN KEY (`subInstituicao_cod_instituicao` , `subInstituicao_instituicao_cod_instituicao` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` , `subInstituicao_municipio_cod_municipio` , `subInstituicao_municipio_estado_cod_estado` , `subInstituicao_municipio_estado_nacao_cod_nacao` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` , `subInstituicao_instituicao_cod_instituicao1` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` , `subInstituicao_municipio_cod_municipio1` , `subInstituicao_municipio_estado_cod_estado1` , `subInstituicao_municipio_estado_nacao_cod_nacao1` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` , `subInstituicao_municipio_estado_nacao_cod_nacao11`)
    REFERENCES `tcc`.`subInstituicao` (`cod_instituicao` , `instituicao_cod_instituicao` , `instituicao_tipo_instituicao_cod_tipoInstituicao` , `municipio_cod_municipio` , `municipio_estado_cod_estado` , `municipio_estado_nacao_cod_nacao` , `municipio_estado_nacao_nacao_midia_cod_nacao` , `instituicao_cod_instituicao1` , `instituicao_tipo_instituicao_cod_tipoInstituicao1` , `municipio_cod_municipio1` , `municipio_estado_cod_estado1` , `municipio_estado_nacao_cod_nacao1` , `municipio_estado_nacao_nacao_midia_cod_nacao1` , `municipio_estado_nacao_cod_nacao11`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`contato_responsavel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`contato_responsavel` ;

CREATE TABLE IF NOT EXISTS `tcc`.`contato_responsavel` (
  `cod_contatoResponsavel` INT NOT NULL,
  `tipoContato` VARCHAR(50) NULL,
  `nomeContato` VARCHAR(50) NULL,
  `tipoFiliacao` VARCHAR(50) NULL,
  `emailResponsavel` VARCHAR(100) NULL,
  `telefoneResponsavel` VARCHAR(9) NULL,
  `ddd` CHAR(2) NULL,
  PRIMARY KEY (`cod_contatoResponsavel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`jogador_contatoResponsavel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`jogador_contatoResponsavel` ;

CREATE TABLE IF NOT EXISTS `tcc`.`jogador_contatoResponsavel` (
  `cod_jogador` INT NOT NULL,
  `cod_contatoResponsavel` VARCHAR(45) NULL,
  `contato_responsavel_cod_contatoResponsavel` INT NOT NULL,
  `jogador_cod_jogador` INT NOT NULL,
  `jogador_midia_jogador_cod_jogador` INT NOT NULL,
  `jogador_treino_jogador_cod_jogador` INT NOT NULL,
  `jogador_posicao_cod_posicao` INT NOT NULL,
  `jogador_posicao_esporte_cod_esporte` INT NOT NULL,
  `jogador_posicao_esporte_Treino_cod_treino` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_cod_staff` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `jogador_posicao_esporte_Treino_esporte_cod_esporte` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_cod_staff1` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `jogador_posicao_esporte_Treino_treino_jogador_cod_jogador` INT NOT NULL,
  `jogador_esporte_cod_esporte` INT NOT NULL,
  `jogador_esporte_Treino_cod_treino` INT NOT NULL,
  `jogador_esporte_Treino_staff_cod_staff` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `jogador_esporte_Treino_esporte_cod_esporte` INT NOT NULL,
  `jogador_esporte_Treino_staff_cod_staff1` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `jogador_esporte_Treino_treino_jogador_cod_jogador` INT NOT NULL,
  `jogador_fichaMedica_cod_jogador` INT NOT NULL,
  PRIMARY KEY (`cod_jogador`, `contato_responsavel_cod_contatoResponsavel`, `jogador_cod_jogador`, `jogador_midia_jogador_cod_jogador`, `jogador_treino_jogador_cod_jogador`, `jogador_posicao_cod_posicao`, `jogador_posicao_esporte_cod_esporte`, `jogador_posicao_esporte_Treino_cod_treino`, `jogador_posicao_esporte_Treino_staff_cod_staff`, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario`, `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole`, `jogador_posicao_esporte_Treino_esporte_cod_esporte`, `jogador_posicao_esporte_Treino_staff_cod_staff1`, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario1`, `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1`, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario11`, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11`, `jogador_posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio`, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado`, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `jogador_posicao_esporte_Treino_treino_jogador_cod_jogador`, `jogador_esporte_cod_esporte`, `jogador_esporte_Treino_cod_treino`, `jogador_esporte_Treino_staff_cod_staff`, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario`, `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole`, `jogador_esporte_Treino_esporte_cod_esporte`, `jogador_esporte_Treino_staff_cod_staff1`, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario1`, `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1`, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario11`, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11`, `jogador_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `jogador_esporte_Treino_staff_role_cadastro_municipio_cod_municipio`, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado`, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `jogador_esporte_Treino_treino_jogador_cod_jogador`, `jogador_fichaMedica_cod_jogador`),
  INDEX `fk_jogador_contatoResponsavel_contato_responsavel1_idx` (`contato_responsavel_cod_contatoResponsavel` ASC) VISIBLE,
  INDEX `fk_jogador_contatoResponsavel_jogador1_idx` (`jogador_cod_jogador` ASC, `jogador_midia_jogador_cod_jogador` ASC, `jogador_treino_jogador_cod_jogador` ASC, `jogador_posicao_cod_posicao` ASC, `jogador_posicao_esporte_cod_esporte` ASC, `jogador_posicao_esporte_Treino_cod_treino` ASC, `jogador_posicao_esporte_Treino_staff_cod_staff` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `jogador_posicao_esporte_Treino_esporte_cod_esporte` ASC, `jogador_posicao_esporte_Treino_staff_cod_staff1` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario1` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario11` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC, `jogador_posicao_esporte_Treino_treino_jogador_cod_jogador` ASC, `jogador_esporte_cod_esporte` ASC, `jogador_esporte_Treino_cod_treino` ASC, `jogador_esporte_Treino_staff_cod_staff` ASC, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario` ASC, `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `jogador_esporte_Treino_esporte_cod_esporte` ASC, `jogador_esporte_Treino_staff_cod_staff1` ASC, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario1` ASC, `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario11` ASC, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `jogador_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `jogador_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` ASC, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` ASC, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC, `jogador_esporte_Treino_treino_jogador_cod_jogador` ASC, `jogador_fichaMedica_cod_jogador` ASC) VISIBLE,
  CONSTRAINT `fk_jogador_contatoResponsavel_contato_responsavel1`
    FOREIGN KEY (`contato_responsavel_cod_contatoResponsavel`)
    REFERENCES `tcc`.`contato_responsavel` (`cod_contatoResponsavel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_contatoResponsavel_jogador1`
    FOREIGN KEY (`jogador_cod_jogador` , `jogador_midia_jogador_cod_jogador` , `jogador_treino_jogador_cod_jogador` , `jogador_posicao_cod_posicao` , `jogador_posicao_esporte_cod_esporte` , `jogador_posicao_esporte_Treino_cod_treino` , `jogador_posicao_esporte_Treino_staff_cod_staff` , `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario` , `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `jogador_posicao_esporte_Treino_esporte_cod_esporte` , `jogador_posicao_esporte_Treino_staff_cod_staff1` , `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario1` , `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario11` , `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `jogador_posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `jogador_posicao_esporte_Treino_treino_jogador_cod_jogador` , `jogador_esporte_cod_esporte` , `jogador_esporte_Treino_cod_treino` , `jogador_esporte_Treino_staff_cod_staff` , `jogador_esporte_Treino_staff_role_cadastro_cod_usuario` , `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `jogador_esporte_Treino_esporte_cod_esporte` , `jogador_esporte_Treino_staff_cod_staff1` , `jogador_esporte_Treino_staff_role_cadastro_cod_usuario1` , `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `jogador_esporte_Treino_staff_role_cadastro_cod_usuario11` , `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `jogador_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `jogador_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `jogador_esporte_Treino_treino_jogador_cod_jogador` , `jogador_fichaMedica_cod_jogador`)
    REFERENCES `tcc`.`jogador` (`cod_jogador` , `midia_jogador_cod_jogador` , `treino_jogador_cod_jogador` , `posicao_cod_posicao` , `posicao_esporte_cod_esporte` , `posicao_esporte_Treino_cod_treino` , `posicao_esporte_Treino_staff_cod_staff` , `posicao_esporte_Treino_staff_role_cadastro_cod_usuario` , `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `posicao_esporte_Treino_esporte_cod_esporte` , `posicao_esporte_Treino_staff_cod_staff1` , `posicao_esporte_Treino_staff_role_cadastro_cod_usuario1` , `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `posicao_esporte_Treino_staff_role_cadastro_cod_usuario11` , `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `posicao_esporte_Treino_treino_jogador_cod_jogador` , `esporte_cod_esporte` , `esporte_Treino_cod_treino` , `esporte_Treino_staff_cod_staff` , `esporte_Treino_staff_role_cadastro_cod_usuario` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `esporte_Treino_esporte_cod_esporte` , `esporte_Treino_staff_cod_staff1` , `esporte_Treino_staff_role_cadastro_cod_usuario1` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `esporte_Treino_staff_role_cadastro_cod_usuario11` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `esporte_Treino_treino_jogador_cod_jogador` , `fichaMedica_cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`tipo_lesao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`tipo_lesao` ;

CREATE TABLE IF NOT EXISTS `tcc`.`tipo_lesao` (
  `cod_tipoLesao` INT NOT NULL,
  `categoria` VARCHAR(100) NULL,
  `tipo_lesao` VARCHAR(100) NULL,
  `desc_lesao` VARCHAR(100) NULL,
  PRIMARY KEY (`cod_tipoLesao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`historicoLesoes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`historicoLesoes` ;

CREATE TABLE IF NOT EXISTS `tcc`.`historicoLesoes` (
  `cod_historicoLesoes` INT NOT NULL,
  `cod_tipoLesao` INT NULL,
  `desc_lesao` VARCHAR(100) NULL,
  `data_lesao` DATE NULL,
  `tempoFora_lesao` VARCHAR(50) NULL,
  `tipo_lesao_cod_tipoLesao` INT NOT NULL,
  PRIMARY KEY (`cod_historicoLesoes`, `tipo_lesao_cod_tipoLesao`),
  INDEX `fk_historicoLesoes_tipo_lesao1_idx` (`tipo_lesao_cod_tipoLesao` ASC) VISIBLE,
  CONSTRAINT `fk_historicoLesoes_tipo_lesao1`
    FOREIGN KEY (`tipo_lesao_cod_tipoLesao`)
    REFERENCES `tcc`.`tipo_lesao` (`cod_tipoLesao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`fichaMedica_historicoLesoes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`fichaMedica_historicoLesoes` ;

CREATE TABLE IF NOT EXISTS `tcc`.`fichaMedica_historicoLesoes` (
  `cod_jogador` INT NOT NULL,
  `cod_historicoLesoes` INT NULL,
  `fichaMedica_historicoLesoescol` VARCHAR(45) NULL,
  `historicoLesoes_cod_historicoLesoes` INT NOT NULL,
  `historicoLesoes_tipo_lesao_cod_tipoLesao` INT NOT NULL,
  `fichaMedica_cod_jogador` INT NOT NULL,
  PRIMARY KEY (`cod_jogador`, `historicoLesoes_cod_historicoLesoes`, `historicoLesoes_tipo_lesao_cod_tipoLesao`, `fichaMedica_cod_jogador`),
  INDEX `fk_fichaMedica_historicoLesoes_historicoLesoes1_idx` (`historicoLesoes_cod_historicoLesoes` ASC, `historicoLesoes_tipo_lesao_cod_tipoLesao` ASC) VISIBLE,
  INDEX `fk_fichaMedica_historicoLesoes_fichaMedica1_idx` (`fichaMedica_cod_jogador` ASC) VISIBLE,
  CONSTRAINT `fk_fichaMedica_historicoLesoes_historicoLesoes1`
    FOREIGN KEY (`historicoLesoes_cod_historicoLesoes` , `historicoLesoes_tipo_lesao_cod_tipoLesao`)
    REFERENCES `tcc`.`historicoLesoes` (`cod_historicoLesoes` , `tipo_lesao_cod_tipoLesao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fichaMedica_historicoLesoes_fichaMedica1`
    FOREIGN KEY (`fichaMedica_cod_jogador`)
    REFERENCES `tcc`.`fichaMedica` (`cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`midia_treino`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`midia_treino` ;

CREATE TABLE IF NOT EXISTS `tcc`.`midia_treino` (
  `cod_midiaTreino` INT NOT NULL,
  `local_midia` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_midiaTreino`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`midia_treino`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`midia_treino` ;

CREATE TABLE IF NOT EXISTS `tcc`.`midia_treino` (
  `cod_midiaTreino` INT NOT NULL,
  `local_midia` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_midiaTreino`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`notaTreino_jogador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`notaTreino_jogador` ;

CREATE TABLE IF NOT EXISTS `tcc`.`notaTreino_jogador` (
  `cod_jogador` INT NOT NULL,
  `cod_treino` INT NULL,
  `minuto_nota` CHAR(10) NULL,
  `desc_notaTreino` VARCHAR(100) NULL,
  `grau_privacidade` INT NULL,
  `Treino_cod_treino` INT NOT NULL,
  `Treino_staff_cod_staff` INT NOT NULL,
  `Treino_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `Treino_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `Treino_esporte_cod_esporte` INT NOT NULL,
  `Treino_staff_cod_staff1` INT NOT NULL,
  `Treino_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `Treino_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `Treino_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `Treino_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `jogador_cod_jogador` INT NOT NULL,
  `jogador_midia_jogador_cod_jogador` INT NOT NULL,
  `jogador_treino_jogador_cod_jogador` INT NOT NULL,
  `jogador_posicao_cod_posicao` INT NOT NULL,
  `jogador_posicao_esporte_cod_esporte` INT NOT NULL,
  `jogador_posicao_esporte_Treino_cod_treino` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_cod_staff` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `jogador_posicao_esporte_Treino_esporte_cod_esporte` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_cod_staff1` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `jogador_posicao_esporte_Treino_treino_jogador_cod_jogador` INT NOT NULL,
  `jogador_esporte_cod_esporte` INT NOT NULL,
  `jogador_esporte_Treino_cod_treino` INT NOT NULL,
  `jogador_esporte_Treino_staff_cod_staff` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `jogador_esporte_Treino_esporte_cod_esporte` INT NOT NULL,
  `jogador_esporte_Treino_staff_cod_staff1` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `jogador_esporte_Treino_treino_jogador_cod_jogador` INT NOT NULL,
  `jogador_fichaMedica_cod_jogador` INT NOT NULL,
  PRIMARY KEY (`cod_jogador`, `Treino_cod_treino`, `Treino_staff_cod_staff`, `Treino_staff_role_cadastro_cod_usuario`, `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole`, `Treino_esporte_cod_esporte`, `Treino_staff_cod_staff1`, `Treino_staff_role_cadastro_cod_usuario1`, `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1`, `Treino_staff_role_cadastro_cod_usuario11`, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11`, `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `Treino_staff_role_cadastro_municipio_cod_municipio`, `Treino_staff_role_cadastro_municipio_estado_cod_estado`, `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `jogador_cod_jogador`, `jogador_midia_jogador_cod_jogador`, `jogador_treino_jogador_cod_jogador`, `jogador_posicao_cod_posicao`, `jogador_posicao_esporte_cod_esporte`, `jogador_posicao_esporte_Treino_cod_treino`, `jogador_posicao_esporte_Treino_staff_cod_staff`, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario`, `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole`, `jogador_posicao_esporte_Treino_esporte_cod_esporte`, `jogador_posicao_esporte_Treino_staff_cod_staff1`, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario1`, `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1`, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario11`, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11`, `jogador_posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio`, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado`, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `jogador_posicao_esporte_Treino_treino_jogador_cod_jogador`, `jogador_esporte_cod_esporte`, `jogador_esporte_Treino_cod_treino`, `jogador_esporte_Treino_staff_cod_staff`, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario`, `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole`, `jogador_esporte_Treino_esporte_cod_esporte`, `jogador_esporte_Treino_staff_cod_staff1`, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario1`, `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1`, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario11`, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11`, `jogador_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `jogador_esporte_Treino_staff_role_cadastro_municipio_cod_municipio`, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado`, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `jogador_esporte_Treino_treino_jogador_cod_jogador`, `jogador_fichaMedica_cod_jogador`),
  INDEX `fk_notaTreino_jogador_Treino1_idx` (`Treino_cod_treino` ASC, `Treino_staff_cod_staff` ASC, `Treino_staff_role_cadastro_cod_usuario` ASC, `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `Treino_esporte_cod_esporte` ASC, `Treino_staff_cod_staff1` ASC, `Treino_staff_role_cadastro_cod_usuario1` ASC, `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `Treino_staff_role_cadastro_cod_usuario11` ASC, `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `Treino_staff_role_cadastro_municipio_cod_municipio` ASC, `Treino_staff_role_cadastro_municipio_estado_cod_estado` ASC, `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  INDEX `fk_notaTreino_jogador_jogador1_idx` (`jogador_cod_jogador` ASC, `jogador_midia_jogador_cod_jogador` ASC, `jogador_treino_jogador_cod_jogador` ASC, `jogador_posicao_cod_posicao` ASC, `jogador_posicao_esporte_cod_esporte` ASC, `jogador_posicao_esporte_Treino_cod_treino` ASC, `jogador_posicao_esporte_Treino_staff_cod_staff` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `jogador_posicao_esporte_Treino_esporte_cod_esporte` ASC, `jogador_posicao_esporte_Treino_staff_cod_staff1` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario1` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario11` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC, `jogador_posicao_esporte_Treino_treino_jogador_cod_jogador` ASC, `jogador_esporte_cod_esporte` ASC, `jogador_esporte_Treino_cod_treino` ASC, `jogador_esporte_Treino_staff_cod_staff` ASC, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario` ASC, `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `jogador_esporte_Treino_esporte_cod_esporte` ASC, `jogador_esporte_Treino_staff_cod_staff1` ASC, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario1` ASC, `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `jogador_esporte_Treino_staff_role_cadastro_cod_usuario11` ASC, `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `jogador_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `jogador_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` ASC, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` ASC, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC, `jogador_esporte_Treino_treino_jogador_cod_jogador` ASC, `jogador_fichaMedica_cod_jogador` ASC) VISIBLE,
  CONSTRAINT `fk_notaTreino_jogador_Treino1`
    FOREIGN KEY (`Treino_cod_treino` , `Treino_staff_cod_staff` , `Treino_staff_role_cadastro_cod_usuario` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `Treino_esporte_cod_esporte` , `Treino_staff_cod_staff1` , `Treino_staff_role_cadastro_cod_usuario1` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `Treino_staff_role_cadastro_cod_usuario11` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_municipio_cod_municipio` , `Treino_staff_role_cadastro_municipio_estado_cod_estado` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`Treino` (`cod_treino` , `staff_cod_staff` , `staff_role_cadastro_cod_usuario` , `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_tipo_role_cod_tipoRole` , `esporte_cod_esporte` , `staff_cod_staff1` , `staff_role_cadastro_cod_usuario1` , `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `staff_role_cadastro_tipo_role_cod_tipoRole1` , `staff_role_cadastro_cod_usuario11` , `staff_role_cadastro_tipo_role_cod_tipoRole11` , `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_municipio_cod_municipio` , `staff_role_cadastro_municipio_estado_cod_estado` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notaTreino_jogador_jogador1`
    FOREIGN KEY (`jogador_cod_jogador` , `jogador_midia_jogador_cod_jogador` , `jogador_treino_jogador_cod_jogador` , `jogador_posicao_cod_posicao` , `jogador_posicao_esporte_cod_esporte` , `jogador_posicao_esporte_Treino_cod_treino` , `jogador_posicao_esporte_Treino_staff_cod_staff` , `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario` , `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `jogador_posicao_esporte_Treino_esporte_cod_esporte` , `jogador_posicao_esporte_Treino_staff_cod_staff1` , `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario1` , `jogador_posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `jogador_posicao_esporte_Treino_staff_role_cadastro_cod_usuario11` , `jogador_posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `jogador_posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `jogador_posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `jogador_posicao_esporte_Treino_treino_jogador_cod_jogador` , `jogador_esporte_cod_esporte` , `jogador_esporte_Treino_cod_treino` , `jogador_esporte_Treino_staff_cod_staff` , `jogador_esporte_Treino_staff_role_cadastro_cod_usuario` , `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `jogador_esporte_Treino_esporte_cod_esporte` , `jogador_esporte_Treino_staff_cod_staff1` , `jogador_esporte_Treino_staff_role_cadastro_cod_usuario1` , `jogador_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `jogador_esporte_Treino_staff_role_cadastro_cod_usuario11` , `jogador_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `jogador_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `jogador_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `jogador_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `jogador_esporte_Treino_treino_jogador_cod_jogador` , `jogador_fichaMedica_cod_jogador`)
    REFERENCES `tcc`.`jogador` (`cod_jogador` , `midia_jogador_cod_jogador` , `treino_jogador_cod_jogador` , `posicao_cod_posicao` , `posicao_esporte_cod_esporte` , `posicao_esporte_Treino_cod_treino` , `posicao_esporte_Treino_staff_cod_staff` , `posicao_esporte_Treino_staff_role_cadastro_cod_usuario` , `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `posicao_esporte_Treino_esporte_cod_esporte` , `posicao_esporte_Treino_staff_cod_staff1` , `posicao_esporte_Treino_staff_role_cadastro_cod_usuario1` , `posicao_esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `posicao_esporte_Treino_staff_role_cadastro_cod_usuario11` , `posicao_esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `posicao_esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `posicao_esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `posicao_esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `posicao_esporte_Treino_treino_jogador_cod_jogador` , `esporte_cod_esporte` , `esporte_Treino_cod_treino` , `esporte_Treino_staff_cod_staff` , `esporte_Treino_staff_role_cadastro_cod_usuario` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `esporte_Treino_esporte_cod_esporte` , `esporte_Treino_staff_cod_staff1` , `esporte_Treino_staff_role_cadastro_cod_usuario1` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `esporte_Treino_staff_role_cadastro_cod_usuario11` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `esporte_Treino_treino_jogador_cod_jogador` , `fichaMedica_cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`grau_privacidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`grau_privacidade` ;

CREATE TABLE IF NOT EXISTS `tcc`.`grau_privacidade` (
  `cod_grauPrivacidade` INT NOT NULL,
  `desc_grauPrivacidade` VARCHAR(50) NULL,
  `notaTreino_jogador_cod_jogador` INT NOT NULL,
  `notaTreino_jogador_Treino_cod_treino` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_cod_staff` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `notaTreino_jogador_Treino_esporte_cod_esporte` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_cod_staff1` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_grauPrivacidade`, `notaTreino_jogador_cod_jogador`, `notaTreino_jogador_Treino_cod_treino`, `notaTreino_jogador_Treino_staff_cod_staff`, `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario`, `notaTreino_jogador_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole`, `notaTreino_jogador_Treino_esporte_cod_esporte`, `notaTreino_jogador_Treino_staff_cod_staff1`, `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario1`, `notaTreino_jogador_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1`, `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario11`, `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11`, `notaTreino_jogador_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `notaTreino_jogador_Treino_staff_role_cadastro_municipio_cod_municipio`, `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_cod_estado`, `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`),
  INDEX `fk_grau_privacidade_notaTreino_jogador1_idx` (`notaTreino_jogador_cod_jogador` ASC, `notaTreino_jogador_Treino_cod_treino` ASC, `notaTreino_jogador_Treino_staff_cod_staff` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `notaTreino_jogador_Treino_esporte_cod_esporte` ASC, `notaTreino_jogador_Treino_staff_cod_staff1` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario1` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario11` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_municipio_cod_municipio` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_cod_estado` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  CONSTRAINT `fk_grau_privacidade_notaTreino_jogador1`
    FOREIGN KEY (`notaTreino_jogador_cod_jogador` , `notaTreino_jogador_Treino_cod_treino` , `notaTreino_jogador_Treino_staff_cod_staff` , `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario` , `notaTreino_jogador_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `notaTreino_jogador_Treino_esporte_cod_esporte` , `notaTreino_jogador_Treino_staff_cod_staff1` , `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario1` , `notaTreino_jogador_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `notaTreino_jogador_Treino_staff_role_cadastro_cod_usuario11` , `notaTreino_jogador_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `notaTreino_jogador_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `notaTreino_jogador_Treino_staff_role_cadastro_municipio_cod_municipio` , `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `notaTreino_jogador_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`notaTreino_jogador` (`cod_jogador` , `Treino_cod_treino` , `Treino_staff_cod_staff` , `Treino_staff_role_cadastro_cod_usuario` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `Treino_esporte_cod_esporte` , `Treino_staff_cod_staff1` , `Treino_staff_role_cadastro_cod_usuario1` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `Treino_staff_role_cadastro_cod_usuario11` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_municipio_cod_municipio` , `Treino_staff_role_cadastro_municipio_estado_cod_estado` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`turma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`turma` ;

CREATE TABLE IF NOT EXISTS `tcc`.`turma` (
  `cod_instituicao` INT NOT NULL,
  `cod_subInstituicao` INT NULL,
  `cod_turma` INT NULL,
  `desc_turma` VARCHAR(50) NULL,
  `ativo` CHAR(1) NULL,
  `subInstituicao_cod_instituicao` INT NOT NULL,
  `subInstituicao_instituicao_cod_instituicao` INT NOT NULL,
  `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` INT NOT NULL,
  `subInstituicao_municipio_cod_municipio` INT NOT NULL,
  `subInstituicao_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `subInstituicao_cod_instituicao1` INT NOT NULL,
  `subInstituicao_instituicao_cod_instituicao1` INT NOT NULL,
  `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` INT NOT NULL,
  `subInstituicao_municipio_cod_municipio1` INT NOT NULL,
  `subInstituicao_municipio_estado_cod_estado1` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` INT NOT NULL,
  `subInstituicao_instituicao_cod_instituicao11` INT NOT NULL,
  `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` INT NOT NULL,
  `subInstituicao_municipio_cod_municipio11` INT NOT NULL,
  `subInstituicao_municipio_estado_cod_estado11` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_cod_nacao11` SMALLINT NOT NULL,
  `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` INT NOT NULL,
  `subInstituicao_municipio_estado_nacao_cod_nacao111` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_instituicao`, `subInstituicao_cod_instituicao`, `subInstituicao_instituicao_cod_instituicao`, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao`, `subInstituicao_municipio_cod_municipio`, `subInstituicao_municipio_estado_cod_estado`, `subInstituicao_municipio_estado_nacao_cod_nacao`, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao`, `subInstituicao_cod_instituicao1`, `subInstituicao_instituicao_cod_instituicao1`, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1`, `subInstituicao_municipio_cod_municipio1`, `subInstituicao_municipio_estado_cod_estado1`, `subInstituicao_municipio_estado_nacao_cod_nacao1`, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1`, `subInstituicao_instituicao_cod_instituicao11`, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11`, `subInstituicao_municipio_cod_municipio11`, `subInstituicao_municipio_estado_cod_estado11`, `subInstituicao_municipio_estado_nacao_cod_nacao11`, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11`, `subInstituicao_municipio_estado_nacao_cod_nacao111`),
  INDEX `fk_turma_subInstituicao1_idx` (`subInstituicao_cod_instituicao1` ASC, `subInstituicao_instituicao_cod_instituicao1` ASC, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` ASC, `subInstituicao_municipio_cod_municipio1` ASC, `subInstituicao_municipio_estado_cod_estado1` ASC, `subInstituicao_municipio_estado_nacao_cod_nacao1` ASC, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` ASC, `subInstituicao_instituicao_cod_instituicao11` ASC, `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` ASC, `subInstituicao_municipio_cod_municipio11` ASC, `subInstituicao_municipio_estado_cod_estado11` ASC, `subInstituicao_municipio_estado_nacao_cod_nacao11` ASC, `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` ASC, `subInstituicao_municipio_estado_nacao_cod_nacao111` ASC) VISIBLE,
  CONSTRAINT `fk_turma_subInstituicao1`
    FOREIGN KEY (`subInstituicao_cod_instituicao1` , `subInstituicao_instituicao_cod_instituicao1` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` , `subInstituicao_municipio_cod_municipio1` , `subInstituicao_municipio_estado_cod_estado1` , `subInstituicao_municipio_estado_nacao_cod_nacao1` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` , `subInstituicao_instituicao_cod_instituicao11` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` , `subInstituicao_municipio_cod_municipio11` , `subInstituicao_municipio_estado_cod_estado11` , `subInstituicao_municipio_estado_nacao_cod_nacao11` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` , `subInstituicao_municipio_estado_nacao_cod_nacao111`)
    REFERENCES `tcc`.`subInstituicao` (`cod_instituicao` , `instituicao_cod_instituicao` , `instituicao_tipo_instituicao_cod_tipoInstituicao` , `municipio_cod_municipio` , `municipio_estado_cod_estado` , `municipio_estado_nacao_cod_nacao` , `municipio_estado_nacao_nacao_midia_cod_nacao` , `instituicao_cod_instituicao1` , `instituicao_tipo_instituicao_cod_tipoInstituicao1` , `municipio_cod_municipio1` , `municipio_estado_cod_estado1` , `municipio_estado_nacao_cod_nacao1` , `municipio_estado_nacao_nacao_midia_cod_nacao1` , `municipio_estado_nacao_cod_nacao11`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`turma_jogador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`turma_jogador` ;

CREATE TABLE IF NOT EXISTS `tcc`.`turma_jogador` (
  `cod_turma` INT NOT NULL,
  `cod_usuario` INT NULL,
  `turma_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `turma_subInstituicao_cod_instituicao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio1` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado1` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao11` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio11` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado11` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao111` SMALLINT NOT NULL,
  `jogador_cod_jogador` INT NOT NULL,
  PRIMARY KEY (`cod_turma`, `turma_cod_instituicao`, `turma_subInstituicao_cod_instituicao`, `turma_subInstituicao_instituicao_cod_instituicao`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao`, `turma_subInstituicao_municipio_cod_municipio`, `turma_subInstituicao_municipio_estado_cod_estado`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao`, `turma_subInstituicao_cod_instituicao1`, `turma_subInstituicao_instituicao_cod_instituicao1`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1`, `turma_subInstituicao_municipio_cod_municipio1`, `turma_subInstituicao_municipio_estado_cod_estado1`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao1`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1`, `turma_subInstituicao_instituicao_cod_instituicao11`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11`, `turma_subInstituicao_municipio_cod_municipio11`, `turma_subInstituicao_municipio_estado_cod_estado11`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao11`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao111`, `jogador_cod_jogador`),
  INDEX `fk_turma_jogador_turma1_idx` (`turma_cod_instituicao` ASC, `turma_subInstituicao_cod_instituicao` ASC, `turma_subInstituicao_instituicao_cod_instituicao` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` ASC, `turma_subInstituicao_municipio_cod_municipio` ASC, `turma_subInstituicao_municipio_estado_cod_estado` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `turma_subInstituicao_cod_instituicao1` ASC, `turma_subInstituicao_instituicao_cod_instituicao1` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` ASC, `turma_subInstituicao_municipio_cod_municipio1` ASC, `turma_subInstituicao_municipio_estado_cod_estado1` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` ASC, `turma_subInstituicao_instituicao_cod_instituicao11` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` ASC, `turma_subInstituicao_municipio_cod_municipio11` ASC, `turma_subInstituicao_municipio_estado_cod_estado11` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao111` ASC) VISIBLE,
  INDEX `fk_turma_jogador_jogador1_idx` (`jogador_cod_jogador` ASC) VISIBLE,
  CONSTRAINT `fk_turma_jogador_turma1`
    FOREIGN KEY (`turma_cod_instituicao` , `turma_subInstituicao_cod_instituicao` , `turma_subInstituicao_instituicao_cod_instituicao` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` , `turma_subInstituicao_municipio_cod_municipio` , `turma_subInstituicao_municipio_estado_cod_estado` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` , `turma_subInstituicao_cod_instituicao1` , `turma_subInstituicao_instituicao_cod_instituicao1` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` , `turma_subInstituicao_municipio_cod_municipio1` , `turma_subInstituicao_municipio_estado_cod_estado1` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` , `turma_subInstituicao_instituicao_cod_instituicao11` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` , `turma_subInstituicao_municipio_cod_municipio11` , `turma_subInstituicao_municipio_estado_cod_estado11` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao111`)
    REFERENCES `tcc`.`turma` (`cod_instituicao` , `subInstituicao_cod_instituicao` , `subInstituicao_instituicao_cod_instituicao` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` , `subInstituicao_municipio_cod_municipio` , `subInstituicao_municipio_estado_cod_estado` , `subInstituicao_municipio_estado_nacao_cod_nacao` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` , `subInstituicao_cod_instituicao1` , `subInstituicao_instituicao_cod_instituicao1` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` , `subInstituicao_municipio_cod_municipio1` , `subInstituicao_municipio_estado_cod_estado1` , `subInstituicao_municipio_estado_nacao_cod_nacao1` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` , `subInstituicao_instituicao_cod_instituicao11` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` , `subInstituicao_municipio_cod_municipio11` , `subInstituicao_municipio_estado_cod_estado11` , `subInstituicao_municipio_estado_nacao_cod_nacao11` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` , `subInstituicao_municipio_estado_nacao_cod_nacao111`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turma_jogador_jogador1`
    FOREIGN KEY (`jogador_cod_jogador`)
    REFERENCES `tcc`.`jogador` (`cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`evento` ;

CREATE TABLE IF NOT EXISTS `tcc`.`evento` (
  `cod_evento` INT NOT NULL,
  `cod_staff` INT NULL,
  `titulo_evento` VARCHAR(50) NULL,
  `evento` VARCHAR(50) NULL,
  `data` DATE NULL,
  `horario` TIME NULL,
  `local` VARCHAR(50) NULL,
  `titulo` VARCHAR(100) NULL,
  `desc_evento` VARCHAR(200) NULL,
  `ativo` CHAR(1) NULL,
  `staff_cod_staff` INT NOT NULL,
  `staff_role_cadastro_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `staff_cod_staff1` INT NOT NULL,
  `staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_evento`, `staff_cod_staff`, `staff_role_cadastro_cod_usuario`, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `staff_role_cadastro_tipo_role_cod_tipoRole`, `staff_cod_staff1`, `staff_role_cadastro_cod_usuario1`, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `staff_role_cadastro_tipo_role_cod_tipoRole1`, `staff_role_cadastro_cod_usuario11`, `staff_role_cadastro_tipo_role_cod_tipoRole11`, `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `staff_role_cadastro_municipio_cod_municipio`, `staff_role_cadastro_municipio_estado_cod_estado`, `staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`),
  INDEX `fk_evento_staff1_idx` (`staff_cod_staff1` ASC, `staff_role_cadastro_cod_usuario1` ASC, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `staff_role_cadastro_cod_usuario11` ASC, `staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `staff_role_cadastro_municipio_cod_municipio` ASC, `staff_role_cadastro_municipio_estado_cod_estado` ASC, `staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  CONSTRAINT `fk_evento_staff1`
    FOREIGN KEY (`staff_cod_staff1` , `staff_role_cadastro_cod_usuario1` , `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `staff_role_cadastro_tipo_role_cod_tipoRole1` , `staff_role_cadastro_cod_usuario11` , `staff_role_cadastro_tipo_role_cod_tipoRole11` , `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_municipio_cod_municipio` , `staff_role_cadastro_municipio_estado_cod_estado` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`staff` (`cod_staff` , `role_cadastro_cod_usuario` , `role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_tipo_role_cod_tipoRole` , `role_cadastro_cod_usuario1` , `role_cadastro_tipo_role_cod_tipoRole1` , `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_municipio_cod_municipio` , `role_cadastro_municipio_estado_cod_estado` , `role_cadastro_municipio_estado_nacao_cod_nacao` , `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `role_cadastro_municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`turma_evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`turma_evento` ;

CREATE TABLE IF NOT EXISTS `tcc`.`turma_evento` (
  `cod_evento` INT NOT NULL,
  `local_midia` INT NULL,
  `evento_cod_evento` INT NOT NULL,
  `evento_staff_cod_staff` INT NOT NULL,
  `evento_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `evento_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `evento_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `evento_staff_cod_staff1` INT NOT NULL,
  `evento_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `evento_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `evento_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `evento_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `evento_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `evento_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `evento_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `evento_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `evento_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `evento_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `evento_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `turma_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `turma_subInstituicao_cod_instituicao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio1` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado1` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao11` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio11` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado11` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao111` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_evento`, `turma_cod_instituicao`, `turma_subInstituicao_cod_instituicao`, `turma_subInstituicao_instituicao_cod_instituicao`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao`, `turma_subInstituicao_municipio_cod_municipio`, `turma_subInstituicao_municipio_estado_cod_estado`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao`, `turma_subInstituicao_cod_instituicao1`, `turma_subInstituicao_instituicao_cod_instituicao1`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1`, `turma_subInstituicao_municipio_cod_municipio1`, `turma_subInstituicao_municipio_estado_cod_estado1`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao1`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1`, `turma_subInstituicao_instituicao_cod_instituicao11`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11`, `turma_subInstituicao_municipio_cod_municipio11`, `turma_subInstituicao_municipio_estado_cod_estado11`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao11`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao111`),
  INDEX `fk_turma_evento_evento1_idx` (`evento_cod_evento` ASC, `evento_staff_cod_staff` ASC, `evento_staff_role_cadastro_cod_usuario` ASC, `evento_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `evento_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `evento_staff_cod_staff1` ASC, `evento_staff_role_cadastro_cod_usuario1` ASC, `evento_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `evento_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `evento_staff_role_cadastro_cod_usuario11` ASC, `evento_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `evento_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `evento_staff_role_cadastro_municipio_cod_municipio` ASC, `evento_staff_role_cadastro_municipio_estado_cod_estado` ASC, `evento_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `evento_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `evento_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  INDEX `fk_turma_evento_turma1_idx` (`turma_cod_instituicao` ASC, `turma_subInstituicao_cod_instituicao` ASC, `turma_subInstituicao_instituicao_cod_instituicao` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` ASC, `turma_subInstituicao_municipio_cod_municipio` ASC, `turma_subInstituicao_municipio_estado_cod_estado` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `turma_subInstituicao_cod_instituicao1` ASC, `turma_subInstituicao_instituicao_cod_instituicao1` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` ASC, `turma_subInstituicao_municipio_cod_municipio1` ASC, `turma_subInstituicao_municipio_estado_cod_estado1` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` ASC, `turma_subInstituicao_instituicao_cod_instituicao11` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` ASC, `turma_subInstituicao_municipio_cod_municipio11` ASC, `turma_subInstituicao_municipio_estado_cod_estado11` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao111` ASC) VISIBLE,
  CONSTRAINT `fk_turma_evento_evento1`
    FOREIGN KEY (`evento_cod_evento` , `evento_staff_cod_staff` , `evento_staff_role_cadastro_cod_usuario` , `evento_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `evento_staff_role_cadastro_tipo_role_cod_tipoRole` , `evento_staff_cod_staff1` , `evento_staff_role_cadastro_cod_usuario1` , `evento_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `evento_staff_role_cadastro_tipo_role_cod_tipoRole1` , `evento_staff_role_cadastro_cod_usuario11` , `evento_staff_role_cadastro_tipo_role_cod_tipoRole11` , `evento_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `evento_staff_role_cadastro_municipio_cod_municipio` , `evento_staff_role_cadastro_municipio_estado_cod_estado` , `evento_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `evento_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `evento_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`evento` (`cod_evento` , `staff_cod_staff` , `staff_role_cadastro_cod_usuario` , `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_tipo_role_cod_tipoRole` , `staff_cod_staff1` , `staff_role_cadastro_cod_usuario1` , `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `staff_role_cadastro_tipo_role_cod_tipoRole1` , `staff_role_cadastro_cod_usuario11` , `staff_role_cadastro_tipo_role_cod_tipoRole11` , `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_municipio_cod_municipio` , `staff_role_cadastro_municipio_estado_cod_estado` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turma_evento_turma1`
    FOREIGN KEY (`turma_cod_instituicao` , `turma_subInstituicao_cod_instituicao` , `turma_subInstituicao_instituicao_cod_instituicao` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` , `turma_subInstituicao_municipio_cod_municipio` , `turma_subInstituicao_municipio_estado_cod_estado` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` , `turma_subInstituicao_cod_instituicao1` , `turma_subInstituicao_instituicao_cod_instituicao1` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` , `turma_subInstituicao_municipio_cod_municipio1` , `turma_subInstituicao_municipio_estado_cod_estado1` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` , `turma_subInstituicao_instituicao_cod_instituicao11` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` , `turma_subInstituicao_municipio_cod_municipio11` , `turma_subInstituicao_municipio_estado_cod_estado11` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao111`)
    REFERENCES `tcc`.`turma` (`cod_instituicao` , `subInstituicao_cod_instituicao` , `subInstituicao_instituicao_cod_instituicao` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` , `subInstituicao_municipio_cod_municipio` , `subInstituicao_municipio_estado_cod_estado` , `subInstituicao_municipio_estado_nacao_cod_nacao` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` , `subInstituicao_cod_instituicao1` , `subInstituicao_instituicao_cod_instituicao1` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` , `subInstituicao_municipio_cod_municipio1` , `subInstituicao_municipio_estado_cod_estado1` , `subInstituicao_municipio_estado_nacao_cod_nacao1` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` , `subInstituicao_instituicao_cod_instituicao11` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` , `subInstituicao_municipio_cod_municipio11` , `subInstituicao_municipio_estado_cod_estado11` , `subInstituicao_municipio_estado_nacao_cod_nacao11` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` , `subInstituicao_municipio_estado_nacao_cod_nacao111`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`esporte_turma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`esporte_turma` ;

CREATE TABLE IF NOT EXISTS `tcc`.`esporte_turma` (
  `cod_esporte` INT NOT NULL,
  `cod_turma` VARCHAR(45) NULL,
  `esporte_cod_esporte` INT NOT NULL,
  `esporte_Treino_cod_treino` INT NOT NULL,
  `esporte_Treino_staff_cod_staff` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_cod_usuario` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `esporte_Treino_esporte_cod_esporte` INT NOT NULL,
  `esporte_Treino_staff_cod_staff1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_cod_usuario11` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `esporte_Treino_treino_jogador_cod_jogador` INT NOT NULL,
  `turma_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `turma_subInstituicao_cod_instituicao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio1` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado1` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao11` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio11` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado11` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao111` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_esporte`, `esporte_cod_esporte`, `esporte_Treino_cod_treino`, `esporte_Treino_staff_cod_staff`, `esporte_Treino_staff_role_cadastro_cod_usuario`, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole`, `esporte_Treino_esporte_cod_esporte`, `esporte_Treino_staff_cod_staff1`, `esporte_Treino_staff_role_cadastro_cod_usuario1`, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1`, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1`, `esporte_Treino_staff_role_cadastro_cod_usuario11`, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11`, `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `esporte_Treino_staff_role_cadastro_municipio_cod_municipio`, `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado`, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `esporte_Treino_treino_jogador_cod_jogador`, `turma_cod_instituicao`, `turma_subInstituicao_cod_instituicao`, `turma_subInstituicao_instituicao_cod_instituicao`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao`, `turma_subInstituicao_municipio_cod_municipio`, `turma_subInstituicao_municipio_estado_cod_estado`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao`, `turma_subInstituicao_cod_instituicao1`, `turma_subInstituicao_instituicao_cod_instituicao1`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1`, `turma_subInstituicao_municipio_cod_municipio1`, `turma_subInstituicao_municipio_estado_cod_estado1`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao1`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1`, `turma_subInstituicao_instituicao_cod_instituicao11`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11`, `turma_subInstituicao_municipio_cod_municipio11`, `turma_subInstituicao_municipio_estado_cod_estado11`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao11`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao111`),
  INDEX `fk_esporte_turma_esporte1_idx` (`esporte_cod_esporte` ASC, `esporte_Treino_cod_treino` ASC, `esporte_Treino_staff_cod_staff` ASC, `esporte_Treino_staff_role_cadastro_cod_usuario` ASC, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `esporte_Treino_esporte_cod_esporte` ASC, `esporte_Treino_staff_cod_staff1` ASC, `esporte_Treino_staff_role_cadastro_cod_usuario1` ASC, `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` ASC, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `esporte_Treino_staff_role_cadastro_cod_usuario11` ASC, `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` ASC, `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC, `esporte_Treino_treino_jogador_cod_jogador` ASC) VISIBLE,
  INDEX `fk_esporte_turma_turma1_idx` (`turma_cod_instituicao` ASC, `turma_subInstituicao_cod_instituicao` ASC, `turma_subInstituicao_instituicao_cod_instituicao` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` ASC, `turma_subInstituicao_municipio_cod_municipio` ASC, `turma_subInstituicao_municipio_estado_cod_estado` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `turma_subInstituicao_cod_instituicao1` ASC, `turma_subInstituicao_instituicao_cod_instituicao1` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` ASC, `turma_subInstituicao_municipio_cod_municipio1` ASC, `turma_subInstituicao_municipio_estado_cod_estado1` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` ASC, `turma_subInstituicao_instituicao_cod_instituicao11` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` ASC, `turma_subInstituicao_municipio_cod_municipio11` ASC, `turma_subInstituicao_municipio_estado_cod_estado11` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao111` ASC) VISIBLE,
  CONSTRAINT `fk_esporte_turma_esporte1`
    FOREIGN KEY (`esporte_cod_esporte` , `esporte_Treino_cod_treino` , `esporte_Treino_staff_cod_staff` , `esporte_Treino_staff_role_cadastro_cod_usuario` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `esporte_Treino_esporte_cod_esporte` , `esporte_Treino_staff_cod_staff1` , `esporte_Treino_staff_role_cadastro_cod_usuario1` , `esporte_Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `esporte_Treino_staff_role_cadastro_cod_usuario11` , `esporte_Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `esporte_Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `esporte_Treino_staff_role_cadastro_municipio_cod_municipio` , `esporte_Treino_staff_role_cadastro_municipio_estado_cod_estado` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `esporte_Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `esporte_Treino_treino_jogador_cod_jogador`)
    REFERENCES `tcc`.`esporte` (`cod_esporte` , `Treino_cod_treino` , `Treino_staff_cod_staff` , `Treino_staff_role_cadastro_cod_usuario` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole` , `Treino_esporte_cod_esporte` , `Treino_staff_cod_staff1` , `Treino_staff_role_cadastro_cod_usuario1` , `Treino_staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario1` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole1` , `Treino_staff_role_cadastro_cod_usuario11` , `Treino_staff_role_cadastro_tipo_role_cod_tipoRole11` , `Treino_staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `Treino_staff_role_cadastro_municipio_cod_municipio` , `Treino_staff_role_cadastro_municipio_estado_cod_estado` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `Treino_staff_role_cadastro_municipio_estado_nacao_cod_nacao1` , `Treino_treino_jogador_cod_jogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_esporte_turma_turma1`
    FOREIGN KEY (`turma_cod_instituicao` , `turma_subInstituicao_cod_instituicao` , `turma_subInstituicao_instituicao_cod_instituicao` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` , `turma_subInstituicao_municipio_cod_municipio` , `turma_subInstituicao_municipio_estado_cod_estado` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` , `turma_subInstituicao_cod_instituicao1` , `turma_subInstituicao_instituicao_cod_instituicao1` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` , `turma_subInstituicao_municipio_cod_municipio1` , `turma_subInstituicao_municipio_estado_cod_estado1` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` , `turma_subInstituicao_instituicao_cod_instituicao11` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` , `turma_subInstituicao_municipio_cod_municipio11` , `turma_subInstituicao_municipio_estado_cod_estado11` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao111`)
    REFERENCES `tcc`.`turma` (`cod_instituicao` , `subInstituicao_cod_instituicao` , `subInstituicao_instituicao_cod_instituicao` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` , `subInstituicao_municipio_cod_municipio` , `subInstituicao_municipio_estado_cod_estado` , `subInstituicao_municipio_estado_nacao_cod_nacao` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` , `subInstituicao_cod_instituicao1` , `subInstituicao_instituicao_cod_instituicao1` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` , `subInstituicao_municipio_cod_municipio1` , `subInstituicao_municipio_estado_cod_estado1` , `subInstituicao_municipio_estado_nacao_cod_nacao1` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` , `subInstituicao_instituicao_cod_instituicao11` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` , `subInstituicao_municipio_cod_municipio11` , `subInstituicao_municipio_estado_cod_estado11` , `subInstituicao_municipio_estado_nacao_cod_nacao11` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` , `subInstituicao_municipio_estado_nacao_cod_nacao111`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tcc`.`staff_turma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tcc`.`staff_turma` ;

CREATE TABLE IF NOT EXISTS `tcc`.`staff_turma` (
  `cod_turma` INT NOT NULL,
  `cod_staff` INT NULL,
  `staff_cod_staff` INT NOT NULL,
  `staff_role_cadastro_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole` INT NOT NULL,
  `staff_role_cadastro_cod_usuario1` INT NOT NULL,
  `staff_role_cadastro_tipo_role_cod_tipoRole1` INT NOT NULL,
  `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` INT NOT NULL,
  `staff_role_cadastro_municipio_cod_municipio` INT NOT NULL,
  `staff_role_cadastro_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `staff_role_cadastro_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `turma_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` INT NOT NULL,
  `turma_subInstituicao_cod_instituicao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio1` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado1` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` INT NOT NULL,
  `turma_subInstituicao_instituicao_cod_instituicao11` INT NOT NULL,
  `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` INT NOT NULL,
  `turma_subInstituicao_municipio_cod_municipio11` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_cod_estado11` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` SMALLINT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` INT NOT NULL,
  `turma_subInstituicao_municipio_estado_nacao_cod_nacao111` SMALLINT NOT NULL,
  PRIMARY KEY (`cod_turma`, `staff_cod_staff`, `staff_role_cadastro_cod_usuario`, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario`, `staff_role_cadastro_tipo_role_cod_tipoRole`, `staff_role_cadastro_cod_usuario1`, `staff_role_cadastro_tipo_role_cod_tipoRole1`, `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario`, `staff_role_cadastro_municipio_cod_municipio`, `staff_role_cadastro_municipio_estado_cod_estado`, `staff_role_cadastro_municipio_estado_nacao_cod_nacao`, `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao`, `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`, `turma_cod_instituicao`, `turma_subInstituicao_cod_instituicao`, `turma_subInstituicao_instituicao_cod_instituicao`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao`, `turma_subInstituicao_municipio_cod_municipio`, `turma_subInstituicao_municipio_estado_cod_estado`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao`, `turma_subInstituicao_cod_instituicao1`, `turma_subInstituicao_instituicao_cod_instituicao1`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1`, `turma_subInstituicao_municipio_cod_municipio1`, `turma_subInstituicao_municipio_estado_cod_estado1`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao1`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1`, `turma_subInstituicao_instituicao_cod_instituicao11`, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11`, `turma_subInstituicao_municipio_cod_municipio11`, `turma_subInstituicao_municipio_estado_cod_estado11`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao11`, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11`, `turma_subInstituicao_municipio_estado_nacao_cod_nacao111`),
  INDEX `fk_staff_turma_staff1_idx` (`staff_cod_staff` ASC, `staff_role_cadastro_cod_usuario` ASC, `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` ASC, `staff_role_cadastro_tipo_role_cod_tipoRole` ASC, `staff_role_cadastro_cod_usuario1` ASC, `staff_role_cadastro_tipo_role_cod_tipoRole1` ASC, `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` ASC, `staff_role_cadastro_municipio_cod_municipio` ASC, `staff_role_cadastro_municipio_estado_cod_estado` ASC, `staff_role_cadastro_municipio_estado_nacao_cod_nacao` ASC, `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `staff_role_cadastro_municipio_estado_nacao_cod_nacao1` ASC) VISIBLE,
  INDEX `fk_staff_turma_turma1_idx` (`turma_cod_instituicao` ASC, `turma_subInstituicao_cod_instituicao` ASC, `turma_subInstituicao_instituicao_cod_instituicao` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` ASC, `turma_subInstituicao_municipio_cod_municipio` ASC, `turma_subInstituicao_municipio_estado_cod_estado` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` ASC, `turma_subInstituicao_cod_instituicao1` ASC, `turma_subInstituicao_instituicao_cod_instituicao1` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` ASC, `turma_subInstituicao_municipio_cod_municipio1` ASC, `turma_subInstituicao_municipio_estado_cod_estado1` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` ASC, `turma_subInstituicao_instituicao_cod_instituicao11` ASC, `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` ASC, `turma_subInstituicao_municipio_cod_municipio11` ASC, `turma_subInstituicao_municipio_estado_cod_estado11` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` ASC, `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` ASC, `turma_subInstituicao_municipio_estado_nacao_cod_nacao111` ASC) VISIBLE,
  CONSTRAINT `fk_staff_turma_staff1`
    FOREIGN KEY (`staff_cod_staff` , `staff_role_cadastro_cod_usuario` , `staff_role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_tipo_role_cod_tipoRole` , `staff_role_cadastro_cod_usuario1` , `staff_role_cadastro_tipo_role_cod_tipoRole1` , `staff_role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `staff_role_cadastro_municipio_cod_municipio` , `staff_role_cadastro_municipio_estado_cod_estado` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `staff_role_cadastro_municipio_estado_nacao_cod_nacao1`)
    REFERENCES `tcc`.`staff` (`cod_staff` , `role_cadastro_cod_usuario` , `role_cadastro_Ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_tipo_role_cod_tipoRole` , `role_cadastro_cod_usuario1` , `role_cadastro_tipo_role_cod_tipoRole1` , `role_cadastro_ca﻿dastro_Identificacao_cod_usuario` , `role_cadastro_municipio_cod_municipio` , `role_cadastro_municipio_estado_cod_estado` , `role_cadastro_municipio_estado_nacao_cod_nacao` , `role_cadastro_municipio_estado_nacao_nacao_midia_cod_nacao` , `role_cadastro_municipio_estado_nacao_cod_nacao1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_staff_turma_turma1`
    FOREIGN KEY (`turma_cod_instituicao` , `turma_subInstituicao_cod_instituicao` , `turma_subInstituicao_instituicao_cod_instituicao` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` , `turma_subInstituicao_municipio_cod_municipio` , `turma_subInstituicao_municipio_estado_cod_estado` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` , `turma_subInstituicao_cod_instituicao1` , `turma_subInstituicao_instituicao_cod_instituicao1` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` , `turma_subInstituicao_municipio_cod_municipio1` , `turma_subInstituicao_municipio_estado_cod_estado1` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao1` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` , `turma_subInstituicao_instituicao_cod_instituicao11` , `turma_subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` , `turma_subInstituicao_municipio_cod_municipio11` , `turma_subInstituicao_municipio_estado_cod_estado11` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao11` , `turma_subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` , `turma_subInstituicao_municipio_estado_nacao_cod_nacao111`)
    REFERENCES `tcc`.`turma` (`cod_instituicao` , `subInstituicao_cod_instituicao` , `subInstituicao_instituicao_cod_instituicao` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao` , `subInstituicao_municipio_cod_municipio` , `subInstituicao_municipio_estado_cod_estado` , `subInstituicao_municipio_estado_nacao_cod_nacao` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao` , `subInstituicao_cod_instituicao1` , `subInstituicao_instituicao_cod_instituicao1` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao1` , `subInstituicao_municipio_cod_municipio1` , `subInstituicao_municipio_estado_cod_estado1` , `subInstituicao_municipio_estado_nacao_cod_nacao1` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao1` , `subInstituicao_instituicao_cod_instituicao11` , `subInstituicao_instituicao_tipo_instituicao_cod_tipoInstituicao11` , `subInstituicao_municipio_cod_municipio11` , `subInstituicao_municipio_estado_cod_estado11` , `subInstituicao_municipio_estado_nacao_cod_nacao11` , `subInstituicao_municipio_estado_nacao_nacao_midia_cod_nacao11` , `subInstituicao_municipio_estado_nacao_cod_nacao111`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
