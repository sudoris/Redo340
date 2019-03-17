SELECT employee.*, department.dep_name, branch.city FROM employee             
left join department using(department_id)
left join branch using(branch_id);

SELECT e2.fname AS manager_fname from employee e1, employee e2
WHERE e1.manager_id=e2.employee_id;

SELECT e1.*, e2.fname AS manager_name, department.dep_name, branch.city FROM employee e1    
left join employee e2 ON e1.manager_id=e2.employee_id
left join department ON e1.department_id=department.department_id
left join branch using(branch_id);

SELECT e_c.employee_id, c.cert_name, e.fname FROM employee_certification as e_c
LEFT JOIN employee as e ON e_c.employee_id=e.employee_id
LEFT JOIN certification as c ON e_c.certification_id=c.certification_id;

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



