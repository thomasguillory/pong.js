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
(function() {
  this.socketIO = angular.module('socketIO', []);

  this.socketIO.factory('Socket', function() {
    return io(':3210');
  });

}).call(this);
(function() {
  this.pong = angular.module('pong', ['ngRoute', 'pongGame', 'socketIO']);

  this.pong.config(function($routeProvider) {
    return $routeProvider.when('/game/new', {
      controller: 'NewGameCtrl',
      templateUrl: 'templates/blank.html'
    }).when('/game/:uuid', {
      controller: 'GameCtrl',
      templateUrl: '/templates/game.html'
    }).otherwise({
      redirectTo: '/game/new'
    });
  });

}).call(this);
(function() {
  this.pong.directive('ball', function() {
    return {
      restrict: 'E',
      scope: {
        ball: '='
      },
      replace: true,
      template: "<div class='ball'></div>",
      link: function(scope, element) {
        element.css({
          width: "" + scope.ball.constructor.WIDTH + "px",
          height: "" + scope.ball.constructor.HEIGHT + "px"
        });
        element.css({
          marginLeft: "" + (-element[0].offsetWidth / 2) + "px",
          marginTop: "" + (-element[0].offsetHeight / 2) + "px"
        });
        scope.$watch('ball.x', function(x) {
          return element.css('left', "" + x + "%");
        });
        return scope.$watch('ball.y', function(y) {
          return element.css('top', "" + y + "%");
        });
      }
    };
  });

}).call(this);
(function() {
  this.pong.directive('paddle', function() {
    return {
      restrict: 'E',
      scope: {
        paddle: '='
      },
      replace: true,
      template: "<div class='paddle'></div>",
      link: function(scope, element) {
        element.css({
          width: "" + scope.paddle.constructor.WIDTH + "%",
          height: "" + scope.paddle.constructor.HEIGHT + "%"
        });
        element.css({
          marginTop: "" + (-element[0].offsetHeight / 2) + "px"
        });
        scope.$watch('paddle.position', function(position) {
          return element.css('top', "" + position + "%");
        });
        return scope.$watch('paddle.selected', function(selected) {
          if (selected) {
            return element.css('background', '#990000');
          } else {
            return element.css('background', null);
          }
        });
      }
    };
  });

}).call(this);
(function() {
  this.pong.controller('GameCtrl', function($scope, $window, $routeParams, Socket, Game, Paddle) {
    var animate, downKeys, nextSound, playfieldElement, sounds, step;
    playfieldElement = $window.document.getElementsByClassName('playfield')[0];
    $scope.game = new Game(Socket, playfieldElement.offsetWidth, playfieldElement.offsetHeight);
    Socket.on('player.election', function(player_id) {
      switch (player_id) {
        case 1:
          return $scope.game.player1.select();
        case 2:
          return $scope.game.player2.select();
      }
    });
    Socket.emit('join', $routeParams.uuid);
    $scope.mode = {
      psych: false,
      sound: false
    };
    $scope.$watch('mode.psych', function(psych) {
      if (!psych) {
        return $scope.backgroundColor = '#000000';
      }
    });
    sounds = [new Audio('sounds/pongblipf5.wav'), new Audio('sounds/pongblipf4.wav')];
    nextSound = 0;
    Socket.on('ball.pong', function() {
      if ($scope.mode.psych) {
        $scope.backgroundColor = '#' + Math.floor(Math.random() * 16777215).toString(16);
      }
      if ($scope.mode.sound) {
        sounds[nextSound].currentTime = 0;
        sounds[nextSound].play();
        nextSound += 1;
        if (nextSound === sounds.length) {
          return nextSound = 0;
        }
      }
    });
    animate = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || function(callback) {
      return window.setTimeout(callback, 1000 / 60);
    };
    downKeys = {};
    $window.addEventListener('keydown', function(event) {
      return downKeys[event.keyCode] = true;
    });
    $window.addEventListener('keyup', function(event) {
      return delete downKeys[event.keyCode];
    });
    step = function() {
      $scope.$apply(function() {
        if (downKeys[38]) {
          return $scope.game.socket.emit('paddle.acceleration', -Paddle.SPEED);
        } else if (downKeys[40]) {
          return $scope.game.socket.emit('paddle.acceleration', Paddle.SPEED);
        } else {
          return $scope.game.socket.emit('paddle.acceleration', 0);
        }
      });
      return animate(step);
    };
    return animate(step);
  });

}).call(this);
(function() {
  this.pong.controller('NewGameCtrl', function($location) {
    return $location.path("/game/" + (uuid.v4()));
  });

}).call(this);
