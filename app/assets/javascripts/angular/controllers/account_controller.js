/**
 * account_controller.js - AccountController
 *
 * Florian Dejonckheere <florian@floriandejonckheere.be>
 *
 * This file is part of Headbanger
 *
 * */

angular.module('headbanger')
  .controller('AccountController',
    ['$scope', '$location', '$auth', '$state', '$http',
      function($scope, $location, $auth, $state, $http) {
        $http.get('/api/v1/self').success(function(resp) {
          $scope.self = resp.data;
        });
      }
    ]
  );
