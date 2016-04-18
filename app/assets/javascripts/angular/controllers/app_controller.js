angular.module('controllers')
  .controller('AppController',
    ['$scope', '$routeParams', '$location',
      function($scope, $routeParams, $location) {
        console.log('AppController');
      }
    ]
  );
