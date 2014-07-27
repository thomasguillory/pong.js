@pongGame.factory 'Player', (Paddle) ->
  class Player
    constructor: (options) ->
      @game   = options.game
      @score  = 0
      @paddle = new Paddle

    win: ->
      @score += 1
      @game.ball.initialize()
