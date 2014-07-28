var Game = function() {
  this.participants = []
};

Game.prototype.addParticipant = function(socket) {
  this.participants.push(socket);
  socket.emit('welcome','You have joined the Game');
};

exports.Game = Game;
