<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WHATINFO Admin</title>
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=getServletContext().getContextPath() %>/resources/css/Astyle.css">
    <script src="<%= request.getContextPath() %>/resources/js/jcontext.js"></script>
    <script src="<%=getServletContext().getContextPath() %>/resources/js/respond.js"></script>
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-route.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-cookies.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5//angular-sanitize.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/1.3.3/ui-bootstrap-tpls.min.js"></script>
    <script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
    <script src="<%= request.getContextPath() %>/resources/js/bootstrap.js"></script>
    <script src="<%= request.getContextPath() %>/resources/js/scripts.min.js"></script>
	<script src="<%= request.getContextPath() %>/resources/js/directives/aon.input.diretives.js"></script>
	
    <script type="text/javascript">
    	jcontext.init('<%= request.getContextPath() %>',{'${_csrf.parameterName}':'${_csrf.token}'});
    	
    	(function() {
    		"use strict"
    		angular.module('loginApp', [ 'ui.bootstrap','aon.input.directives' ])
    		.run(function($rootScope){
    		})
    		.controller('LoginController', function($scope, $http) {
    			$scope.submit = function(){
    				if ($scope.loginForm.$valid) {
    					var $form = $('form[name="loginForm"]');
    					$form.attr('action', jcontext.getCsrfPath('/supervisor/securityLogin') + '&returnUrl=' + encodeURIComponent('${param.returnUrl}'));
    					$form.submit();				
    				}
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
    <style>
    	.errorBox {color:#e73d4a; background:#fbe1e3; padding:15px; line-height:16px; text-align:center; margin-top:10px;}
    	.adminLogin .loginBox .form-control {background-color: #ffffff !important}
    	.adminLogin .loginBox .form-control[type="password"]{margin-top: 15px !important}
    </style>
</head>
<body class="admin_body" ng-app="loginApp" ng-controller="LoginController">
    <div class="adminLogin">
        <div class="headTit">WHATINFO Administrator</div>
        <div class="loginBox">
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
                </div>
            </form:form>
        </div>
        <div class="footerCopy">Copyright WhatInfo All rights reserved.</div>
    </div>
	<script src="<%=getServletContext().getContextPath() %>/resources/js/moment.js"></script>
	<script src="<%=getServletContext().getContextPath() %>/resources/js/bootstrap-datetimepicker.min.js"></script>
	<script src="<%=getServletContext().getContextPath() %>/resources/js/app.js"></script>
</body>
</html>
