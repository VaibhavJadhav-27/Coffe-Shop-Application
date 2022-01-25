const mysql = require('mysql')

const mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'coffeeshopdb'
});

mysqlConnection.connect(function(error) {
    if (error) {
        console.log(error);
        return error;
    } else {
        console.log('Database is connected ..!!')
    }
});

module.exports = mysqlConnection;