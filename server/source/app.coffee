io    = require('socket.io')
Game  = require('./models/game.js').Game

games   = []
server = io.listen(5000)

server.on 'connection', (socket) ->
  game = null
  socket.on 'join', (uuid) ->
    console.log('New join !')
    games[uuid] ||= new Game(uuid)
    game        ||= games[uuid]
    game.addParticipant socket

  socket.on 'disconnect', ->
    # Game can be null in case of reconnection after server crash
    if game?
      game.removeParticipant socket

      unless game.hasParticipants()
        game.stop()
        delete games[game.uuid]
        game = null
