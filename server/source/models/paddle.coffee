class Paddle
  @WIDTH: 2    # % of playfield width
  @HEIGHT: 25  # % of playfield height
  @SPEED: 2

  constructor: (options) ->
    @player = options.player

    @moveTo 50
    @dy = 0

    @player.game.on "player#{@player.id}.paddle.acceleration", (dy) =>
      @dy = dy

  moveTo: (y) ->
    @position = y
    @player.game.emit "player#{@player.id}.paddle.position", y

  update: ->
    if (@dy < 0 and not (@position < @constructor.HEIGHT / 2)) or
        (@dy > 0 and not (@position > (100 - @constructor.HEIGHT / 2)))
      @moveTo( @position + @dy )

exports.Paddle = Paddle
