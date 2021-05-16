var express = require('express');
var app = express();
const {db} = require('./init.js');
const bodyParser = require("body-parser");

//Import Routes
const user = require('./routes/user');
//Routes
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json())

app.use('/users', user);

var server = app.listen(3000);
