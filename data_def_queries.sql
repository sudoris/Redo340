DDQ
CREATE TABLE `employee` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`fname` varchar(40),
`lname` varchar(40),
`birthday` varchar(10),  
`salary` int,
`start_date` varchar(10),
`employment_status` boolean,
FOREIGN KEY (`manager`) REFERENCES `employee`(`id`) 
PRIMARY KEY (id)
) ENGINE=InnoDB;

--INSERT INTO `employee` VALUES ('Ryan','Yun', '1992-05-21', 9999, '2018-10-01' 
--  (SELECT id from employee WHERE fname = 'David')
--);

-- queries to add fake employee data to db
INSERT INTO `employee` VALUES ('David','Chen', '1985-01-09', 9999, '2017-08-22', true);
INSERT INTO `employee` VALUES ('Ryan','Yun', '1992-05-21', 9999, '2018-10-01', true);
INSERT INTO `employee` VALUES ('Ashley','Porebski', '1988-12-25', 2222, '2019-01-30', true, 2);

CREATE TABLE `employee_to_employee` (
  `employeeId` int(11),
  `managerId` int(11),  
  PRIMARY KEY (`employeeId`,`managerId`),  
  CONSTRAINT `employee_to_branch_fk_1` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`),
  CONSTRAINT `employee_to_branch_fk_2` FOREIGN KEY (`managerId`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `employee_to_branch` (
  `employeeId` int(11),
  `branchId` int(11),  
  PRIMARY KEY (`employeeId`,`branchId`),  
  CONSTRAINT `employee_to_branch_fk_1` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`),
  CONSTRAINT `employee_to_branch_fk_2` FOREIGN KEY (`branchId`) REFERENCES `branch` (`branch_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `employee_to_department` (
  `employee_id` int(11),
  `department_id` int(11),  
  PRIMARY KEY (`employee_id`,`department_id`),  
  CONSTRAINT `employee_to_department_fk1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `employee_to_department_fk2` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `employee_to_position` (
  `employee_id` int(11),
  `position_id` int(11),  
  PRIMARY KEY (`employee_id`,`position_id`),  
  CONSTRAINT `employee_to_position_fk1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`),
  CONSTRAINT `employee_to_position_fk2` FOREIGN KEY (`position_id`) REFERENCES `position` (`position_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `department` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`name` varchar(150),
`employee_count` int,
PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE `department_to_employee` (
  `department_id` int(11),
  `employee_id` int(11),  
  PRIMARY KEY (`department_id`,`employee_id`),  
  CONSTRAINT `department_to_employee_fk1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `department_to_employee_fk2` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `department_to_branch` (
  `department_id` int(11),
  `branch_id` int(11),  
  PRIMARY KEY (`department_id`,`branch_id`),  
  CONSTRAINT `department_to_branch_fk1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `department_to_branch_fk2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `position` (
`position_ID` int(11) NOT NULL AUTO_INCREMENT,
`title` varchar(255),
`managerial_duties` BOOLEAN,
PRIMARY KEY (position_ID)
) ENGINE=InnoDB;

CREATE TABLE `branch`(
`branch_ID` int(11) NOT NULL AUTO_INCREMENT,
`city_name` varchar(255),
`country` varchar(255),
`employee_count` int(11),
PRIMARY KEY (branch_ID)
) ENGINE=InnoDB;

CREATE TABLE `branch_to_department` (
  `branch_ID` int(11),
  `department_ID` int(11),  
  PRIMARY KEY (`branch_ID`,`department_ID`),  
  CONSTRAINT `branch_to_department_fk1` FOREIGN KEY (`branch_ID`) REFERENCES `branch` (`branch_ID`),
  CONSTRAINT `branch_to_department_fk2` FOREIGN KEY (`department_ID`) REFERENCES `department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- add sample data
INSERT INTO `employee` VALUES (6,'Saul','Tigh',NULL,71,'Human');







