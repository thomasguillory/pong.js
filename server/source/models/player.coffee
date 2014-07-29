Paddle = require('./paddle.js').Paddle

class Player
  constructor: (options) ->
    @id     = options.id
    @game   = options.game
    @score  = 0
    @paddle = new Paddle
      player: @

  updateScore: (score) ->
    @score = score
    @sendValues()

  sendValues: =>
    @game.broadcast "player#{@id}.score", @score

  sendValuesTo: (socket) =>
    socket.emit "player#{@id}.score", @score
    @paddle.sendValuesTo socket

  update: ->
    @paddle.update()

  win: ->
    @updateScore( @score + 1 )
    @game.ball.initialize()

exports.Player = Player
