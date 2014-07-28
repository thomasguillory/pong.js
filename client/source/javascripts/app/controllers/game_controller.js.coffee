@pong.controller 'GameCtrl', ($scope, Game, $window) ->
  playfieldElement = $window.document
                     .getElementsByClassName('playfield')[0]

  $scope.backgroundColor = '#000000'

  # Init Game with view-specific constraints (game size)
  $scope.game = new Game playfieldElement.offsetWidth,
                         playfieldElement.offsetHeight

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

  # Handle PONG! event
  # Load assets
  sounds = [
    new Audio('sounds/pongblipf5.wav'),
    new Audio('sounds/pongblipf4.wav')
  ]
  nextSound = 0

  $scope.game.on 'pong', ->
    $scope.backgroundColor = '#' + Math.floor(Math.random()*16777215).toString(16)

    sounds[nextSound].currentTime = 0
    sounds[nextSound].play()
    nextSound += 1
    nextSound = 0 if nextSound == sounds.length



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

