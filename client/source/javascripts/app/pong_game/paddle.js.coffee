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

    moveUp: (dy) ->
      @player.game.socket.emit  "player#{@player.id}.paddle.acceleration",
                                -@constructor.SPEED

    moveDown: (dy) ->
      @player.game.socket.emit  "player#{@player.id}.paddle.acceleration",
                                @constructor.SPEED

    stopMove: ->
      @player.game.socket.emit  "player#{@player.id}.paddle.acceleration",
                                0
