function template(filename) {
  return '/assets/' + filename;
}

var headbanger = angular.module('headbanger', [
  'ngRoute'
]);

headbanger.config(function($routeProvider) {
  $routeProvider
    .when('/app', {
      templateUrl: template('app.html'),
      controller: 'AppController'
    })
    .when('/signin', {
      templateUrl: template('signin.html'),
      controller: 'SigninController'
    })
    .otherwise({
      redirectTo: '/app'
    });
});
