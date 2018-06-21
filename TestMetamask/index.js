const express = require('express');
const hbs = require('hbs');
const app = express();
const path = require('path');
const PORT = process.env.PORT || 5000
// const publicPath = path.join(__dirname,'./static');

app.set('view engine','hbs');

// app.use(express.static(publicPath));

app.get('/', function (req, res) {
  res.render('testJavier.hbs')
})


app.listen(PORT, () => console.log(`http://localhost:${ PORT }`));
