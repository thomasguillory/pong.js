@pong.controller 'PongCtrl', ($scope, $window) ->
  $scope.player1 =
    y: 50
    score: 0

  $scope.player2 =
    y: 50
    score: 0

  $window.addEventListener 'keydown', (event) ->
    move = switch event.keyCode
      when 38
        -4
      when 40
        4
      else
        0

    $scope.$apply ->
      $scope.player1.y += move
