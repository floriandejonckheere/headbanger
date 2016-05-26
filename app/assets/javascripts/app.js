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
    .when('/signup', {
      templateUrl: template('signup.html')
    })
    .when('/whats-new', {
      templateUrl: template('whats-new.html')
    })
    .when('/by-genre', {
      templateUrl: template('by-genre.html')
    })
    .when('/by-country', {
      templateUrl: template('by-country.html')
    })
    .when('/by-label', {
      templateUrl: template('by-label.html')
    })
    .when('/my-account', {
      templateUrl: template('my-account.html')
    })
    .when('/preferences', {
      templateUrl: template('preferences.html')
    })
    .otherwise({
      redirectTo: '/app'
    });
});
