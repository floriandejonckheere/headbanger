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
    ['$scope', '$location', '$state',
      function($scope, $location, $state) {
        $scope.text = 'yes';
        $scope.hasBanner = function() {
          return ($state.banner || false);
        }
      }
    ]
  );
