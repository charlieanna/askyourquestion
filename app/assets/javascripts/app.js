var app, re;

app = angular.module('App', ['ngAnimate']);

app.factory('fromoutside', function($window, $q, $rootScope) {
  var pusher = new Pusher('4daba8eb6336507df8cf');
       $window.channel = pusher.subscribe('test_channel');
      
   
});