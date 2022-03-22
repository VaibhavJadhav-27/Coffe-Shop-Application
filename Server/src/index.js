const express = require('express')

const app = express();
const cors = require('cors')
const login = require('./routes/login');
const customer = require('./routes/customer');
const menu = require("./routes/menu");

//Settings
app.set('port', process.env.PORT || 4000);

//Middlewares
app.use(express.json());
app.use(cors());

//Routes
app.use("/login", login);
app.use("/customer", customer);
app.use("/menu", menu);


//Starting the server
app.listen(app.get('port'), () => {
    console.log('Server is running on port ', app.get('port'));
});