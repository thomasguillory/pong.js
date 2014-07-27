@pong.controller 'PongCtrl', ($scope, Game, $element, $window) ->
  # Init Game with view-specific constraints (game size)
  $scope.game = new Game $element[0].offsetWidth,
                         $element[0].offsetHeight

  # TODO: to move out in a service
  animate = window.requestAnimationFrame ||
            window.webkitRequestAnimationFrame ||
            window.mozRequestAnimationFrame ||
            (callback) -> window.setTimeout(callback, 1000/60)

  # Key handling. Could be extracted (TODO)
  downKeys = {}
  $window.addEventListener 'keydown', (event) ->
    downKeys[event.keyCode] = true

  $window.addEventListener 'keyup', (event) ->
    delete downKeys[event.keyCode]

  # Game loop
  step = ->
    $scope.$apply ->
      # Player 1
      if downKeys[38]
        $scope.game.player1.paddle.moveUp()
      else if downKeys[40]
        $scope.game.player1.paddle.moveDown()
      else
        $scope.game.player1.paddle.stopMove()

      # Player 2
      if downKeys[87]
        $scope.game.player2.paddle.moveUp()
      else if downKeys[83]
        $scope.game.player2.paddle.moveDown()
      else
        $scope.game.player2.paddle.stopMove()

      $scope.game.update()

    animate step

  $window.onload = ->
    animate step

