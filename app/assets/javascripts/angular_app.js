app = angular.module('app', ['ngResource']);

app.config(["$httpProvider", function (httpProvider) {
    httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
    httpProvider.defaults.headers.common['X-Requested-With'] = "XMLHttpRequest"
}]);

