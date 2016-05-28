function template(filename) {
  return '/assets/' + filename + '.html';
}

var headbanger = angular.module('headbanger', [
  'ui.router',
  'Devise'
]);

headbanger.config(function($httpProvider, $stateProvider, $urlRouterProvider) {
  $httpProvider.defaults.withCredentials = true;

  $urlRouterProvider.otherwise('/app');

  $stateProvider
    .state('app', {
      url: '/app',
      templateUrl: template('app'),
      controller: 'AppController'
    })
    .state('signin', {
      url: '/signin',
      templateUrl: template('signin'),
      controller: 'SigninController'
    })
    .state('whats-new', {
      url: '/whats-new',
      templateUrl: template('whats-new')
    })
    .state('by-genre', {
      url: '/by-genre',
      templateUrl: template('by-genre')
    })
    .state('by-country', {
      url: '/by-country',
      templateUrl: template('by-country')
    })
    .state('by-label', {
      url: '/by-label',
      templateUrl: template('by-label')
    })
    .state('my-account', {
      url: '/my-account',
      templateUrl: template('my-account')
    })
    .state('preferences', {
      url: '/preferences',
      templateUrl: template('preferences')
    });
});

headbanger.run(['Auth', function (Auth) {
    Auth.currentUser().then(function(user) {
      console.log(user);
      console.log(Auth._currentUser);
    }, function(err) {

      console.error(err);
    });
  }]);
