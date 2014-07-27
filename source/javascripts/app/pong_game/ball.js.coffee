@pongGame.factory 'Ball', ->
  class Ball
    @WIDTH:  30 # in px
    @HEIGHT: 30 # in px

    constructor: (options) ->
      @game = options.game

      # Translating px constants in %
      @RELATIVE_WIDTH   = 100 * @constructor.WIDTH  / @game.width
      @RELATIVE_HEIGHT  = 100 * @constructor.HEIGHT / @game.height

      # Initial position and speed
      @x  = 50
      @y  = 50
      @dx = -0.5
      @dy = 0.15

    update: ->
      # Collisions
      if @x < @RELATIVE_WIDTH / 2 or @x > (100 - @RELATIVE_WIDTH / 2)
        @dx = -@dx

      if @y < @RELATIVE_HEIGHT / 2 or @y > (100 - @RELATIVE_HEIGHT / 2)
        @dy = -@dy

      # Movement
      @x += @dx
      @y += @dy
