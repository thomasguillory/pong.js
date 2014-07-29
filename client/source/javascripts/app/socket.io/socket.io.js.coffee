#= require_self
#= require_tree .

@socketIO = angular.module 'socketIO', []
@socketIO.factory 'Socket', ->
  io('http://192.168.1.35:3000')
