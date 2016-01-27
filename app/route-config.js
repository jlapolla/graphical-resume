"use strict";

angular.module("graphical.resume")
.config(["$locationProvider", function($locationProvider){

  // Not using hash URL fragment
  $locationProvider.html5Mode(true);
}])
.config(["$stateProvider", "$urlRouterProvider", function($stateProvider, $urlRouterProvider){

  $urlRouterProvider.otherwise("/demo/");

  $stateProvider
    .state('demo', {
      url: "/demo/",
      templateUrl: "/partials/demo.html",
    });
}]);

