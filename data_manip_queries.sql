-- Data Manipulation Queries for Company Database

-- Queries to Employee Table

-- get all data from employee table 
SELECT * FROM employee

-- add a new employee
INSERT INTO employee (fname, lname, birthdate, salary, employmentStatus) VALUES (:fname, :lname, :birthdate, :salary, :employmentStatus)

-- associate an employee with a branch (Many-to-One relationship addition)
INSERT INTO employee_to_branch (employeeID, branchID) VALUES (:employeeID, :branchID)

-- associate an employee with a department (Many-to-One relationship addition)
INSERT INTO employee_to_department (employeeID, departmentID) VALUES (:employeeID, :departmentID)

-- associate an employee with a position (Many-to-One relationship addition)
INSERT INTO employee_to_position (employeeID, positionID) VALUES (:employeeID, :positionID)

-- associate an employee with an employee (One-to-One relationship addition)
INSERT INTO employee_to_employee (employeeID, employeeID) VALUES (:employeeID, :employeeID)

-- update specific row in employee table
UPDATE employee SET fname = :fname_input, lname = :lname_input, birthday = :birthday_input, branch = :branchID_from_dropdown_menu, department = :departmentID_from_dropdown_menu, position = :positionID_from_dropdown_menu, salary = :salary_input, start_date = :start_date_input, employment_status = :employment_status_input, manager = :managerID_input WHERE id = :employee_ID_from_update_form

-- delete an employee
DELETE FROM employee WHERE id = :employeeID_selected

-- end employee manipulation queries

-- Queries to Department Table

-- get all data from department table 
SELECT * FROM department

-- add a new department
INSERT INTO department (name) VALUES (:name)

-- associate a department with an employee (One-to-One relationship addition)
INSERT INTO department_to_employee (departmentID, employeeID) VALUES (:departmentID, :employeeID)

-- associate a department with a branch (One-to-Many relationship addition)
INSERT INTO department_to_branch (departmentID, branchID) VALUES (:departmentID, :branchID)

-- update specific row in department table
UPDATE department SET name = :name_input, department_head = :departmentheadID_input, branch = :branchID_from_dropdown_menug WHERE id = :department_ID_from_update_form

-- delete a department
DELETE FROM department WHERE id = :departmentID_selected

-- end department manipulation queries

-- Queries to Positions Table

-- get all position's data
SELECT * FROM position

SELECT * FROM position WHERE position_ID=:position_ID

SELECT * FROM position WHERE title=:title
 
SELECT * FROM position WHERE managerial_duties=:managerial_duties

-- add a new position
INSERT INTO position (title, managerial_duties) VALUES (:title, :managerial_duties)

-- update a position's data based on submission of the Update Position form 
UPDATE position SET title = :title_input, managerial_duties = :managerial_input WHERE id= :position_ID

-- delete a position
DELETE FROM position WHERE id = :position_ID_selected

SELECT * FROM position

SELECT * FROM position WHERE name=:name 

-- add a new position
INSERT INTO position (title, managerial_duties) VALUES (:title, :managerial_duties)

-- update a position's data based on submission of the Update Position form 
UPDATE position SET title =: title_input, managerial_duties =: managerial_duties_input WHERE id= :position_ID_of_update_form

-- delete a position
DELETE FROM position WHERE id = :position_ID_selected

-- end position manipulation queries

-- Queries to Branch Table

-- get all branch's data 
SELECT * FROM branch

SELECT * FROM branch WHERE branch_ID=:branch_ID

SELECT * FROM branch WHERE city_name=:city_name
 
SELECT * FROM branch WHERE country =:country

SELECT * FROM branch WHERE department =:department

-- add a new branch
INSERT INTO branch (city_name, country, department) VALUES (:city_name, :country, :department)

-- associate a branch with a department 
INSERT INTO branch_to_department (branch_ID, department_ID) VALUES (:branch_ID, :department_ID)

-- update a branch's data 
UPDATE branch SET city_name = :city_name_input, country =:country_name_input WHERE id= :branch_ID

-- delete a branch
DELETE FROM branch WHERE id = :branch_ID_selected

SELECT * FROM branch

SELECT * FROM branch WHERE branch_ID=:branch_ID 






