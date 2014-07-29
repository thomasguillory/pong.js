(function() {
  this.pong.directive('paddle', function() {
    return {
      restrict: 'E',
      scope: {
        paddle: '='
      },
      replace: true,
      template: "<div class='paddle'></div>",
      link: function(scope, element) {
        element.css({
          width: "" + scope.paddle.constructor.WIDTH + "%",
          height: "" + scope.paddle.constructor.HEIGHT + "%"
        });
        element.css({
          marginTop: "" + (-element[0].offsetHeight / 2) + "px"
        });
        scope.$watch('paddle.position', function(position) {
          return element.css('top', "" + position + "%");
        });
        return scope.$watch('paddle.selected', function(selected) {
          if (selected) {
            return element.css('background', '#990000');
          } else {
            return element.css('background', null);
          }
        });
      }
    };
  });

}).call(this);
