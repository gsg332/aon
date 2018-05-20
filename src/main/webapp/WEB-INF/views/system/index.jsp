<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/system/include/header.jsp" %>
<script type="text/javascript">
var index = angular.module('index', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize', 'aon.admin.diretives']);
</script>
	<div ng-app="index">
		<!-- left menu -->
		<%@ include file="/WEB-INF/views/system/include/left.jsp" %>
		<!-- //left menu -->
 		<!-- contents -->
		<div class="con">
            <div class="box">
            </div>
        </div> 	
	    <!-- //contents -->
	</div>
<%@ include file="/WEB-INF/views/system/include/footer.jsp" %>
