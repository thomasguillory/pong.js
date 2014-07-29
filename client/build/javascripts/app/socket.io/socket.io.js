(function() {
  this.socketIO = angular.module('socketIO', []);

  this.socketIO.factory('Socket', function() {
    return io(':5000');
  });

}).call(this);
