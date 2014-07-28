Player  = require('./player.js').Player
Ball    = require('./ball.js').Ball

class Game
  constructor: ->
    @participants = []

    @player1 = new Player
      id: 1
      game: @
    @player2 = new Player
      id: 2
      game: @
    @ball = new Ball
      game: @

  addParticipant: (socket) ->
    @participants.push socket

  emit: (args...) ->
    @participants.forEach (participant) ->
      participant.emit(args...)

  update: ->
    @player1.update()
    @player2.update()
    @ball.update()

  run: =>
    @update()
    setTimeout @run, 1000 / 60

exports.Game = Game
