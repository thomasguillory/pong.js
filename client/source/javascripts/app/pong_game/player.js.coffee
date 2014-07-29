@pongGame.factory 'Player', (Paddle) ->
  class Player
    constructor: (options) ->
      @id     = options.id
      @game   = options.game
      @score  = 0
      @paddle = new Paddle
        player: @

      # Bind to socket events
      @game.socket.on "player#{@id}.score", (score) =>
        @updateScore score

    select: =>
      @paddle.select()

    updateScore: (score) ->
      @score = score

