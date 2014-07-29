io    = require('socket.io')
Game  = require('./models/game.js').Game

games   = []
server = io.listen(3000)

server.on 'connection', (socket) ->
  game = null
  socket.on 'join', (uuid) ->
    console.log('New join !')
    games[uuid] ||= new Game
    game        ||= games[uuid]
    game.addParticipant socket

  socket.on 'disconnect', ->
    # Game can be null in case of reconnection after server crash
    game.removeParticipant socket if game?
