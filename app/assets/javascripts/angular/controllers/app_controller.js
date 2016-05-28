angular.module('headbanger')
  .controller('AppController',
    ['$scope', '$location',
      function($scope, $location) {

        $scope.$on('devise:login', function(event, currentUser) {
          $scope.currentUser = currentUser;
          console.log('Logged in: ' + currentUser.email);
        });

        $scope.$on('devise:logout', function(event, currentUser) {
          $scope.currentUser = null;
          console.log('Logged out:' + currentUser.email);
        });

        $scope.$on('devise:new-session', function(event, currentUser) {
          $scope.currentUser = currentUser;
          console.log('New session: ' + currentUser);
        });

      }
    ]
  );
