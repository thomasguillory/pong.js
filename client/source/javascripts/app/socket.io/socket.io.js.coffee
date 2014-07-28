#= require_self
#= require_tree .

@socketIO = angular.module 'socketIO', []
@socketIO.factory 'Socket', ->
  io('http://localhost:3000')
