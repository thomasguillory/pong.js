// Generated by CoffeeScript 1.7.1
(function() {
  var Game, games, io, server;

  io = require('socket.io');

  Game = require('./models/game.js').Game;

  games = [];

  server = io.listen(3000);

  server.on('connection', function(socket) {
    var game;
    game = null;
    return socket.on('join', function(uuid) {
      games[uuid] || (games[uuid] = new Game);
      game || (game = games[uuid]);
      game.addParticipant(socket);
      return game.run();
    });
  });

}).call(this);