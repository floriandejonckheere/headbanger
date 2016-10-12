/**
 * app_controller.js - AppController
 *
 * Florian Dejonckheere <florian@floriandejonckheere.be>
 *
 * This file is part of Headbanger
 *
 * */

angular.module('headbanger')
  .controller('AppController',
    ['$scope', '$location', '$state', '$stateParams',
      function($scope, $location, $state, $stateParams) {
        $scope.text = 'yes';
        $scope.banner = function() {
          return ($state.params.banner || false);
        }
        debugger
      }
    ]
  );
