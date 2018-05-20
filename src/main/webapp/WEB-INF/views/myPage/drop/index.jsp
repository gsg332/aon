<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">
var app = angular.module('myPageApp', ['ngRoute', 'ui.bootstrap','aon.input.directives','contactUs'])  
.config(function ($httpProvider, $routeProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
	
	$routeProvider.when('/', {
		controller : 'myPageWithdrawalCtl',
		templateUrl : jcontext.getContextPath('/myPage/drop/dropout.aon')
	}).otherwise({
		redirectTo : '/'
	});
})
.service('joinFormSrv', function($location){
	return {};
})
.controller('myPageWithdrawalCtl', function($scope, $routeParams, joinFormSrv, $http, $location, $window) {
 	var id = $routeParams.id;
	$scope.load = function(){
		var data = jcontext.loadJSON('/sys/member/getMemberInfo.json');
		$scope.member = data.memberInfo; 	
	}
	$scope.load();
	
	$scope.goIndex = function(){
		$window.history.back();
	}
	
	$scope.memberWithdrawal = function(){
		
		if($('#answerCheck').is(':checked') == false){
			$('#agreeChk').modal('show');
			return false;
		}
		$http({
			method : 'POST',
			url : jcontext.getCsrfPath('/sys/member/getPasswordCheck.json'),
			data : $.param({
					id : $scope.member.id,
					password : $scope.password
					}),
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		})
		.success(function(data){
			if(data.passwordChk){
				if($scope.memberWithdrawalForm.$valid){
					$scope.$broadcast("SUBMIT");
					   jcontext.formSubmit($('form[name=memberWithdrawalForm]'), jcontext.getLocationPath("/sys/member/memberWithdrawal.json"),{
						   message:i18n.getLang('member','dropMemberSuccess') ,
						   callback: function(data){
 		 	 				   	$('form[name=memberWithdrawalForm]').attr({action:jcontext.getCsrfPath('/securityLogout'), method:'post'}).submit();
						   	}
					   	}
					   ,{ msssage:i18n.getLang('member','dropMemberFail'),
						  callback: function(e){
							  alert(e.status);
						   }
						}
					);
				}
			}else{
				new PageAlert({'type':'danger','title':i18n.getLang('member','password'),'message':i18n.getLang('member','passwordWrong')});
			}
		});
	}
})
</script>
	<!-- sub visual -->
    <%@ include file="/WEB-INF/views/myPage/subVisual.jsp" %>
    <!-- //sub visual -->
 	<!-- contents -->
	<div class="contents" ng-app="myPageApp">
		<div class="container">
			<div class="wrap">
				<!-- navigation -->
				<nav>
				    <ul class="navi">
						<li><a href='<c:url value="/index.aon"/>'><spring:message code='cmm.nav.001'/></a></li>
						<li><a href='<c:url value="/myPage/myInfo/index.aon"/>'><spring:message code='cmm.menu.010'/></a></li>
						<li><spring:message code='cmm.menu.016'/></li>
					</ul>
				</nav>
				<!-- //navigation -->
				
				<!-- sub_con -->
				<div ng-view list-contest></div>
			    <!-- //sub_con -->
				<!-- right_menu -->
				<div class="sub_aside">
				    <div class="rm_top">
				        <h2><spring:message code='cmm.menu.010'/></h2>
	                    <ul class="right_menu">
	                    	<li><a href='<c:url value="/myPage/myInfo/index.aon"/>'><spring:message code='cmm.menu.011'/></a></li>
	                        <li><a href='<c:url value="/myPage/myQuestion/index.aon"/>'><spring:message code='cmm.menu.012'/></a></li>
	                        <li><a href='<c:url value="/myPage/myAnswer/index.aon"/>'><spring:message code='cmm.menu.013'/></a></li>
	                        <li><a href='<c:url value="/myPage/myPoint/index.aon"/>'><spring:message code='cmm.menu.014'/></a></li>
	                        <li><a href='<c:url value="/myPage/member/index.aon"/>'><spring:message code='cmm.menu.015'/></a></li>
	                        <li><a href='<c:url value="/myPage/member/index.aon#/memberUpdateProfileForm"/>'><spring:message code='cmm.menu.017'/></a></li>
	                        <li class="on"><a href='<c:url value="#/"/>'><spring:message code='cmm.menu.016'/></a></li>
	                    </ul>
				    </div>
					<%@ include file="/WEB-INF/views/include/contactUs.jsp" %>
				</div>
				<!-- //right_menu -->
			</div>
	    </div>
	</div>
	<!-- //contents --> 
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	