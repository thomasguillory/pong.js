@pongGame.factory 'Player', (Paddle) ->
  class Player
    constructor: (options) ->
      @game   = options.game
      @score  = 0
      @paddle = new Paddle

    update: ->
      @paddle.update()

    win: ->
      @score += 1
      @game.ball.initialize()
