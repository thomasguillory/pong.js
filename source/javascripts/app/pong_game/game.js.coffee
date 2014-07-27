@pongGame.factory 'Game', (Player, Ball) ->
  class Game
    constructor: (@width, @height) ->
      @player1 = new Player
        game: @

      @player2 = new Player
        game: @

      @ball = new Ball
        game: @

    update: ->
      @ball.update()

