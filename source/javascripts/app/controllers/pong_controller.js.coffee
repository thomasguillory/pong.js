@pong.controller 'PongCtrl', ($scope, Game, $window) ->
  $scope.game = new Game

  animate = window.requestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            (callback) -> window.setTimeout(callback, 1000/60)

  downKeys = {}
  $window.addEventListener 'keydown', (event) ->
    downKeys[event.keyCode] = true

  $window.addEventListener 'keyup', (event) ->
    delete downKeys[event.keyCode]

  step = ->
    $scope.$apply ->
      # Player 1
      if downKeys[38]
        $scope.game.player1.paddle.move -2
      if downKeys[40]
        $scope.game.player1.paddle.move 2

      # Player 2
      if downKeys[87]
        $scope.game.player2.paddle.move -2
      if downKeys[83]
        $scope.game.player2.paddle.move 2

      $scope.game.update()

    animate step

  $window.onload = ->
    animate step

