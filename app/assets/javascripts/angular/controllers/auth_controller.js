angular.module('controllers')
  .controller('AuthController',
    ['$scope', '$routeParams', '$location',
      function($scope, $routeParams, $location) {
        console.log('AuthController');
      }
    ]
  );
