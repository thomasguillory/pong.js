Paddle = require('./paddle.js').Paddle

class Player
  constructor: (options) ->
    @id     = options.id
    @game   = options.game
    @score  = 0
    @paddle = new Paddle
      player: @
    @participant = null

  updateScore: (score) ->
    @score = score
    @sendValues()

  sendValues: =>
    @game.broadcast "player#{@id}.score", @score

  sendValuesTo: (socket) =>
    socket.emit "player#{@id}.score", @score
    @paddle.sendValuesTo socket

  attach: (socket) =>
    @participant = socket
    @participant.emit "player.election", @id
    @paddle.attach socket

  detach: (socket) =>
    @participant = null

  update: ->
    @paddle.update()

  win: ->
    @updateScore( @score + 1 )
    @game.ball.initialize()

exports.Player = Player
