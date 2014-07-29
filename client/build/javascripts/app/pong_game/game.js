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
