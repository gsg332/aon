<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/module/survey/inc_header.jsp"%>

<script>
var coupon = angular.module('coupon', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize', 'Filters'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
}).config(function($routeProvider){
	$routeProvider.when('/', {
		templateUrl : jcontext.getContextPath('/module/survey/coupon/novalid.aon')
	}).when('/createCoupon/:email/:surveyid', {
		controller : 'couponCreateController',
		templateUrl : jcontext.getContextPath('/module/survey/coupon/createCoupon.aon')
	}).when('/show/:email/:couponnum', {
		controller : 'couponShowController',
		templateUrl : jcontext.getContextPath('/module/survey/coupon/showCoupon.aon')
	}).when('/alreadyJoin', {
		templateUrl : jcontext.getContextPath('/module/survey/coupon/alreadyJoin.aon')
	}).when('/alreadyUse', {
		templateUrl : jcontext.getContextPath('/module/survey/coupon/alreadyUse.aon')
	}).otherwise({
		redirectTo : '/'
	});	
});

coupon.controller('couponCreateController', function($scope, $rootScope, $routeParams, $location, $route, safeApply) {
	var data = jcontext.loadJSON('/module/survey/coupon/create.json?email='+$routeParams.email+'&surveyid='+$routeParams.surveyid);
	console.log(data);
	
	if(data.checkAlready){
		$location.path('/alreadyJoin');
	} else if(!data.checkUser){
		$location.path('/');
	}
	else{
		$location.path('/show/'+data.email+'/'+data.couponnum);
	}
});

coupon.controller('couponShowController', function($scope, $rootScope, $routeParams, $location, $route, safeApply) {
	var data = jcontext.loadJSON('/module/survey/coupon/show.json?email='+$routeParams.email+'&couponNum='+$routeParams.couponnum);
	if(data.error){
		$location.path('/');
	} else	if(data.item.use){
		$location.path('/');
	}
	console.log(data.item);
	$scope.item = data.item;	
	$scope.useCoupon = function(){
		if(confirm(i18n.getLang('survey','use'))){
			var use = jcontext.loadJSON('/module/survey/coupon/use.json?email='+$routeParams.email+'&couponNum='+$routeParams.couponnum);
			if(use.item.use) {
				$location.path('/alreadyUse');
			} else {
				$location.path('/');
			}
		}
	}
	$scope.sendEmail = function(){
		if(confirm('send email?')){
			var mail = jcontext.loadJSON('/module/survey/coupon/sendEmail.json?email='+$routeParams.email+'&couponNum='+$routeParams.couponnum);
			if(mail.status == "success"){
				alert("Send mail success");
			} 
			if(mail.status == "fail"){
				alert("Send mail fail");
			}
		}
	}
});
</script>

<div ng-app="coupon">  
	<div ng-view></div>
</div>
