@pongGame.factory 'Paddle', ->
  class Paddle
    @WIDTH: 2    # % of playfield width
    @HEIGHT: 25  # % of playfield height
    @SPEED: 2

    constructor: (options) ->
      @player   = options.player
      @position = 50
      @dy       = 0

      # Bind to socket events
      @player.game.socket.on "player#{@player.id}.paddle.position", (y) =>
        @moveTo(y)

    moveTo: (y) ->
      @position = y

    # moveUp: (dy) ->
    #   @dy = -@constructor.SPEED

    # moveDown: (dy) ->
    #   @dy = @constructor.SPEED

    # stopMove: ->
    #   @dy = 0

    # update: ->
    #   if @dy < 0 and not (@position < @constructor.HEIGHT / 2)
    #     @position += @dy

    #   if @dy > 0 and not (@position > (100 - @constructor.HEIGHT / 2))
    #     @position += @dy
