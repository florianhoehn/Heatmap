(function () {
  'use strict';
  angular
  .module('heatmap')
  .config(function($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/home');

    $stateProvider
      .state('home', {
        url: '/'
      });
  });
})();