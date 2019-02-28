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

const port = process.env.port || 5191;
// app.set('port', process.argv[2]);

app.use(express.static("./public"));

app.use(bodyParser.json());

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

app.get("/positions", (req, res) => {
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

app.listen(port, () => {
	console.log("Server now listening on PORT:" + port);
});

// app.listen(app.get('port'), function(){
//   console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
// });