io    = require('socket.io')
Game  = require('./models/game.js').Game

games   = []
server = io.listen(3000)

server.on 'connection', (socket) ->
  game = null
  socket.on 'join', (uuid) ->
    games[uuid] ||= new Game
    game        ||= games[uuid]
    game.addParticipant socket
    game.run()
