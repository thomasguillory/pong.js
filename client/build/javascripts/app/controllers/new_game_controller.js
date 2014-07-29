(function() {
  this.pong.controller('NewGameCtrl', function($location) {
    return $location.path("/game/" + (uuid.v4()));
  });

}).call(this);
