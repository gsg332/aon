<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">
var app = angular.module('myInfoApp', ['ngRoute', 'ui.bootstrap', 'aon.input.directives', 'ngSanitize', 'contactUs', 'Filters'])  
.config(function ($httpProvider, $routeProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
	$routeProvider.when('/', {
		controller : 'myInfoCtl',
		templateUrl : jcontext.getContextPath('/myPage/myInfo/myInfo.aon')
	}).otherwise({
		redirectTo : '/'
	});
})
.controller('myInfoCtl', function($scope, $routeParams, $http, $location) {
	//멤버조회
	var data = jcontext.loadJSON('/sys/member/getMemberInfo.json');
	$scope.member = data.memberInfo;
	
	//cyberAccount
	var cyberData = jcontext.loadJSON('/module/cyberAccount/read.json');
	$scope.cyberAccount = cyberData.cyberAccount;
	
	//contest count
	var chooseCnt = jcontext.loadJSON('/module/contest/chooseCount.json');
	$scope.chooseCnt = chooseCnt.chooseCount;
	
	var myContests = jcontext.loadJSON('/module/contest/myContests.json');
	
	$scope.myOngoingContestList = myContests.myOngoingContestList;
	$scope.myOngoingAnswerList = myContests.myOngoingAnswerList;
})
.directive('errSrc', function() {
	return {
		link: function(scope, element, attrs) {
		    element.bind('error', function() {
		    	
		    	console.log(scope.member.male);
		    	
		    	var imgType;
		    	if(scope.member.type == '3100'){
		    		imgType = jcontext.getContextPath('/resources/images/sub/profile_default_c.png');
		    	}else if(scope.member.male == true){
		    		imgType = jcontext.getContextPath('/resources/images/sub/profile_default_m.png');;
		    	}else{
		    		imgType = jcontext.getContextPath('/resources/images/sub/profile_default_f.png');;
		    	}
	    		attrs.$set('src', imgType);
		    });
	    }
	}
})
.directive('listContest', function() {
	return function(scope, element, attrs) {
		if(scope.$last){
			element.ready(function () {
				$(".el_txt").dotdotdot({
					watch: "window"
				});
			});
		}
	};
});  
</script>
	<!-- sub visual -->
    <%@ include file="/WEB-INF/views/myPage/subVisual.jsp" %>
    <!-- //sub visual -->
 	<!-- contents -->
	<div class="contents" ng-app="myInfoApp">
		<div class="container">
			<div class="wrap">
				<!-- navigation -->
				<nav>
				    <ul class="navi">
						<li><a href='<c:url value="/index.aon"/>'><spring:message code='cmm.nav.001'/></a></li>
						<li><a href='<c:url value="#/"/>'><spring:message code='cmm.menu.010'/></a></li>
						<li><spring:message code='cmm.menu.011'/></li>
					</ul>
				</nav>
				<!-- //navigation -->
				<!-- sub_con -->
				<div ng-view></div>
			    <!-- //sub_con -->
				<!-- right_menu -->
				<div class="sub_aside">
				    <div class="rm_top">
				        <h2><spring:message code='cmm.menu.010'/></h2>
	                    <ul class="right_menu">
	                    	<li class="on"><a href='<c:url value="#/"/>'><spring:message code='cmm.menu.011'/></a></li>
	                        <li><a href='<c:url value="/myPage/myQuestion/index.aon"/>'><spring:message code='cmm.menu.012'/></a></li>
	                        <li><a href='<c:url value="/myPage/myAnswer/index.aon"/>'><spring:message code='cmm.menu.013'/></a></li>
	                        <li><a href='<c:url value="/myPage/myPoint/index.aon"/>'><spring:message code='cmm.menu.014'/></a></li>
	                        <li><a href='<c:url value="/myPage/member/index.aon"/>'><spring:message code='cmm.menu.015'/></a></li>
	                        <li><a href='<c:url value="/myPage/member/index.aon#/memberUpdateProfileForm"/>'><spring:message code='cmm.menu.017'/></a></li>
	                        <li><a href='<c:url value="/myPage/drop/index.aon"/>'><spring:message code='cmm.menu.016'/></a></li>
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
	