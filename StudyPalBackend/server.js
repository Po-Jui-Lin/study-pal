var express = require('express');
var app = express();
const {db} = require('./init.js');
const bodyParser = require("body-parser");

//Import Routes
const user = require('./routes/user');
const shop = require('./routes/shop');
const coupon = require('./routes/coupon');
const review = require('./routes/review');
const productImage = require('./routes/productImage');
//Routes
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json())

app.use('/users', user);
app.use('/shops', shop);
app.use('/coupons', coupon);
app.use('/reviews', review);

var server = app.listen(3000);
