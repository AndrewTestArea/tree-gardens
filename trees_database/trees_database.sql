-- MySQL Script generated by MySQL Workbench
-- Fri Sep 15 21:48:04 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`species`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`species` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `genus` VARCHAR(45) NULL,
  `species` VARCHAR(45) NULL,
  `common_name` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`trees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`trees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_planted` DATETIME NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `name` VARCHAR(45) NULL,
  `t_number` VARCHAR(45) NULL,
  `species_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trees_species1_idx` (`species_id` ASC),
  CONSTRAINT `fk_trees_species1`
    FOREIGN KEY (`species_id`)
    REFERENCES `mydb`.`species` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sites` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lat` DECIMAL(3,10) NULL,
  `lng` DECIMAL(3,10) NULL,
  `soil_type` VARCHAR(45) NULL,
  `drainage` VARCHAR(45) NULL,
  `site_quality` INT NULL,
  `section` INT NULL,
  `row` INT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `tree_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sites_trees1_idx` (`tree_id` ASC),
  CONSTRAINT `fk_sites_trees1`
    FOREIGN KEY (`tree_id`)
    REFERENCES `mydb`.`trees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`variety`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`variety` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `icon` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `species_id` INT NOT NULL,
  PRIMARY KEY (`id`, `species_id`),
  INDEX `fk_variety_species1_idx` (`species_id` ASC),
  CONSTRAINT `fk_variety_species1`
    FOREIGN KEY (`species_id`)
    REFERENCES `mydb`.`species` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `role` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rows_sections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rows_sections` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`notes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`notes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `author` VARCHAR(45) NULL,
  `content` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `variety_id` INT NOT NULL,
  `species_id` INT NOT NULL,
  `tree_id` INT NOT NULL,
  `site_id` INT NOT NULL,
  `row_section_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_notes_variety1_idx` (`variety_id` ASC),
  INDEX `fk_notes_species1_idx` (`species_id` ASC),
  INDEX `fk_notes_trees1_idx` (`tree_id` ASC),
  INDEX `fk_notes_sites1_idx` (`site_id` ASC),
  INDEX `fk_notes_rows_sections1_idx` (`row_section_id` ASC),
  INDEX `fk_notes_users1_idx` (`user_id` ASC),
  INDEX `fk_notes_roles1_idx` (`role_id` ASC),
  CONSTRAINT `fk_notes_variety1`
    FOREIGN KEY (`variety_id`)
    REFERENCES `mydb`.`variety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notes_species1`
    FOREIGN KEY (`species_id`)
    REFERENCES `mydb`.`species` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notes_trees1`
    FOREIGN KEY (`tree_id`)
    REFERENCES `mydb`.`trees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notes_sites1`
    FOREIGN KEY (`site_id`)
    REFERENCES `mydb`.`sites` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notes_rows_sections1`
    FOREIGN KEY (`row_section_id`)
    REFERENCES `mydb`.`rows_sections` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notes_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notes_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`users_have_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`users_have_roles` (
  `user_id` INT NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  INDEX `fk_users_has_roles_roles1_idx` (`role_id` ASC),
  INDEX `fk_users_has_roles_users_idx` (`user_id` ASC),
  CONSTRAINT `fk_users_has_roles_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_roles_roles1`
    FOREIGN KEY (`role_id`)
    REFERENCES `mydb`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sites_have_rows_sections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sites_have_rows_sections` (
  `site_id` INT NOT NULL,
  `row_section_id` INT NOT NULL,
  PRIMARY KEY (`site_id`, `row_section_id`),
  INDEX `fk_sites_has_rows_sections_rows_sections1_idx` (`row_section_id` ASC),
  INDEX `fk_sites_has_rows_sections_sites1_idx` (`site_id` ASC),
  CONSTRAINT `fk_sites_has_rows_sections_sites1`
    FOREIGN KEY (`site_id`)
    REFERENCES `mydb`.`sites` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sites_has_rows_sections_rows_sections1`
    FOREIGN KEY (`row_section_id`)
    REFERENCES `mydb`.`rows_sections` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
