-- Data Definition Queries for Employee Database by David Chen and Ryan Yun for 2018 Winter CS340

--
-- Table structure for table `employee`
--
DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `employee_id` int(11) AUTO_INCREMENT NOT NULL, 
  `fname` varchar(40) NOT NULL,
  `lname` varchar(40) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `department_id` int(11),
  `position_id` int(11),
  `salary_per_month` int(7),
  `start_date` date DEFAULT NULL,
  `employment_status` varchar(30),
  `manager_id` int(11),
  PRIMARY KEY (`employee_id`)  
) ENGINE=InnoDB;

--
-- Dumping data for table `employee`
--
LOCK TABLES `employee` WRITE;
INSERT INTO `employee` (fname, lname, birthday, salary_per_month, employment_status) VALUES ('William','Adama', '1990-01-01', 5000, 'previous'), ('Lee','Adama', '2100-06-25', 4000, 'current'), ('David','Chen', '1989-08-14', 9999, 'current'), ('Ryan','Yun', '1993-04-20', 9999, 'current');
UNLOCK TABLES;

-- Add recursive relation employee to employee
ALTER TABLE `employee`
ADD FOREIGN KEY (`manager_id`) REFERENCES `employee` (`employee_id`) ON DELETE SET NULL;

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
  FOREIGN KEY (`head_id`) REFERENCES `employee` (`employee_id`) ON DELETE SET NULL
) ENGINE=InnoDB;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
INSERT INTO `department` (head_id, dep_name) VALUES (1, 'Accounting'), (2, 'Engineering'), (3, 'Sales'), (4, 'Human Resource');
UNLOCK TABLES;

-- Add foreign key to department table in employee table
ALTER TABLE `employee`
ADD FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE SET NULL;

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
ADD FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE SET NULL;

--
-- Table structure for table `position`
--
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
  `position_id` int(11) NOT NULL AUTO_INCREMENT, 
  `title` varchar(50) NOT NULL,
  `is_management` boolean,
  `salary_tier` int(2),
  PRIMARY KEY (`position_id`)  
) ENGINE=InnoDB;

--
-- Dumping data for table `position`
--
LOCK TABLES `position` WRITE;
INSERT INTO `position` (title) VALUES ('Frontend Engineer'), ('Backend Engineer'), ('Chief Executive Officer'), ('Project Manager');
UNLOCK TABLES;

-- Add foreign key to position table in employee table
ALTER TABLE `employee`
ADD FOREIGN KEY (`position_id`) REFERENCES `position` (`position_id`) ON DELETE SET NULL;

