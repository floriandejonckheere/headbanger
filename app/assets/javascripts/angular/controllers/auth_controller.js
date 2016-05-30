angular.module('headbanger')
  .controller('SigninController',
    ['$scope', '$location', '$auth', '$state',
      function($scope, $location, $auth, $state) {
        $scope.credentials = {};

        $scope.authenticate = function() {
          $auth.submitLogin($scope.credentials)
          .then(function(response) {
            $scope.user = response;
            $state.go('app');
          })
          .catch(function(response) {
            $scope.error = response.errors;
          });
        };
      }
    ]
  )
  .controller('SignoutController',
    ['$scope', '$location', '$auth', '$state',
      function($scope, $location, $auth, $state) {
        $auth.signOut().then(function(response) {
          $state.go('signin');
        })
        .catch(function(response) {
        });
      }
    ]
  );
