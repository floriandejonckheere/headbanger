//= require angular/angular
//= require_tree ./angular
//
//= require angular-rails-templates
//= require angular-route/angular-route
//= require_tree ../templates
//
//= require_tree .
//
var headbanger = angular.module('headbanger', [
  'ngRoute',

  'templates',
  'controllers'
]);

headbanger.config(function($routeProvider) {
  $routeProvider
    .when('/app', {
      templateUrl: 'app.html',
      controller: 'AuthController'
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
