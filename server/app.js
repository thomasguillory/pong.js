var io    = require('socket.io');
var Game  = require('./models/game.js').Game;

var games   = [];
var server = io.listen(3000);

server.on('connection', function(socket) {
  var game;

  console.log('a user connected');

  socket.on('disconnect', function() {
    console.log('user disconnected');
  });

  socket.on('join', function (uuid) {
    console.log('Receive a demand of join on ' + uuid);
    games[uuid] = games[uuid] || new Game;
    game        = game        || games[uuid];
    game.addParticipant(socket);
  });
});
