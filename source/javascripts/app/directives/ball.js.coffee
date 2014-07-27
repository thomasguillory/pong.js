@pong.directive 'ball', ->
  restrict: 'E'
  scope:
    ball: '='
  replace: true
  template: "<div class='ball'></div>"

  link: (scope, element) ->
    element.css
      width:      "#{scope.ball.WIDTH}%"

    element.css
      height:     "#{-element[0].offsetWidth}px"
      marginLeft: "#{-element[0].offsetWidth / 2}px"
      marginTop:  "#{-element[0].offsetHeight / 2}px"

    scope.$watch 'ball.x', (x) ->
      element.css 'left', "#{x}%"

    scope.$watch 'ball.y', (y) ->
      element.css 'top', "#{y}%"
