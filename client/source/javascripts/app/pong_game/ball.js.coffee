@pongGame.factory 'Ball', ->
  class Ball
    @WIDTH:  30 # in px
    @HEIGHT: 30 # in px
    @ACCELERATION: 0.02

    constructor: (options) ->
      @game     = options.game
      @paddle1  = @game.player1.paddle
      @paddle2  = @game.player2.paddle

      # Translating px constants in %
      @RELATIVE_WIDTH   = 100 * @constructor.WIDTH  / @game.width
      @RELATIVE_HEIGHT  = 100 * @constructor.HEIGHT / @game.height

      # Bind to socket events
      @game.socket.on 'ball.position', (x,y) =>
        @moveTo(x,y)

    moveTo: (x,y) ->
      @x = x
      @y = y
