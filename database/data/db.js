const mysql = require('mysql2');
const config = require('../config.js');

// connect to database
let connection = mysql.createConnection(config.db);

connection.connect(function (err) {
    if (err) throw err;

    console.log("Connected to database!");
});


module.exports = connection.promise();