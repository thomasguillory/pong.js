@pongGame.factory 'Paddle', ->
  class Paddle
    WIDTH: 2
    HEIGHT: 25

    constructor: ->
      @position = 50

    move: (dx) ->
      futurePosition = @position + dx
      unless futurePosition < 0 or futurePosition > 100
        @position += dx
