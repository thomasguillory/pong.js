@pongGame.factory 'Game', (Player, Ball) ->
  class Game
    constructor: (@width, @height) ->
      # Basic objects
      @player1 = new Player
        game: @
      @player2 = new Player
        game: @
      @ball = new Ball
        game: @

      # Other internals
      @_events          = {}

    update: ->
      @player1.update()
      @player2.update()
      @ball.update()

    on: (event, handler) ->
      @_events[event] ||= []
      @_events[event].push handler

    trigger: (event) ->
      handler() for handler in @_events[event]
