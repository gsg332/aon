<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page buffer="none" errorPage="/WEB-INF/views/etc/err/error.jsp"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
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
	<script src="<%= request.getContextPath() %>/resources/js/directives/aon.admin.diretives.js"></script>
	<script src="<%= request.getContextPath() %>/resources/js/filters/aon.filters.js"></script>
	<script src="//cdn.ckeditor.com/4.5.6/standard/ckeditor.js"></script>
	<script src="<c:url value="/resources/js/script.language.${pageContext.response.locale}.js"/>"></script>
    <script>
    jcontext.init('<%= request.getContextPath() %>',{'${_csrf.parameterName}':'${_csrf.token}'});
    
    var headerApp = angular.module("HeaderApp", ['ngRoute', 'ngSanitize', 'ui.bootstrap', 'aon.input.directives'])
	.controller('HeaderCtl',function($scope, $cookies){
		$cookies.put('defaultLocale', '<c:out value="${defaultLocale}"/>');
		$cookies.put('locales', '<c:out value="${locales}"/>');
	});
	angular.element($('document')).ready(function($scope) {
	    angular.bootstrap($('#header'), ["HeaderApp"]);
	});
	
    </script>
</head>
<body>
	<div id="alert-div"></div>
	<!-- header -->
	<div class="header" id="header" ng-controller="HeaderCtl">
		<h1><a href='<c:url value="/system/index.aon"/>'>WHATINFO System Administrator</a></h1>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<ul class="admin_log">
	            <li><span class="tl_info"><sec:authentication property="principal.customUser.displayName"/></span></li>
	            <li class="nl_block">
                    <button type="submit" class="btn_logout" onclick="location.href='<c:url value="/supervisor/sys/login/logout.aon"/>' "><spring:message code='cmm.btn.019'/></button>
                </li>
	        </ul>
        </sec:authorize>
	</div>
    <!-- //header -->
    <!-- wrap con -->
    <div id="wrap">
