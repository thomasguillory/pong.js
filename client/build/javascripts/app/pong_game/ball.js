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
