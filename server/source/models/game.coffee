Player  = require('./player.js').Player
Ball    = require('./ball.js').Ball

class Game
  constructor: (@uuid) ->
    @_participants = []
    @_ons          = []
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
    # TODO add font
    # TODO deployment in prod somewhere + github

    # TODO add players and then viewers

    @run()

  addParticipant: (socket) =>
    @_participants.push socket
    @_ons.forEach (_on) ->
      socket.on(_on...)

    @initParticipant socket

  initParticipant: (socket) =>
    @player1.sendValuesTo socket
    @player2.sendValuesTo socket
    @ball.sendValuesTo socket

  removeParticipant: (socket) =>
    idx = @_participants.indexOf socket
    @_participants.splice idx, 1 if idx > -1

  hasParticipants: =>
    @_participants.length > 0

  on: (args...) =>
    @_ons.push args

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
