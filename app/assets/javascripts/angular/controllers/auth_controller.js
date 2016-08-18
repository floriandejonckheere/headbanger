/**
 * auth_controller.js - Session controllers
 *
 * Florian Dejonckheere <florian@floriandejonckheere.be>
 *
 * This file is part of Headbanger
 *
 * */

angular.module('headbanger')
  .controller('SigninController',
    ['$scope', '$location', '$auth', '$state',
      function($scope, $location, $auth, $state) {
        $scope.credentials = {};

        $auth.validateUser()
          .then(function(result) {
            $state.go('app');
          });

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
  .controller('SignupController',
    ['$scope', '$location', '$auth', '$state',
      function($scope, $location, $auth, $state) {
        $scope.credentials = {};

        $auth.validateUser()
          .then(function(result) {
            $state.go('app');
          });

        $scope.register = function() {
          $auth.submitRegistration($scope.credentials)
          .then(function(response) {
            $scope.user = response;
            $state.go('signin');
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
