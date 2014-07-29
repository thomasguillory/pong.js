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
