(function() {
  var app, express;

  express = require('express');

  app = express.createServer();

  app.get('/', function(req, res) {
    return res.send('node.js coffee script sample');
  });

  app.listen(3000);

}).call(this);
