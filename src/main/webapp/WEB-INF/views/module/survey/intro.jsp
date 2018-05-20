<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/module/survey/inc_header.jsp"%>
<script type="text/javascript">
var app = angular.module('intro', ['ngRoute', 'ui.bootstrap','aon.input.directives'])  
.config(function ($httpProvider, $routeProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
	$routeProvider.when('/:surveyid', {
		controller : 'surveyIntroController',
		templateUrl : jcontext.getContextPath('/module/survey/survey_intro.aon')
	}).when('/:surveyid/:lang', {
		controller : 'surveyIntroController',
		templateUrl : function(params){return jcontext.getContextPath('/module/survey/survey_intro.aon?lang='+ params.lang);}
	}).otherwise({
		redirectTo : '/'
	});
})
app.controller('surveyIntroController', function($scope, $rootScope, $routeParams, $location, $window ) {
	$scope.selectLanguage = false;
	if($rootScope.selectLanguage != null && $rootScope.userLanguage!= null){
		 $scope.selectLanguage = $rootScope.selectLanguage;
		 $scope.userLanguage = $rootScope.userLanguage; 
	}
	
	$scope.changeLang = function(){
		$rootScope.selectLanguage = $scope.selectLanguage;
	 	$rootScope.userLanguage = $scope.userLanguage;
	 	$location.path('/'+$routeParams.surveyid+'/'+$scope.userLanguage);
	}
	
	$scope.startSurvey = function (){
		var url = jcontext.getContextPath('/module/survey/index.aon?lang='+$scope.userLanguage);
		if($routeParams.surveyid != null){
			url = url+'#/'+$routeParams.surveyid;
		}
		 $window.location.href = url;
	}
});
</script>
<div role="main" ng-app="intro">
	<div ng-view></div>
</div>
