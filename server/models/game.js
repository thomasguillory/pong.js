var Game = function() {
  this.participants = []
};

Game.prototype.addParticipant = function(socket) {
  this.participants.push(socket);
  socket.emit('ball.position',80,10);
};

exports.Game = Game;
