var io    = require('socket.io');
var Game  = require('./models/game.js').Game;

var games = [];

io.on('connection', function(socket) {
  var game;

  console.log('a user connected');

  socket.on('disconnect', function() {
    console.log('user disconnected');
  });

  socket.on('join', function (uuid) {
    games[uuid] ||= new Game;
    game        ||= games[uuid];
    game.addParticipant(socket);
  });
});

io.listen(3000);
