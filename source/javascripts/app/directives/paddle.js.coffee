@pong.directive 'paddle', ->
  restrict: 'E'
  scope:
    paddle: '='
  replace: true
  template: "<div class='paddle'></div>"

  link: (scope, element) ->
    element.css
      width:      "#{scope.paddle.WIDTH}%"
      height:     "#{scope.paddle.HEIGHT}%"

    element.css
      marginTop:  "#{-element[0].offsetHeight / 2}px"

    scope.$watch 'paddle.position', (position) ->
      element.css 'top', "#{position}%"
