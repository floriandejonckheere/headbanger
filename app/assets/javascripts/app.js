/**
 * app.js - Application
 *
 * Florian Dejonckheere <florian@floriandejonckheere.be>
 *
 * This file is part of Headbanger
 *
 * */

function t(filename) {
  return '/assets/templates/' + filename + '.html';
}

var headbanger = angular.module('headbanger', [
  'ui.router',
  'ng-token-auth'
]);

/**
 * Redirection based on authentication status
 *
 * */
var authenticate = function($auth, $state) {
  return $auth.validateUser()
    .catch(function(result) {
      $state.go('signin');
    });
};

headbanger.config(function($httpProvider, $stateProvider, $urlRouterProvider, $authProvider) {
  $httpProvider.defaults.withCredentials = true;

  $stateProvider
    /** Landing page **/
    .state({
      name: 'landing',
      url: '/landing',
      templateUrl: t('landing')
    })
    /** Main application **/
    .state({
      name: 'app',
      url: '/app',
      redirectTo: 'app.whats-new',
      controller: 'AppController',
      templateUrl: t('app'),
      resolve: {
        auth: authenticate
      }
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
        templateUrl: t('app/my-account'),
        controller: 'AccountController'
      })
      .state({
        name: 'app.preferences',
        url: '/preferences',
        templateUrl: t('app/preferences')
      })

    /** Session views **/
    .state({
      name: 'signin',
      url: '/signin',
      templateUrl: t('signin'),
      controller: 'SigninController'
    })
    .state({
      name: 'signup',
      url: '/signup',
      templateUrl: t('signup'),
      controller: 'SignupController'
    })
    .state({
      name: 'signout',
      url: '/signout',
      controller: 'SignoutController'
    })
    .state({
      name: 'privacy-policy',
      url: '/privacy-policy',
      templateUrl: t('privacy-policy')
    });

    $urlRouterProvider.otherwise('app');

    /**
     * API
     *
     * */
    $authProvider.configure({
      apiUrl:                  '/api'
    });
});

headbanger.run(['$auth', '$state', '$rootScope', function ($auth, $state, $rootScope) {

  $rootScope.$on('auth:invalid', function(ev, reason) {
    console.log(reason);
  });
  $rootScope.$on('auth:validation-error', function(ev, reason) {
    console.log(reason);
  });
  $rootScope.$on('auth:login-error', function(ev, reason) {
    console.log(reason);
  });

  $rootScope.$on('$stateChangeStart', function(evt, to, params) {
    if (to.redirectTo) {
      evt.preventDefault();
      $state.go(to.redirectTo, params, { location: 'replace' })
    }
  });
}]);
