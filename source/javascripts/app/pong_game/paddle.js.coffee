@pongGame.factory 'Paddle', ->
  class Paddle
    @WIDTH: 2    # % of playfield width
    @HEIGHT: 25  # % of playfield height
    @SPEED: 2

    constructor: ->
      @position = 50
      @dy       = 0

    moveUp: (dy) ->
      @dy = -@constructor.SPEED

    moveDown: (dy) ->
      @dy = @constructor.SPEED

    stopMove: ->
      @dy = 0

    update: ->
      if @dy < 0 and not (@position < @constructor.HEIGHT / 2)
        @position += @dy

      if @dy > 0 and not (@position > (100 - @constructor.HEIGHT / 2))
        @position += @dy
