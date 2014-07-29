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
