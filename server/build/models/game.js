// Generated by CoffeeScript 1.7.1
(function() {
  var Ball, Game, Player,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __slice = [].slice;

  Player = require('./player.js').Player;

  Ball = require('./ball.js').Ball;

  Game = (function() {
    function Game() {
      this.run = __bind(this.run, this);
      this.participants = [];
      this.player1 = new Player({
        id: 1,
        game: this
      });
      this.player2 = new Player({
        id: 2,
        game: this
      });
      this.ball = new Ball({
        game: this
      });
    }

    Game.prototype.addParticipant = function(socket) {
      return this.participants.push(socket);
    };

    Game.prototype.emit = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return this.participants.forEach(function(participant) {
        return participant.emit.apply(participant, args);
      });
    };

    Game.prototype.update = function() {
      this.player1.update();
      this.player2.update();
      return this.ball.update();
    };

    Game.prototype.run = function() {
      this.update();
      return setTimeout(this.run, 1000 / 60);
    };

    return Game;

  })();

  exports.Game = Game;

}).call(this);