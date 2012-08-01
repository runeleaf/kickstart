express = require 'express'
app = express.createServer()

app.get '/', (req, res) ->
  res.send 'node.js coffee script sample'

app.listen 3000
