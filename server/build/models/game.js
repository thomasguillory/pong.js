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
      this.emit = __bind(this.emit, this);
      this.on = __bind(this.on, this);
      this.removeParticipant = __bind(this.removeParticipant, this);
      this.addParticipant = __bind(this.addParticipant, this);
      this._participants = [];
      this._ons = [];
      this._timeout = null;
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
      this.run();
    }

    Game.prototype.addParticipant = function(socket) {
      this._participants.push(socket);
      return this._ons.forEach(function(_on) {
        return socket.on.apply(socket, _on);
      });
    };

    Game.prototype.removeParticipant = function(socket) {
      var idx;
      idx = this._participants.indexOf(socket);
      if (idx > -1) {
        this._participants.splice(idx, 1);
      }
      if (this._participants.length === 0) {
        clearTimeout(this._timeout);
        return delete this;
      }
    };

    Game.prototype.on = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return this._ons.push(args);
    };

    Game.prototype.emit = function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return this._participants.forEach(function(participant) {
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
      return this._timeout = setTimeout(this.run, 1000 / 60);
    };

    return Game;

  })();

  exports.Game = Game;

}).call(this);
