const express = require('express')

const app = express();
const cors = require('cors')

//Settings
app.set('port', process.env.PORT || 4000);

//Middlewares
app.use(express.json());
app.use(cors());

//Routes
app.use(require('./routes/customer'));


//Starting the server
app.listen(app.get('port'), () => {
    console.log('Server is running on port ', app.get('port'));
});