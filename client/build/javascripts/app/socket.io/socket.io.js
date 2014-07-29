(function() {
  this.socketIO = angular.module('socketIO', []);

  this.socketIO.factory('Socket', function() {
    return io(':3210');
  });

}).call(this);
