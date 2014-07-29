#= require_self
#= require_tree .

@socketIO = angular.module 'socketIO', []
@socketIO.factory 'Socket', ->
  io(':3210')
