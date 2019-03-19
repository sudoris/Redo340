-- get all employee data (no manager name)
SELECT employee.*, department.dep_name, branch.city FROM employee             
left join department using(department_id)
left join branch using(branch_id);

-- get names of managers for all employees
SELECT e2.fname AS manager_fname from employee e1, employee e2
WHERE e1.manager_id=e2.employee_id;

-- get all employees that are managers
SELECT employee_id, fname, lname FROM employee
WHERE is_manager=1;

-- add entry to employee table
INSERT INTO `employee` (fname, lname, birthday, monthly_salary, start_date, employment_status, department_id, manager_id, position) VALUES (...);

-- get all employee data including manager names
SELECT e1.*, e2.fname AS manager_name, department.dep_name, branch.city FROM employee e1    
left join employee e2 ON e1.manager_id=e2.employee_id
left join department ON e1.department_id=department.department_id
left join branch using(branch_id);

-- get list of certifications for all employees
SELECT e_c.employee_id, c.cert_name, e.fname FROM employee_certification as e_c
LEFT JOIN employee as e ON e_c.employee_id=e.employee_id
LEFT JOIN certification as c ON e_c.certification_id=c.certification_id;

-- get data for specific employee by name
SELECT *
FROM 
(
  SELECT e1.*, e2.fname AS manager_fname, e2.lname AS manager_lname, department.dep_name, branch.city 
  FROM employee e1    
  left join employee e2 ON e1.manager_id=e2.employee_id
  left join department ON e1.department_id=department.department_id
  left join branch ON branch.branch_id=department.branch_id
) as e 
WHERE e.fname="Hans";

-- get data for employee by id
SELECT *
FROM 
(
  SELECT e1.*, e2.fname AS manager_fname, e2.lname AS manager_lname, department.dep_name, branch.city 
  FROM employee e1    
  left join employee e2 ON e1.manager_id=e2.employee_id
  left join department ON e1.department_id=department.department_id
  left join branch ON branch.branch_id=department.branch_id
) as e 
WHERE e.employee_id=5;

-- add many to many relationship for employee/certification
INSERT INTO employee_certification(employee_id, certification_id)
SELECT 
   employee_id, certification_id
FROM 
   employee, certification
WHERE certification.cert_name='Attorney at Law' AND
	    employee.employee_id=2;

-- get list of all certifications
SELECT * FROM certification;     

-- get list of certifications for an employee by id
SELECT cert_name
FROM 
( SELECT e_c.employee_id, c.cert_name, e.fname FROM employee_certification as e_c
LEFT JOIN employee as e ON e_c.employee_id=e.employee_id
LEFT JOIN certification as c ON e_c.certification_id=c.certification_id ) as certs
WHERE certs.employee_id=3; 

-- update employee data
UPDATE `employee` SET `fname` = fname, `lname` = lname, `monthly_salary` = monthlySalary, `department_id` = department, `position` = position, `manager_id` = mgr WHERE `employee`.`employee_id` = employee_id;

-- delete employee by id
DELETE FROM employee WHERE employee_id = 5;

-- get data for all departments
SELECT department.dep_name, branch.city, branch.country FROM department INNER JOIN branch ON department.branch_id = branch.branch_id

-- get data for all branches
SELECT branch.branch_id, branch.city, branch.country FROM branch;

-- add entry to department
INSERT INTO `department` (dep_name, branch_id) VALUES  (...)

-- get data for department by id
SELECT * FROM department WHERE department_id=1;

-- update department by id
UPDATE `department` SET `dep_name` = deptName WHERE `department`.`department_id` = department_id;

-- delete department by id
DELETE FROM department WHERE department_id = 1;