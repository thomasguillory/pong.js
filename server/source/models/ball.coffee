class Ball
  @WIDTH:  2  # in %
  @HEIGHT: 4 # in %
  @ACCELERATION: 0.04

  constructor: (options) ->
    @game     = options.game
    @paddle1  = @game.player1.paddle
    @paddle2  = @game.player2.paddle

    # Initial position and speed
    @initialize()

  initialize: ->
    @moveTo 50, 50
    @dx = -0.5
    @dy = 0.15

  moveTo: (x,y) ->
    @x = x
    @y = y
    @game.emit 'ball.position', x, y

  update: ->
    # Collisions
    #.. the easy one, up and bottom walls
    if @y < @constructor.HEIGHT / 2 or @y > (100 - @constructor.HEIGHT / 2)
      @dy = -@dy

    #.. the hard one, collision with paddles
    if @x < @paddle1.constructor.WIDTH + @constructor.WIDTH / 2 and
        @y > (@paddle1.position - @paddle1.constructor.HEIGHT / 2 - @constructor.HEIGHT / 2) and
        @y < (@paddle1.position + @paddle1.constructor.HEIGHT / 2 + @constructor.HEIGHT / 2)
      @_handleBallCollision()

    if @x > 100 - @paddle2.constructor.WIDTH - @constructor.WIDTH / 2 and
        @y > (@paddle2.position - @paddle2.constructor.HEIGHT / 2 - @constructor.HEIGHT / 2) and
        @y < (@paddle2.position + @paddle2.constructor.HEIGHT / 2 + @constructor.HEIGHT / 2)
      @_handleBallCollision()

    # Lost balls
    if @x < 0
      @game.player2.win()

    if @x > 100
      @game.player1.win()

    # Movement
    @moveTo @x + @dx, @y + @dy

  _handleBallCollision: ->
    @dx = -@dx * (1 + @constructor.ACCELERATION)
    @dy += @paddle1.dy / 5
    # @game.trigger 'pong'

exports.Ball = Ball
