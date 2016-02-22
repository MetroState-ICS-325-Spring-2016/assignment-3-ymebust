/* First create a database named examples if it doesn't
already exist. */
CREATE DATABASE IF NOT EXISTS `examples`;

/* Switch to using the examples database for the following commands */
USE `examples`;

/* Create a new table named people if it doesn't already exist.
Note that the primary key is a combination of the columns
lname and fname. */
CREATE TABLE IF NOT EXISTS `people` (
`fname` VARCHAR(50) NOT NULL,
`lname` VARCHAR(50) NOT NULL,
`color` VARCHAR(25) NOT NULL,
`food` VARCHAR(25) NOT NULL,
`game` VARCHAR(25) NOT NULL,
`lang` VARCHAR(25) NOT NULL,
PRIMARY KEY (`lname`, `fname`)
) ENGINE=InnoDB;

/* Insert data into the people table one row at a time. */
INSERT INTO `people` SET `fname`='jason', `lname`='johnson', `food`='pizza', `color`='blue', `game`='monopoly', `lang`='C';
INSERT INTO `people` SET `food`='hamburger', `game`='blackjack', `fname`='george', `lang`='PHP', `lname`='Dobson', `color`='red';
INSERT INTO `people` SET `color`='blue', `lang`='Perl', `food`='taco', `lname`='holmes', `fname`='joe', `game`='slots';
INSERT INTO `people` SET `game`='blackjack', `color`='yellow', `fname`='daniel', `lang`='C', `food`='taco', `lname`='forbes';
INSERT INTO `people` SET `lname`='wilson', `color`='blue', `food`='pizza', `lang`='C', `fname`='jonathon', `game`='blackjack';
INSERT INTO `people` SET `game`='monopoly', `food`='pizza', `lang`='PHP', `lname`='mortonson', `fname`='jill', `color`='red';
INSERT INTO `people` SET `lname`='johnson', `fname`='holly', `lang`='C', `food`='taco', `color`='yellow', `game`='slots';
INSERT INTO `people` SET `lang`='Perl', `food`='hamburger', `lname`='floden', `fname`='ashley', `color`='blue', `game`='monopoly';
INSERT INTO `people` SET `lang`='PHP', `food`='pizza', `fname`='josh', `color`='red', `game`='slots', `lname`='nelson';

/* Capitalize the first letter of the fname and lname columns for all rows. */
UPDATE `people` SET `fname`=CONCAT(UPPER(SUBSTR(`fname`,1,1)),SUBSTR(`fname`,2));
UPDATE `people` SET `lname`=CONCAT(UPPER(SUBSTR(`lname`,1,1)),SUBSTR(`lname`,2));
