const mysql = require('mysql');
const pool = mysql.createPool({
  multipleStatements: true,
  connectionLimit : 10,
  host : 'classmysql.engr.oregonstate.edu',
  user : 'cs340_chend5',
  password : '7530',
  database : 'cs340_chend5'
});

module.exports.pool = pool;