Player  = require('./player.js').Player
Ball    = require('./ball.js').Ball

class Game
  constructor: (@uuid) ->
    @_participants = []
    @_timeout      = null

    @player1 = new Player
      id: 1
      game: @
    @player2 = new Player
      id: 2
      game: @
    @ball = new Ball
      game: @

    # TODO include the color of the game
    # TODO include the mode of the game

    # TODO add sounds
    # TODO deployment in prod somewhere + github

    @run()

  addParticipant: (socket) =>
    @_participants.push socket

    # Elect Players
    unless @player1.participant
      @player1.attach socket
    else unless @player2.participant
      @player2.attach socket

    @initParticipant socket

  initParticipant: (socket) =>
    @player1.sendValuesTo socket
    @player2.sendValuesTo socket
    @ball.sendValuesTo socket

  removeParticipant: (socket) =>
    @player1.detach socket if socket == @player1.participant
    @player2.detach socket if socket == @player2.participant

    idx = @_participants.indexOf socket
    @_participants.splice idx, 1 if idx > -1

  hasParticipants: =>
    @_participants.length > 0

  broadcast: (args...) =>
    @_participants.forEach (participant) ->
      participant.emit(args...)

  update: ->
    @player1.update()
    @player2.update()
    @ball.update()

  run: =>
    @update()
    @_timeout = setTimeout @run, 1000 / 60

  stop: =>
    clearTimeout @_timeout

exports.Game = Game
