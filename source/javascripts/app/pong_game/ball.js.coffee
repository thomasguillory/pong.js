@pongGame.factory 'Ball', ->
  class Ball
    WIDTH: 2

    constructor: ->
      @x  = 50
      @y  = 50
      @dx = -0.5
      @dy = 0.15

    update: ->
      # Collisions
      futureX = @x + @dx
      futureY = @y + @dy

      if futureX < 0 or futureX > 100
        @dx = -@dx

      if futureY < 0 or futureY > 100
        @dy = -@dy

      # Movement
      @x += @dx
      @y += @dy
