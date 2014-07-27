@pongGame.factory 'Paddle', ->
  class Paddle
    @WIDTH: 2    # % of playfield width
    @HEIGHT: 25  # % of playfield height

    constructor: ->
      @position = 50

    move: (dx) ->
      if dx < 0 and not (@position < @constructor.HEIGHT / 2)
        @position += dx

      if dx > 0 and not (@position > (100 - @constructor.HEIGHT / 2))
        @position += dx
