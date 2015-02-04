var app = angular.module('serbisyou',['angularFileUpload','angularUtils.directives.dirPagination','checklist-model'])
app.config(['$httpProvider',
			'$locationProvider',
			'paginationTemplateProvider',
			 function($httpProvider, $locationProvider, paginationTemplateProvider ) {
			 paginationTemplateProvider.setPath('/assets/dirPagination.tpl.html');
    		 $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';

    		 /*$routeProvider.when('/users/services', {
    		 	templateUrl: "/assets/services.html",
    		 	controller: 'ServicesController'
    		 })
    		 .otherwise({
    		 	redirectTo: '/'
    		 });*/
}])

