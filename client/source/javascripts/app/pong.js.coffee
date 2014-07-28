#= require_self
#= require ./pong_game/pong_game.js
#= require_tree ./directives
#= require_tree ./controllers

@pong = angular.module 'pong', ['pongGame']
