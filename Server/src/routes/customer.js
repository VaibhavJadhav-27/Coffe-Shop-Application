const { Router } = require('express');
const router = Router();

const mysqlConnection = require('../database/database');

router.get('/', (req, res) => {
    res.status(200).json('Server is on and database is connected..!!!');
});

router.get('/customer', (req, res) => {
    mysqlConnection.query('select * from customer;', (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
});

module.exports = router;