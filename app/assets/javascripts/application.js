//= require_tree .
//= require angular/angular.min
//= require_tree ./angular
//
//= require angular-route/angular-route
//= require ./templates
//
//= require_tree ../templates

(function(){
  var headbanger = angular.module('headbanger', [
    'templates',
    'ngRoute',
    'controllers'
  ]);

  headbanger.config(function($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'app.html',
        controller: 'AppController'
      })
      .when('/signup', {
        templateUrl: 'signup.html',
        controller: 'AuthController'
      })
      .when('/signin', {
        templateUrl: 'signin.html',
        controller: 'AuthController'
      });
  });
});
