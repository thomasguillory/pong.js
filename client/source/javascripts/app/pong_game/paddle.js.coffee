@pongGame.factory 'Paddle', ->
  class Paddle
    @WIDTH: 2    # % of playfield width
    @HEIGHT: 25  # % of playfield height
    @SPEED: 2

    constructor: (options) ->
      @player   = options.player
      @selected = false
      @position = 50
      @dy       = 0

      # Bind to socket events
      @player.game.socket.on "player#{@player.id}.paddle.position", (y) =>
        @moveTo(y)

    select: =>
      @selected = true

    moveTo: (y) ->
      @position = y
