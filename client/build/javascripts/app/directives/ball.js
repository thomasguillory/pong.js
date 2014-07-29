(function() {
  this.pong.directive('ball', function() {
    return {
      restrict: 'E',
      scope: {
        ball: '='
      },
      replace: true,
      template: "<div class='ball'></div>",
      link: function(scope, element) {
        element.css({
          width: "" + scope.ball.constructor.WIDTH + "px",
          height: "" + scope.ball.constructor.HEIGHT + "px"
        });
        element.css({
          marginLeft: "" + (-element[0].offsetWidth / 2) + "px",
          marginTop: "" + (-element[0].offsetHeight / 2) + "px"
        });
        scope.$watch('ball.x', function(x) {
          return element.css('left', "" + x + "%");
        });
        return scope.$watch('ball.y', function(y) {
          return element.css('top', "" + y + "%");
        });
      }
    };
  });

}).call(this);
