-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8mb4 ;
USE `ecommerce` ;

-- -----------------------------------------------------
-- Table `ecommerce`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`users` (
  `UserID` INT(11) NOT NULL AUTO_INCREMENT,
  `UserEmail` VARCHAR(500) NULL DEFAULT NULL,
  `UserPassword` VARCHAR(500) NULL DEFAULT NULL,
  `UserFirstName` VARCHAR(50) NULL DEFAULT NULL,
  `UserLastName` VARCHAR(50) NULL DEFAULT NULL,
  `UserCity` VARCHAR(90) NULL DEFAULT NULL,
  `UserState` VARCHAR(20) NULL DEFAULT NULL,
  `UserZip` VARCHAR(12) NULL DEFAULT NULL,
  `UserEmailVerified` TINYINT(1) NULL DEFAULT '0',
  `UserRegistrationDate` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `UserVerificationCode` VARCHAR(100) NULL DEFAULT NULL,
  `UserIP` VARCHAR(50) NULL DEFAULT NULL,
  `UserPhone` VARCHAR(20) NULL DEFAULT NULL,
  `UserFax` VARCHAR(20) NULL DEFAULT NULL,
  `UserCountry` VARCHAR(20) NULL DEFAULT NULL,
  `UserAddress` VARCHAR(100) NULL DEFAULT NULL,
  `UserAddress2` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `ecommerce`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`cart` (
  `CartID` INT(11) NOT NULL AUTO_INCREMENT,
  `UserID` INT(11) NOT NULL,
  PRIMARY KEY (`CartID`),
  INDEX `fk_cart_users1_idx` (`UserID` ASC),
  CONSTRAINT `fk_cart_users1`
    FOREIGN KEY (`UserID`)
    REFERENCES `ecommerce`.`users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `ecommerce`.`productcategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`productcategories` (
  `CategoryID` INT(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`CategoryID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `ecommerce`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`products` (
  `ProductID` INT(12) NOT NULL AUTO_INCREMENT,
  `ProductSKU` VARCHAR(50) NOT NULL,
  `ProductName` VARCHAR(100) NOT NULL,
  `ProductPrice` FLOAT NOT NULL,
  `ProductWeight` FLOAT NOT NULL,
  `ProductCartDesc` VARCHAR(250) NOT NULL,
  `ProductShortDesc` VARCHAR(1000) NOT NULL,
  `ProductLongDesc` TEXT NOT NULL,
  `ProductThumb` VARCHAR(100) NOT NULL,
  `ProductImage` VARCHAR(100) NOT NULL,
  `ProductCategoryID` INT(11) NULL DEFAULT NULL,
  `ProductUpdateDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ProductStock` FLOAT NULL DEFAULT NULL,
  `ProductLive` TINYINT(1) NULL DEFAULT '0',
  `ProductUnlimited` TINYINT(1) NULL DEFAULT '1',
  `ProductLocation` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `fk_products_productcategories1_idx` (`ProductCategoryID` ASC),
  CONSTRAINT `fk_products_productcategories1`
    FOREIGN KEY (`ProductCategoryID`)
    REFERENCES `ecommerce`.`productcategories` (`CategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 991
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `ecommerce`.`cartitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`cartitems` (
  `CartItemID` INT(11) NOT NULL AUTO_INCREMENT,
  `CartID` INT(11) NOT NULL,
  `ProductID` INT(12) NOT NULL,
  `Quantity` INT(11) NOT NULL,
  `Price` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`CartItemID`),
  INDEX `fk_cartitems_cart1_idx` (`CartID` ASC),
  INDEX `fk_cartitems_products1_idx` (`ProductID` ASC),
  CONSTRAINT `fk_cartitems_cart1`
    FOREIGN KEY (`CartID`)
    REFERENCES `ecommerce`.`cart` (`CartID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartitems_products1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `ecommerce`.`products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `ecommerce`.`optiongroups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`optiongroups` (
  `OptionGroupID` INT(11) NOT NULL AUTO_INCREMENT,
  `OptionGroupName` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`OptionGroupID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `ecommerce`.`options`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`options` (
  `OptionID` INT(11) NOT NULL AUTO_INCREMENT,
  `OptionGroupID` INT(11) NULL DEFAULT NULL,
  `OptionName` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`OptionID`),
  INDEX `fk_options_optiongroups1_idx` (`OptionGroupID` ASC),
  CONSTRAINT `fk_options_optiongroups1`
    FOREIGN KEY (`OptionGroupID`)
    REFERENCES `ecommerce`.`optiongroups` (`OptionGroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `ecommerce`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`orders` (
  `OrderID` INT(11) NOT NULL AUTO_INCREMENT,
  `OrderUserID` INT(11) NOT NULL,
  `OrderAmount` FLOAT NOT NULL,
  `OrderShipName` VARCHAR(100) NOT NULL,
  `OrderShipAddress` VARCHAR(100) NOT NULL,
  `OrderShipAddress2` VARCHAR(100) NOT NULL,
  `OrderCity` VARCHAR(50) NOT NULL,
  `OrderState` VARCHAR(50) NOT NULL,
  `OrderZip` VARCHAR(20) NOT NULL,
  `OrderCountry` VARCHAR(50) NOT NULL,
  `OrderPhone` VARCHAR(20) NOT NULL,
  `OrderFax` VARCHAR(20) NOT NULL,
  `OrderShipping` FLOAT NOT NULL,
  `OrderTax` FLOAT NOT NULL,
  `OrderEmail` VARCHAR(100) NOT NULL,
  `OrderDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `OrderShipped` TINYINT(1) NOT NULL DEFAULT '0',
  `OrderTrackingNumber` VARCHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_orders_users1_idx` (`OrderUserID` ASC),
  CONSTRAINT `fk_orders_users1`
    FOREIGN KEY (`OrderUserID`)
    REFERENCES `ecommerce`.`users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `ecommerce`.`orderdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`orderdetails` (
  `DetailID` INT(11) NOT NULL AUTO_INCREMENT,
  `DetailOrderID` INT(11) NOT NULL,
  `DetailProductID` INT(11) NOT NULL,
  `DetailName` VARCHAR(250) NOT NULL,
  `DetailPrice` FLOAT NOT NULL,
  `DetailSKU` VARCHAR(50) NOT NULL,
  `DetailQuantity` INT(11) NOT NULL,
  PRIMARY KEY (`DetailID`),
  INDEX `fk_orderdetails_orders1_idx` (`DetailOrderID` ASC),
  INDEX `fk_orderdetails_products1_idx` (`DetailProductID` ASC),
  CONSTRAINT `fk_orderdetails_orders1`
    FOREIGN KEY (`DetailOrderID`)
    REFERENCES `ecommerce`.`orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderdetails_products1`
    FOREIGN KEY (`DetailProductID`)
    REFERENCES `ecommerce`.`products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `ecommerce`.`productoptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`productoptions` (
  `ProductOptionID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProductID` INT(12) NOT NULL,
  `OptionID` INT(11) NOT NULL,
  `OptionPriceIncrement` DOUBLE NULL DEFAULT NULL,
  `OptionGroupID` INT(11) NOT NULL,
  PRIMARY KEY (`ProductOptionID`),
  INDEX `fk_productoptions_products_idx` (`ProductID` ASC),
  INDEX `fk_productoptions_options1_idx` (`OptionID` ASC),
  CONSTRAINT `fk_productoptions_options1`
    FOREIGN KEY (`OptionID`)
    REFERENCES `ecommerce`.`options` (`OptionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productoptions_products`
    FOREIGN KEY (`ProductID`)
    REFERENCES `ecommerce`.`products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
