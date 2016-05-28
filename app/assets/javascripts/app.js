function t(filename) {
  return '/assets/templates/' + filename + '.html';
}

var headbanger = angular.module('headbanger', [
  'ui.router',
  'Devise'
]);

headbanger.config(function($httpProvider, $stateProvider, $urlRouterProvider) {
  $httpProvider.defaults.withCredentials = true;

  $urlRouterProvider.otherwise('/app');

  $stateProvider
    /** Main application **/
    .state({
      name: 'app',
      abstract: true,
      url: '/app',
      controller: 'AppController',
      templateUrl: t('app')
    })
      .state({
        name: 'app.whats-new',
        url: '/whats-new',
        templateUrl: t('app/whats-new')
      })
      .state({
        name: 'app.by-genre',
        url: '/by-genre',
        templateUrl: t('app/by-genre')
      })
      .state({
        name: 'app.by-country',
        url: '/by-country',
        templateUrl: t('app/by-country')
      })
      .state({
        name: 'app.by-label',
        url: '/by-label',
        templateUrl: t('app/by-label')
      })
      .state({
        name: 'app.my-account',
        url: '/my-account',
        templateUrl: t('app/my-account')
      })
      .state({
        name: 'app.preferences',
        url: '/preferences',
        templateUrl: t('app/preferences')
      })

    /** Devise **/
    .state({
      name: 'signin',
      url: '/signin',
      templateUrl: t('signin'),
      controller: 'SigninController'
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
