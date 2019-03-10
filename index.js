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

// employees 

// load employee page
app.get("/employees", (req, res) => {

  let query = `SELECT employee.*, department.dep_name, branch.city FROM employee             
               left join department using(department_id)
               left join branch using(branch_id);` 
               
  let data = {}
  
  db.query(query, (err, result) => {
		if (err) {      
			res.redirect('/');
    }   

    data.employee = result
    
    // let query = `SELECT branch_id, city FROM branch;`
    let query = `SELECT department.department_id, department.dep_name, branch.city FROM department
                 left join branch using(branch_id);`
    
    db.query(query, (err, result) => {
      if (err) {
        res.redirect('/');
      }                
      
      data.departments = result   
      
      console.log(data)
  
      res.render('employees', {
        data: data
      });
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

  let query = "INSERT INTO `employee` (fname, lname, birthday, monthly_salary, start_date, employment_status, department_id) VALUES ('" +
      fname + "', '" + lname + "', '" + birthday + "', '" + salary + "', '" + start + "', '" + status + "', '" + department + "')"

	
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
        
// departments
app.get("/departments", (req, res) => {
	let query = `SELECT * FROM department`;

	db.query(query, (err, result)=>
	{
		if(err)
		{
			res.redirect('/');
		}
		res.render('departments', {
		department:result
		});
	})
});

app.post("/departments", (req, res) => {  

	let deptName= req.body["department-name"]; 
  
	let query = "INSERT INTO `department` (name) VALUES ('" +
		deptName + "')";
  
	db.query(query, (err, result) => {
		if (err) {
			return res.status(500).send(err);
		}
		res.redirect('/departments');
	});  
});

// branches
app.get("/branches", function(req, res){ // BRANCH GET REQUEST

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

app.post("/branches", (req, res) => { // BRANCH POST REQUEST

	let branchCity= req.body["branch-city"]; 
	let branchCountry = req.body["branch-country"];
  
	let query = "INSERT INTO `branch` (city_name, country) VALUES ('" +
		branchCity + "', '" + branchCountry + "')";
  
	db.query(query, (err, result) => {
		if (err) {
			return res.status(500).send(err);
		}
		res.redirect('/branches');
	});  
});

// positions
app.get("/positions", (req, res) => { // POSITIONS GET REQUEST
	let query = `SELECT * FROM position`;

	db.query(query, (err, result)=>
	{
		if(err)
		{
			res.redirect('/');
		}
		res.render('positions', {
		position:result
		});
	})
});

app.post("/positions", (req, res) => {   // POSITIONS POST REQUEST

	let titleName= req.body["title"]; 
	let manageStat = req.body["manager-role"];
  
	let query = "INSERT INTO `position` (title, managerial_duties) VALUES ('" +
		titleName + "', '" + manageStat + "')";
  
	db.query(query, (err, result) => {
		if (err) {
			return res.status(500).send(err);
		}
		res.redirect('/positions');
	});  
});

app.listen(app.get('port'), function(){
console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});