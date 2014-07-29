@pong.controller 'NewGameCtrl', ($location) ->
  $location.path "/game/#{uuid.v4()}"
