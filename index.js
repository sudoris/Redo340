const express = require("express");
const bodyParser = require("body-parser");

// set up express app
const app = express();

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

});

app.get("/departments", (req, res) => {
	res.render('departments');
});

app.get("/branches", (req, res) => {
	res.render('branches');
});

app.get("/positions", (req, res) => {
	res.render('positions');
});

app.listen(port, () => {
	console.log("Server now listening on PORT:" + port);
});
// app.listen(app.get('port'), function(){
//   console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
// });