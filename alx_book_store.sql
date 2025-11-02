-- alx_book_store.sql
CREATE DATABASE IF NOT EXISTS `alx_book_store`;
USE `alx_book_store`;

-- Safe drop in dependency order
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Order_Details`;
DROP TABLE IF EXISTS `Orders`;
DROP TABLE IF EXISTS `Books`;
DROP TABLE IF EXISTS `Authors`;
DROP TABLE IF EXISTS `Customers`;
SET FOREIGN_KEY_CHECKS = 1;

-- Authors table
CREATE TABLE `Authors` (
  `author_id` INT PRIMARY KEY AUTO_INCREMENT,
  `author_name` VARCHAR(215) NOT NULL
) ENGINE=InnoDB;

-- Customers table
CREATE TABLE `Customers` (
  `customer_id` INT PRIMARY KEY AUTO_INCREMENT,
  `customer_name` VARCHAR(215) NOT NULL,
  `email` VARCHAR(215) NOT NULL,
  `address` TEXT
) ENGINE=InnoDB;

-- Books table (references Authors)
CREATE TABLE `Books` (
  `book_id` INT PRIMARY KEY AUTO_INCREMENT,
  `title` VARCHAR(130) NOT NULL,
  `author_id` INT NOT NULL,
  `price` DOUBLE NOT NULL,
  `publication_date` DATE,
  CONSTRAINT `fk_books_author`
    FOREIGN KEY (`author_id`) REFERENCES `Authors`(`author_id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Orders table (references Customers)
CREATE TABLE `Orders` (
  `order_id` INT PRIMARY KEY AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` DATE,
  CONSTRAINT `fk_orders_customer`
    FOREIGN KEY (`customer_id`) REFERENCES `Customers`(`customer_id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Order_Details table (references Orders and Books)
CREATE TABLE `Order_Details` (
  `orderdetailid` INT PRIMARY KEY AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  `quantity` DOUBLE NOT NULL,
  CONSTRAINT `fk_orderdetails_order`
    FOREIGN KEY (`order_id`) REFERENCES `Orders`(`order_id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_orderdetails_book`
    FOREIGN KEY (`book_id`) REFERENCES `Books`(`book_id`)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
