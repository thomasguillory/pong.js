@pongGame.factory 'Game', (Player, Ball) ->
  class Game
    constructor: (@socket, @width, @height) ->
      # Basic objects
      @player1 = new Player
        id: 1
        game: @
      @player2 = new Player
        id: 2
        game: @
      @ball = new Ball
        game: @

      # Other internals
      @_events          = {}

    on: (event, handler) ->
      @_events[event] ||= []
      @_events[event].push handler

    trigger: (event) ->
      handler() for handler in @_events[event]
