#!/usr/bin/env node

var http = require('http');

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Pong!');
}).listen(8080, '127.0.0.1');
