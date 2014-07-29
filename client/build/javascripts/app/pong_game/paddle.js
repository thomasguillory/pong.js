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
