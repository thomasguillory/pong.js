#= require ./pong_game/pong_game.js
#= require ./socket.io/socket.io.js
#= require_self
#= require_tree ./directives
#= require_tree ./controllers

@pong = angular.module 'pong', ['ngRoute', 'pongGame','socketIO']

@pong.config ($routeProvider) ->
  $routeProvider
  .when '/game/new',
    controller:   'NewGameCtrl'
    templateUrl:  'templates/blank.html'

  .when '/game/:uuid',
    controller:   'GameCtrl'
    templateUrl:  '/templates/game.html'

  .otherwise
    redirectTo: '/game/new'
