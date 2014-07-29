(function() {
  this.pongGame = angular.module('pongGame', []);

}).call(this);
(function() {
  this.pongGame.factory('Ball', function() {
    var Ball;
    return Ball = (function() {
      Ball.WIDTH = 30;

      Ball.HEIGHT = 30;

      Ball.ACCELERATION = 0.02;

      function Ball(options) {
        this.game = options.game;
        this.paddle1 = this.game.player1.paddle;
        this.paddle2 = this.game.player2.paddle;
        this.RELATIVE_WIDTH = 100 * this.constructor.WIDTH / this.game.width;
        this.RELATIVE_HEIGHT = 100 * this.constructor.HEIGHT / this.game.height;
        this.game.socket.on('ball.position', (function(_this) {
          return function(x, y) {
            return _this.moveTo(x, y);
          };
        })(this));
      }

      Ball.prototype.moveTo = function(x, y) {
        this.x = x;
        return this.y = y;
      };

      return Ball;

    })();
  });

}).call(this);
(function() {
  this.pongGame.factory('Game', function(Player, Ball) {
    var Game;
    return Game = (function() {
      function Game(socket, width, height) {
        this.socket = socket;
        this.width = width;
        this.height = height;
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
        this._events = {};
      }

      Game.prototype.on = function(event, handler) {
        var _base;
        (_base = this._events)[event] || (_base[event] = []);
        return this._events[event].push(handler);
      };

      Game.prototype.trigger = function(event) {
        var handler, _i, _len, _ref, _results;
        _ref = this._events[event];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          handler = _ref[_i];
          _results.push(handler());
        }
        return _results;
      };

      return Game;

    })();
  });

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.pongGame.factory('Paddle', function() {
    var Paddle;
    return Paddle = (function() {
      Paddle.WIDTH = 2;

      Paddle.HEIGHT = 25;

      Paddle.SPEED = 2;

      function Paddle(options) {
        this.select = __bind(this.select, this);
        this.player = options.player;
        this.selected = false;
        this.position = 50;
        this.dy = 0;
        this.player.game.socket.on("player" + this.player.id + ".paddle.position", (function(_this) {
          return function(y) {
            return _this.moveTo(y);
          };
        })(this));
      }

      Paddle.prototype.select = function() {
        return this.selected = true;
      };

      Paddle.prototype.moveTo = function(y) {
        return this.position = y;
      };

      return Paddle;

    })();
  });

}).call(this);
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.pongGame.factory('Player', function(Paddle) {
    var Player;
    return Player = (function() {
      function Player(options) {
        this.select = __bind(this.select, this);
        this.id = options.id;
        this.game = options.game;
        this.score = 0;
        this.paddle = new Paddle({
          player: this
        });
        this.game.socket.on("player" + this.id + ".score", (function(_this) {
          return function(score) {
            return _this.updateScore(score);
          };
        })(this));
      }

      Player.prototype.select = function() {
        return this.paddle.select();
      };

      Player.prototype.updateScore = function(score) {
        return this.score = score;
      };

      return Player;

    })();
  });

}).call(this);
