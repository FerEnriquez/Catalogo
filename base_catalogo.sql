-- MySQL Script generated by MySQL Workbench
-- Sat Apr 29 14:55:59 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema catalogo
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `catalogo` ;

-- -----------------------------------------------------
-- Schema catalogo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `catalogo` DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci ;
USE `catalogo` ;

-- -----------------------------------------------------
-- Table `catalogo`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catalogo`.`Cliente` (
  `IDCliente` INT(10) NOT NULL AUTO_INCREMENT,
  `Nombre_Cliente` VARCHAR(45) NOT NULL,
  `Telefono` CHAR(13) NOT NULL,
  `Direccion` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`IDCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalogo`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catalogo`.`Compra` (
  `IDCompra` VARCHAR(10) NOT NULL,
  `Total_Vendido` DECIMAL(4) NOT NULL,
  `Cliente_IDCliente` INT(10) NOT NULL,
  `Fehcha_Entrega` DATE NULL,
  PRIMARY KEY (`IDCompra`, `Cliente_IDCliente`),
  CONSTRAINT `fk_Compra_Cliente`
    FOREIGN KEY (`Cliente_IDCliente`)
    REFERENCES `catalogo`.`Cliente` (`IDCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Compra_Cliente_idx` ON `catalogo`.`Compra` (`Cliente_IDCliente` ASC);


-- -----------------------------------------------------
-- Table `catalogo`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catalogo`.`Proveedor` (
  `IDProveedor` VARCHAR(10) NOT NULL,
  `Nombre_Proveedor` VARCHAR(45) NOT NULL,
  `Ubicacion` VARCHAR(45) NOT NULL,
  `TelefonoP` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`IDProveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `catalogo`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catalogo`.`Marca` (
  `IDMarca` VARCHAR(10) NOT NULL,
  `Nombre_Marca` VARCHAR(40) NOT NULL,
  `Categoria` VARCHAR(20) NOT NULL,
  `Proveedor_IDProveedor` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`IDMarca`, `Proveedor_IDProveedor`),
  CONSTRAINT `fk_Marca_Proveedor1`
    FOREIGN KEY (`Proveedor_IDProveedor`)
    REFERENCES `catalogo`.`Proveedor` (`IDProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Marca_Proveedor1_idx` ON `catalogo`.`Marca` (`Proveedor_IDProveedor` ASC);


-- -----------------------------------------------------
-- Table `catalogo`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catalogo`.`Producto` (
  `IDProducto` VARCHAR(10) NOT NULL,
  `Precio` DECIMAL(2) NOT NULL,
  `Descripcion` VARCHAR(50) NULL,
  `Marca_IDMarca` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`IDProducto`, `Marca_IDMarca`),
  CONSTRAINT `fk_Catalogo_Marca1`
    FOREIGN KEY (`Marca_IDMarca`)
    REFERENCES `catalogo`.`Marca` (`IDMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Catalogo_Marca1_idx` ON `catalogo`.`Producto` (`Marca_IDMarca` ASC);


-- -----------------------------------------------------
-- Table `catalogo`.`Orden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catalogo`.`Orden` (
  `IDOrden` INT NOT NULL AUTO_INCREMENT,
  `Cantidad` INT NOT NULL,
  `Compra_IDCompra` VARCHAR(10) NOT NULL,
  `Compra_Cliente_IDCliente` INT(10) NOT NULL,
  `Producto_IDProducto` VARCHAR(10) NOT NULL,
  `Producto_Marca_IDMarca` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`IDOrden`, `Compra_IDCompra`, `Compra_Cliente_IDCliente`, `Producto_IDProducto`, `Producto_Marca_IDMarca`),
  CONSTRAINT `fk_Orden_Compra1`
    FOREIGN KEY (`Compra_IDCompra` , `Compra_Cliente_IDCliente`)
    REFERENCES `catalogo`.`Compra` (`IDCompra` , `Cliente_IDCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orden_Producto1`
    FOREIGN KEY (`Producto_IDProducto` , `Producto_Marca_IDMarca`)
    REFERENCES `catalogo`.`Producto` (`IDProducto` , `Marca_IDMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Orden_Compra1_idx` ON `catalogo`.`Orden` (`Compra_IDCompra` ASC, `Compra_Cliente_IDCliente` ASC);

CREATE INDEX `fk_Orden_Producto1_idx` ON `catalogo`.`Orden` (`Producto_IDProducto` ASC, `Producto_Marca_IDMarca` ASC);


-- -----------------------------------------------------
-- Table `catalogo`.`Pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catalogo`.`Pagos` (
  `IDPago` VARCHAR(10) NOT NULL,
  `Anticipo` DECIMAL(2) NOT NULL,
  `Tipo_pago` VARCHAR(20) NOT NULL,
  `Deuda` DECIMAL(2) NOT NULL,
  `Compra_IDCompra` VARCHAR(10) NOT NULL,
  `Compra_Cliente_IDCliente` INT(10) NOT NULL,
  PRIMARY KEY (`IDPago`, `Compra_IDCompra`, `Compra_Cliente_IDCliente`),
  CONSTRAINT `fk_Pagos_Compra1`
    FOREIGN KEY (`Compra_IDCompra` , `Compra_Cliente_IDCliente`)
    REFERENCES `catalogo`.`Compra` (`IDCompra` , `Cliente_IDCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Pagos_Compra1_idx` ON `catalogo`.`Pagos` (`Compra_IDCompra` ASC, `Compra_Cliente_IDCliente` ASC);


-- -----------------------------------------------------
-- Table `catalogo`.`Contabilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catalogo`.`Contabilidad` (
  `Gastos` DECIMAL(2) NOT NULL,
  `Periodo` VARCHAR(20) NOT NULL,
  `Ganancia` DECIMAL(2) NOT NULL,
  `Compra_IDCompra` VARCHAR(10) NOT NULL,
  `Compra_Cliente_IDCliente` INT(10) NOT NULL,
  PRIMARY KEY (`Periodo`, `Compra_IDCompra`, `Compra_Cliente_IDCliente`),
  CONSTRAINT `fk_Contabilidad_Compra1`
    FOREIGN KEY (`Compra_IDCompra` , `Compra_Cliente_IDCliente`)
    REFERENCES `catalogo`.`Compra` (`IDCompra` , `Cliente_IDCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Contabilidad_Compra1_idx` ON `catalogo`.`Contabilidad` (`Compra_IDCompra` ASC, `Compra_Cliente_IDCliente` ASC);


-- -----------------------------------------------------
-- Table `catalogo`.`Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catalogo`.`Vendedor` (
  `IDSolicitud` VARCHAR(10) NOT NULL,
  `Costo` DECIMAL(2) NOT NULL,
  `Contabilidad_Periodo` VARCHAR(20) NOT NULL,
  `Proveedor_IDProveedor` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`IDSolicitud`, `Contabilidad_Periodo`, `Proveedor_IDProveedor`),
  CONSTRAINT `fk_Vendedor_Contabilidad1`
    FOREIGN KEY (`Contabilidad_Periodo`)
    REFERENCES `catalogo`.`Contabilidad` (`Periodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Vendedor_Proveedor1`
    FOREIGN KEY (`Proveedor_IDProveedor`)
    REFERENCES `catalogo`.`Proveedor` (`IDProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Vendedor_Contabilidad1_idx` ON `catalogo`.`Vendedor` (`Contabilidad_Periodo` ASC);

CREATE INDEX `fk_Vendedor_Proveedor1_idx` ON `catalogo`.`Vendedor` (`Proveedor_IDProveedor` ASC);


-- -----------------------------------------------------
-- Table `catalogo`.`Solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `catalogo`.`Solicitud` (
  `IDSolicitud` VARCHAR(10) NOT NULL,
  `Cantidad` INT NOT NULL,
  `Total_Comprado` DECIMAL(2) NOT NULL,
  `Fecha_Recogida` DATE NULL,
  `Vendedor_IDVendedor` VARCHAR(10) NOT NULL,
  `Vendedor_Contabilidad_Periodo` VARCHAR(20) NOT NULL,
  `Vendedor_Proveedor_IDProveedor` VARCHAR(10) NOT NULL,
  `Catalogo_IDProducto` VARCHAR(10) NOT NULL,
  `Catalogo_Marca_IDMarca` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`IDSolicitud`, `Vendedor_IDVendedor`, `Vendedor_Contabilidad_Periodo`, `Vendedor_Proveedor_IDProveedor`, `Catalogo_IDProducto`, `Catalogo_Marca_IDMarca`),
  CONSTRAINT `fk_Solicitud_Vendedor1`
    FOREIGN KEY (`Vendedor_IDVendedor` , `Vendedor_Contabilidad_Periodo` , `Vendedor_Proveedor_IDProveedor`)
    REFERENCES `catalogo`.`Vendedor` (`IDSolicitud` , `Contabilidad_Periodo` , `Proveedor_IDProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solicitud_Catalogo1`
    FOREIGN KEY (`Catalogo_IDProducto` , `Catalogo_Marca_IDMarca`)
    REFERENCES `catalogo`.`Producto` (`IDProducto` , `Marca_IDMarca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Solicitud_Vendedor1_idx` ON `catalogo`.`Solicitud` (`Vendedor_IDVendedor` ASC, `Vendedor_Contabilidad_Periodo` ASC, `Vendedor_Proveedor_IDProveedor` ASC);

CREATE INDEX `fk_Solicitud_Catalogo1_idx` ON `catalogo`.`Solicitud` (`Catalogo_IDProducto` ASC, `Catalogo_Marca_IDMarca` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
