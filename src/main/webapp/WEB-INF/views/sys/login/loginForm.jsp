<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
.errorBox {color:#e73d4a; background:#fbe1e3; padding:15px; line-height:16px; text-align:center; margin-top:10px;}
.loginBox .form-control {background-color: #ffffff !important}
</style>
<script type="text/javascript">
(function() {
	"use strict"
	angular.module('loginApp', [ 'ui.bootstrap','aon.input.directives' ])
	.controller('LoginController', function($scope, $http) {
		$scope.submit = function(){
			if ($scope.loginForm.$valid) {
				var $form = $('form[name="loginForm"]');
				$form.attr('action', jcontext.getCsrfPath('/securityLogin') + '&returnUrl=' + encodeURIComponent('${param.returnUrl}'));
				$form.submit();				
			}
		}
		
		$scope.findPassword = function(){
			location.href = jcontext.getContextPath('/sys/member/index.aon#/findLoginPw/');
		}
		
		$scope.enterEvent = function($event){
			var keyCode = $event.which || $event.keyCode;
		    if (keyCode === 13) {
		    	$scope.submit();
		    }
		}
	});
})();
</script>
<div class="sub_visual sVisual0">
	<div class="wrap">
		<h2>WHATINFO</h2>
		<p class="sV_title">
			<spring:message code='hdr.msg.001'/>
		</p>
	</div>
</div>
<!-- //sub visual -->
<!-- contents -->
<div class="contents" ng-app="loginApp" ng-controller="LoginController">
	<div class="container" >
		<div class="wrap">
			<!-- navigation -->
			<nav>
				<ul class="navi">
					<li><a href='<c:url value="/index.aon"/>'><spring:message code='cmm.nav.001'/></a></li>
					<li><spring:message code='mem.nav.002'/></li>
				</ul>
			</nav>
			<!-- //navigation -->
			<!-- login_area -->
			<div class="login_area">
				<div class="loginBox">
					<h2 class="login_tit"><spring:message code='mem.lbl.042'/></h2>
					<form:form id="loginForm" name="loginForm" novalidate="true" method="post" class="login-form" ng-keypress="enterEvent($event)">
						<div class="form-group">
							<div class="check_rs fm_type444">
						   		<aon-input-text type="text" ng-model="loginId" field-name="loginId" placeholder="<spring:message code='mem.msg.001'/>" ng-required="true" alert-message="<spring:message code='mem.err.001'/>"></aon-input-text>
						  	</div>
							<div class="check_rs fm_type444">
								<aon-password ng-model="password" field-name="password" placeholder="<spring:message code='mem.msg.006'/>" ng-required="true" alert-message="<spring:message code='mem.err.005'/>" length-check="false"></aon-password>
							</div>
						</div>
						<c:if test="${param.fail == 'true'}">
							<div class="errorBox">
								<span><i class="fa-lg fa fa-warning" style="padding-right:7px"></i><spring:message code="login.fail" /></span>
								<c:remove scope="session" var="SPRING_SECURITY_LAST_EXCEPTION"/>
							</div>
						</c:if>
						<div class="login_bottom">
							<button type="button" class="btn green btn_login" ng-click="submit()" ng-disabled="loginForm.$invalid"><spring:message code='cmm.btn.006'/></button>
							<a href="#" ng-click="findPassword()" class="forget-password"><spring:message code='mem.btn.002'/></a>
							<button type="button" class="btn btn blue-hoki mem_regi" onclick="$(location).attr('href','<c:url value="/sys/member/index.aon#/emailConfirm"/>');"><spring:message code='cmm.btn.020'/></button>
						</div>
					</form:form>
				</div>
			</div>
			<!-- login_area -->
		</div>
	</div>
</div>
<!-- //contents -->
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
