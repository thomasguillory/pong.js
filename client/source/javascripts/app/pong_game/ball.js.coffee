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

      # Initial position and speed
      # @initialize()

    moveTo: (x,y) ->
      @x = x
      @y = y

    # initialize: ->
    #   @x  = 50
    #   @y  = 50
    #   @dx = -0.5
    #   @dy = 0.15

    # update: ->
    #   # Collisions
    #   #.. the easy one, up and bottom walls
    #   if @y < @RELATIVE_HEIGHT / 2 or @y > (100 - @RELATIVE_HEIGHT / 2)
    #     @dy = -@dy

    #   #.. the hard one, collision with paddles
    #   if @x < @paddle1.constructor.WIDTH + @RELATIVE_WIDTH / 2 and
    #       @y > (@paddle1.position - @paddle1.constructor.HEIGHT / 2 - @RELATIVE_HEIGHT / 2) and
    #       @y < (@paddle1.position + @paddle1.constructor.HEIGHT / 2 + @RELATIVE_HEIGHT / 2)
    #     @_handleBallCollision()

    #   if @x > 100 - @paddle2.constructor.WIDTH - @RELATIVE_WIDTH / 2 and
    #       @y > (@paddle2.position - @paddle2.constructor.HEIGHT / 2 - @RELATIVE_HEIGHT / 2) and
    #       @y < (@paddle2.position + @paddle2.constructor.HEIGHT / 2 + @RELATIVE_HEIGHT / 2)
    #     @_handleBallCollision()

    #   # Lost balls
    #   if @x < 0
    #     @game.player2.win()

    #   if @x > 100
    #     @game.player1.win()

    #   # Movement
    #   @x += @dx
    #   @y += @dy

    # _handleBallCollision: ->
    #   @dx = -@dx * (1 + @constructor.ACCELERATION)
    #   @dy += @paddle1.dy / 5
    #   @game.trigger 'pong'
