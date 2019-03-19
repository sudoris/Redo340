-- Data Definition Queries for Employee Database by David Chen and Ryan Yun for 2018 Winter CS340

SET FOREIGN_KEY_CHECKS=0;

--
-- Table structure for table `employee`
--
DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `employee_id` int(11) AUTO_INCREMENT NOT NULL, 
  `fname` varchar(40) NOT NULL,
  `lname` varchar(40) DEFAULT NULL,  
  -- `birthday` date DEFAULT NULL,
  `birthday` varchar(10) DEFAULT NULL,
  `department_id` int(11),
  `position` varchar(75),
  `monthly_salary` int(7),
  -- `start_date` date DEFAULT NULL,
  `start_date` varchar(10) DEFAULT NULL,
  `employment_status` varchar(30),
  `manager_id` int(11),
  `is_manager` boolean,
  PRIMARY KEY (`employee_id`)  
) ENGINE=InnoDB;

--
-- Dumping data for table `employee`
--
LOCK TABLES `employee` WRITE;
INSERT INTO `employee` (fname, lname, birthday, monthly_salary, position, is_manager) VALUES ('Donald', 'Trump', '1920-12-01', 1, 'Clown', 0), ('Jesus','Christ', '0001-01-01', 2222, 'Admiral', 0), ('Satya','Nadella', '1967-08-19', 5000, 'CEO', 1), ('William','Adama', '1990-01-01', 4894, 'Admiral', 0), ('Donald','Duck', '2100-06-25', 4000, 'Captain', 1), ('David','Chen', '1989-08-14', 64968, 'Frontend Engineer', 0), ('Ryan','Yun', '1993-04-20', 999649, 'Intern', 1);
UNLOCK TABLES;

-- Add recursive relation employee to employee
ALTER TABLE `employee`
ADD FOREIGN KEY (`manager_id`) REFERENCES `employee` (`employee_id`) ON DELETE CASCADE;

-- Add managers to employees
LOCK TABLES `employee` WRITE;
UPDATE `employee` SET `manager_id` = 1 WHERE employee_id = 4;
UPDATE `employee` SET `manager_id` = 2 WHERE employee_id = 3;
UPDATE `employee` SET `manager_id` = 3 WHERE employee_id = 2;
UPDATE `employee` SET `manager_id` = 4 WHERE employee_id = 1;
UNLOCK TABLES;

--
-- Table structure for table `department`
--
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `head_id` int(11),
  `est_date` date,
  `branch_id` int(11),
  `dep_name` varchar(50),
  PRIMARY KEY (`department_id`),
  FOREIGN KEY (`head_id`) REFERENCES `employee` (`employee_id`) ON DELETE CASCADE
) ENGINE=InnoDB;

--
-- Dumping data for table `department`
--
LOCK TABLES `department` WRITE;
INSERT INTO `department` (head_id, dep_name) VALUES (1, 'Accounting'), (2, 'Engineering'), (3, 'Sales'), (4, 'Human Resource');
UNLOCK TABLES;

-- Add foreign key to department table in employee table
ALTER TABLE `employee`
ADD FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE CASCADE;

-- Add departments to employees
LOCK TABLES `employee` WRITE;
UPDATE `employee` SET `department_id` = 1 WHERE employee_id = 7;
UPDATE `employee` SET `department_id` = 2 WHERE employee_id = 3;
UPDATE `employee` SET `department_id` = 3 WHERE employee_id = 2;
UPDATE `employee` SET `department_id` = 4 WHERE employee_id = 4;
UPDATE `employee` SET `department_id` = 3 WHERE employee_id = 5;
UPDATE `employee` SET `department_id` = 4 WHERE employee_id = 1;
UPDATE `employee` SET `department_id` = 1 WHERE employee_id = 6;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--
DROP TABLE IF EXISTS `branch`;
CREATE TABLE `branch` (
  `branch_id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(75) NOT NULL,
  `state` varchar(50) DEFAULT 'N/A',
  `country` varchar(75) NOT NULL,  
  PRIMARY KEY (`branch_id`)  
) ENGINE=InnoDB;

--
-- Dumping data for table `branch`
--
LOCK TABLES `branch` WRITE;
INSERT INTO `branch` (city, state, country) VALUES ('Seoul', 'N/A', 'South Korea'), ('Taipei', 'N/A', 'Taiwan'), ('Chicago', 'Illinois', 'USA'), ('Portland', 'Oregon', 'USA');
UNLOCK TABLES;

-- Add foreign key to branch table in department table
ALTER TABLE `department`
ADD FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE CASCADE;

-- Add branches for to departments
LOCK TABLES `department` WRITE;
UPDATE `department` SET `branch_id` = 1 WHERE department_id = 4;
UPDATE `department` SET `branch_id` = 2 WHERE department_id = 3;
UPDATE `department` SET `branch_id` = 3 WHERE department_id = 2;
UPDATE `department` SET `branch_id` = 4 WHERE department_id = 1;
UNLOCK TABLES;

--
-- Table structure for table `certification`
--
DROP TABLE IF EXISTS `certification`;
CREATE TABLE `certification` (
  `certification_id` int(11) NOT NULL AUTO_INCREMENT,
  `cert_name` varchar(100) NOT NULL,
  `issued_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`certification_id`)  
) ENGINE=InnoDB;

--
-- Dumping data for table `certification`
--
LOCK TABLES `certification` WRITE;
INSERT INTO `certification` (cert_name, issued_by) VALUES ('CPA', 'NASBA'), ('AWS Solutions Architect', 'Amazon'), ('Clown', 'Ringling Bros');
UNLOCK TABLES;

--
-- Table structure for table `employee_certification`
--
DROP TABLE IF EXISTS `employee_certification`;
CREATE TABLE `employee_certification` (
  `employee_id` int UNSIGNED NOT NULL,
  `certification_id` SMALLINT UNSIGNED NOT NULL,
  `expiration_date` date,
  PRIMARY KEY pk_employee_certification (`employee_id`, `certification_id`)  
) ENGINE=InnoDB;

--
-- Dumping data for table `employee_certification`
--
LOCK TABLES `employee_certification` WRITE;
INSERT INTO `employee_certification` (employee_id, certification_id) VALUES (1, 3), (3, 1), (6, 2), (7, 2);
UNLOCK TABLES;

SET FOREIGN_KEY_CHECKS=1;

-- NOTES
--
-- Dumping data for table `employee_certification`
--

-- LOCK TABLES `employee_certification` WRITE;
-- INSERT INTO `employee_certification` (employee_id, certification_id) VALUES (1, 1), (1, 2), (2, 1);
-- UNLOCK TABLES;
-- dropping FK constraint: http://www.mysqltutorial.org/mysql-foreign-key/

-- To obtain the generated constraint name of a table, you use the SHOW CREATE TABLE statement as follows:
-- SHOW CREATE TABLE table_name;

-- ALTER TABLE table_name 
-- DROP FOREIGN KEY constraint_name;

-- END NOTES









-- REMOVED TABLE
--
-- Table structure for table `position`
--
-- DROP TABLE IF EXISTS `position`;
-- CREATE TABLE `position` (
--   `position_id` int(11) NOT NULL AUTO_INCREMENT, 
--   `title` varchar(50) NOT NULL,
--   `is_management` boolean,
--   `salary_tier` int(2),
--   PRIMARY KEY (`position_id`)  
-- ) ENGINE=InnoDB;

-- --
-- -- Dumping data for table `position`
-- --
-- LOCK TABLES `position` WRITE;
-- INSERT INTO `position` (title) VALUES ('Frontend Engineer'), ('Backend Engineer'), ('Chief Executive Officer'), ('Project Manager');
-- UNLOCK TABLES;

-- -- Add foreign key to position table in employee table
-- ALTER TABLE `employee`
-- ADD FOREIGN KEY (`position_id`) REFERENCES `position` (`position_id`) ON DELETE SET NULL;


