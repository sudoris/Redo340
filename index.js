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

// CHANGE THIS %%%
const port = process.env.port || 5191;
// app.set('port', process.argv[2]);

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use(express.static("./public"));

// app.use("/api", require("./routes/api"));

// error handling middleware
app.use((err, req, res, next) => {
	res.status(450).send({error: err.message});
});

app.get("/", (req, res) => {
	res.render('index');
});

app.get("/index", (req, res) => {
	res.render('index');
});
/* --------------------------------------------------------------------------------------- */
/* ---------------------------------- EMPLOYEES ------------------------------------------ */
/* --------------------------------------------------------------------------------------- */
app.get("/employees", (req, res) => {
	let query = `SELECT * FROM employee`;

	db.query(query, (err, result)=>
	{
		if(err)
		{
			res.redirect('/');
		}
		res.render('employees', {
		employee:result
		});
	}) 
});

app.post("/employees", (req, res) => {  

  let fname = req.body["first-name"];
  let lname = req.body["last-name"];
  let birthday = req.body.birthday;
  let salary = req.body.["monthly-salary"];
  let startDate = req.body["start-date"];
  let employeeStatus = req.body["employee-stat"];  

  let query = "INSERT INTO `employee` (fname, lname, birthday, monthly_salary, start_date, employment_status) VALUES ('" +
      fname + "', '" + lname + "', '" + birthday + "', '" + salary + "', '" + startDate + "', '" + employeeStatus + "')";

	
  db.query(query, (err, result) => {
      if (err) {
          return res.status(500).send(err);
      }
      res.redirect('/employees');
  });  
});
/* ----------------------------------------------------------------------------------------- */
/* ---------------------------------- DEPARTMENTS ------------------------------------------ */
/* ----------------------------------------------------------------------------------------- */
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

/* -------------------------------------------------------------------------------------- */
/* ---------------------------------- BRANCHES ------------------------------------------ */
/* -------------------------------------------------------------------------------------- */
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
/* --------------------------------------------------------------------------------------- */
/* ---------------------------------- POSITIONS ------------------------------------------ */
/* --------------------------------------------------------------------------------------- */
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

/* ---------------------------------------------------------------------------------------- */

app.listen(port, () => {
	console.log("Server now listening on PORT:" + port);
});

// CHANGE THIS @@
//app.listen(app.get('port'), function(){
//console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
//});