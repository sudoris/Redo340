const express = require("express");
const bodyParser = require("body-parser");
const mysql = require('./dbcon.js');


// set up express app
const app = express();
app.set('mysql', mysql);
global.db = mysql.pool;

// set 
app.use(express.static('public'));
app.set('view engine', 'ejs');

app.set('port', process.argv[2] || 5191);

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// app.use(express.static("./public"));
app.use(express.static(__dirname + '/public'));


// error handling middleware
app.use((err, req, res, next) => {
	res.status(450).send({error: err.message});
});


// main
app.get("/", (req, res) => {
	res.render('index');
});

app.get("/index", (req, res) => {
	res.render('index');
});

//---------------------------------------------------------------------- EMPLOYEES ----------------------------------------------------------------------

// load employee page
app.get("/employees", (req, res) => {

	// query for all employee data
	let query = `SELECT e1.*, e2.fname AS manager_fname, e2.lname AS manager_lname, department.dep_name, branch.city FROM employee e1    
							 left join employee e2 ON e1.manager_id=e2.employee_id
							 left join department ON e1.department_id=department.department_id
							 left join branch using(branch_id);` 
               
  let data = {}
	
	// send query to get data to populate employee table
  db.query(query, (err, result) => {
		if (err) {      
			res.redirect('/');
    }   

		data.employee = result
		
		// query for all departments and branches    
    let query = `SELECT department.department_id, department.dep_name, branch.city FROM department
                 left join branch using(branch_id);`
		
		// send query to get data to populate Branch & Department drop down list in Add Employee form
    db.query(query, (err, result) => {
      if (err) {
        res.redirect('/');
      }                         

      result.sort((a, b) => {
        if(a.city < b.city) { 
          return -1
        } else if (a.city > b.city) { 
          return 1 
        } else {
          return 0
        }        
      })
      
			data.departments = result   
			
			// query for all manangers
			// let query = `SELECT distinct e2.fname, e2.lname, e2.employee_id FROM employee e1    
			// 						 left join employee e2 ON e1.manager_id=e2.employee_id;`

			let query = `SELECT employee_id, fname, lname FROM employee
									 WHERE is_manager=1;`
			
			// send query to get data to populate Manager drop down list in Add Employee form
      db.query(query, (err, result) => {
				if (err) {
					res.redirect('/');
				}                
				
				data.managers = result   				
					
				res.render('employees', {
					data: data
				});
			})   
    })   		
  })   
});

// add employee
app.post("/employees/add", (req, res) => {  

  let fname = req.body.fname
  let lname = req.body.lname
  let birthday = req.body.birthday
  let salary = req.body.salary
  let start = req.body.startdate
	let status = req.body.status
	let department = req.body.department
	let manager = req.body.manager   
	let title = req.body.position
	
	

  let query = "INSERT INTO `employee` (fname, lname, birthday, monthly_salary, start_date, employment_status, department_id, manager_id, position) VALUES ('" +
      fname + "', '" + lname + "', '" + birthday + "', '" + salary + "', '" + start + "', '" + status + "', '" + department + "', '" + manager + "', '" + title + "')"

	
  db.query(query, (err, result) => {
      if (err) {
          return res.status(500).send(err);
      }
      res.redirect('/employees');
  });  
});

// load edit employee page
app.get("/employees/edit/:id", (req, res) => {  

  let query = `SELECT * FROM employee WHERE employee_id="${req.params.id}"`
  
  db.query(query, (err, result)=>
	{
		if(err)
		{
      console.log('err')
			res.redirect('/');
    }
    
    console.log(result[0])

		res.render('edit-employee', {
		  employee: result[0]
		})
	})   	
})

// update employee data in db and redirect to employee page
app.post("/employees/edit/:id", (req, res) => {  
  
  let employee_id = req.body.employee_id
  let fname = req.body["first-name"];
  let lname = req.body["last-name"];
  // let birthday = req.body.birthday;
  let monthlySalary = req.body["monthly-salary"];
  // let startDate = req.body["start-date"];
  // let employeeStatus = req.body["employee-stat"];  

  let query = "UPDATE `employee` SET `fname` = '" + fname + "', `lname` = '" + lname + "', `monthly_salary` = '" + monthlySalary + "' WHERE `employee`.`employee_id` = '" + employee_id + "'";
        db.query(query, (err, result) => {
            if (err) {
                return res.status(500).send(err);
            }
            res.redirect('/employees');
        });
});

// delete employee
app.get("/employees/delete/:id", (req, res) => {      

  let deleteEmployeeQuery = 'DELETE FROM employee WHERE employee_id = "' + req.params.id + '"';
                    
  db.query(deleteEmployeeQuery, (err, result) => {
      if (err) {
          return res.status(500).send(err);
      }
      res.redirect('/employees');
  });
});

//---------------------------------------------------------------------- DEPARTMENTS ----------------------------------------------------------------------

// Load department data
app.get("/departments", (req, res) => {
	let query = `SELECT * FROM department`;

	db.query(query, (err, result)=>
	{
		if(err)
		{
			res.redirect('/');
		}
		res.render('departments', {
		  department: result
		});
	})
});

// Add new department
app.post("/departments", (req, res) => { 

	let deptName= req.body.deptName;
	let deptBranch = req.body.deptBranch;

	let query = "INSERT INTO `department` (dep_name, branch_id) VALUES  ('" +
	deptName + "', '" + deptBranch + "')"
  
	db.query(query, (err, result) => {
		if (err) {
			return res.status(500).send(err);
		}
		res.redirect('/departments');
	});  
});

// Load department edit page
app.get("/departments/edit/:id", (req,res) => {

	let query = `SELECT * FROM department WHERE department_id= "${req.params.id}"`
	
	db.query(query, (err, result)=>
	{
		if(err)
		{
      console.log('err')
			res.redirect('/');
    }
    
		res.render('edit-department', {
		  department: result[0]
		})
	})   	
})

// Update department data in db and redirect to department page
app.post("/departments/edit/:id", (req, res) => {  
  
  let department_id = req.body.department_id
  let deptName = req.body["deptName"];


  let query ="UPDATE `department` SET `dep_name` = '" + deptName + "' WHERE `department`.`department_id` = '" + department_id + "'";
        db.query(query, (err, result) => {
            if (err) {
                return res.status(500).send(err);
						}
            res.redirect('/departments');
        });
});

// Delete departments
app.get("/departments/delete/:id", (req, res) => {      

  let deleteDepartmentQuery = 'DELETE FROM department WHERE department_id = "' + req.params.id + '"';
                    
  db.query(deleteDepartmentQuery, (err, result) => {
      if (err) {
          return res.status(500).send(err);
      }
      res.redirect('/departments');
  });
});

//---------------------------------------------------------------------- BRANCHES ----------------------------------------------------------------------

// Load branch data
app.get("/branches", function(req, res){ 

	let query = `SELECT * FROM branch`;

	db.query(query, (err, result)=>
	{
		if(err)
		{
			res.redirect('/');
		}
		res.render('branches', {
		branch:result
		});
	})
});

// Add branch
app.post("/branches", (req, res) => { 

	let branchCity= req.body.branchCity; 
	let branchCountry = req.body.branchCountry;
  
	let query = "INSERT INTO `branch` (city, country) VALUES ('" +
		branchCity + "', '" + branchCountry + "')";
  
	db.query(query, (err, result) => {
		if (err) {
			return res.status(500).send(err);
		}
		res.redirect('/branches');
	});  
});

// Load edit branch page
app.get("/branches/edit/:id", (req, res) => {  

  let query = `SELECT * FROM branch WHERE branch_id="${req.params.id}"`
  
  db.query(query, (err, result)=>
	{
		if(err)
		{
      console.log('err')
			res.redirect('/');
    }
    
		res.render('edit-branch', {
		  branch: result[0]
		})
	})   	
})

// Update branch data in db and redirect to branch page
app.post("/branches/edit/:id", (req, res) => {  
  
  let branch_id = req.body.branch_id
	let branchCity = req.body["branchCity"];
	let branchCountry = req.body["branchCountry"];


  let query = "UPDATE `branch` SET `city` = '" + branchCity + "', `country` = '" + branchCountry + "' WHERE `branch`.`branch_id` = '" + branch_id + "'";
		 
					db.query(query, (err, result) => {
						if (err) {
                return res.status(500).send(err);
						}
						res.redirect('/branches');
	});
});

// Delete branch
app.get("/branches/delete/:id", (req, res) => {      

  let deleteBranchQuery = 'DELETE FROM branch WHERE branch_id = "' + req.params.id + '"';
                    
  db.query(deleteBranchQuery, (err, result) => {
      if (err) {
          return res.status(500).send(err);
      }
      res.redirect('/branches');
  });
});


//---------------------------------------------------------------------- CERTIFICATIONS ----------------------------------------------------------------------
// Load certifications data
app.get("/certifications", (req, res) => { 
	let query = `SELECT * FROM certification`;

	db.query(query, (err, result)=>
	{
		if(err)
		{
			res.redirect('/');
		}
		res.render('certifications', {
			certifications: result
		});
	})
});

// Add new certifications
app.post("/certifications", (req, res) => {

	let certName = req.body.certName; 
	let expDate = req.body.expDate;
  
	let query = "INSERT INTO `certification` (cert_name, expires) VALUES ('" +
		certName + "', '" + expDate + "')";
  
	db.query(query, (err, result) => {
		if (err) {
			return res.status(500).send(err);
		}
		res.redirect('/certifications');
	});  
});

// Load certifications edit page
app.get("/certifications/edit/:id", (req,res) => {

	let query = `SELECT * FROM certification WHERE certification_id= "${req.params.id}"`
	
	db.query(query, (err, result)=>
	{
		if(err)
		{
      console.log('err')
			res.redirect('/');
    }
    
		res.render('edit-certification', {
		  certification: result[0]
		})
	})   	
})

// Update certification data in db and redirect to certficiation page
app.post("/certifications/edit/:id", (req, res) => {  
  
  let certification_id = req.body.certification_id
	let certificationName = req.body["certName"];
	let certificationExpr = req.body["certExpire"];


	let query = "UPDATE `certification` SET `cert_name` = '" + certificationName + "', `expires` = '" + certificationExpr + "' WHERE `certification`.`certification_id` = '" + certification_id + "'";
		 
	db.query(query, (err, result) => {
		if (err) {
				return res.status(500).send(err);
		}
		res.redirect('/certifications');
});
});

// Delete certifications
app.get("/certifications/delete/:id", (req, res) => {      

  let deleteCertificationQuery = 'DELETE FROM certification WHERE certification_id = "' + req.params.id + '"';
                    
  db.query(deleteCertificationQuery, (err, result) => {
      if (err) {
          return res.status(500).send(err);
      }
      res.redirect('/certifications');
  });
});


app.listen(app.get('port'), function(){
console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});

