@pong.controller 'GameCtrl', ($scope, $window, $routeParams
                              Socket, Game, Paddle ) ->

  # Init Game with view-specific constraints (game size)
  playfieldElement = $window.document.getElementsByClassName('playfield')[0]
  $scope.game = new Game Socket,
                         playfieldElement.offsetWidth,
                         playfieldElement.offsetHeight

  # Join game as P1, P2, or visitor
  Socket.on 'player.election', (player_id) ->
    switch player_id
      when 1
        $scope.game.player1.select()
      when 2
        $scope.game.player2.select()

  Socket.emit 'join', $routeParams.uuid

  # Some view specific variables
  $scope.mode =
    psych: false
    sound: false

  $scope.$watch 'mode.psych', (psych) ->
    unless psych
      $scope.backgroundColor = '#000000'

  # Handle PONG! event
  # Load assets
  sounds = [
    new Audio('sounds/pongblipf5.wav'),
    new Audio('sounds/pongblipf4.wav')
  ]
  nextSound = 0

  Socket.on 'ball.pong', ->
    if $scope.mode.psych
      $scope.backgroundColor = '#' + Math.floor(Math.random()*16777215).toString(16)

    if $scope.mode.sound
      sounds[nextSound].currentTime = 0
      sounds[nextSound].play()
      nextSound += 1
      nextSound = 0 if nextSound == sounds.length


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
      if downKeys[38]
        $scope.game.socket.emit 'paddle.acceleration', -Paddle.SPEED
      else if downKeys[40]
        $scope.game.socket.emit 'paddle.acceleration', Paddle.SPEED
      else
        $scope.game.socket.emit 'paddle.acceleration', 0

    animate step

  animate step

