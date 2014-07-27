@pongGame.factory 'Game', (Paddle, Ball) ->
  class Game
    constructor: ->
      @player1  =
        score:  0
        paddle: new Paddle

      @player2  =
        score:  0
        paddle: new Paddle

      @ball = new Ball

    update: ->
      @ball.update()

