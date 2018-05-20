<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/system/include/header.jsp" %>
<script type="text/javascript">
var config = angular.module('config', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider)
{
	$routeProvider.when('/', {
		controller : 'ConfigListCtl',
		templateUrl : jcontext.getContextPath('/system/config/list.aon')
	}).when('/edit/:id', {
		controller : 'ConfigEditCtl',
		templateUrl : jcontext.getContextPath('/system/config/edit.aon')
	}).otherwise({
		redirectTo : '/'
	});
});

config.controller('ConfigListCtl', function($scope, $rootScope){
	$rootScope.leftMenu = 'config';
	
	if(!$rootScope.currentPage)
		$scope.currentPage = 1;
	
	$scope.pageChanged = function() {
		$rootScope.currentPage = $scope.currentPage;
	};
	
	$scope.list = jcontext.loadTEXT('/system/config/json.aon');
	
	$scope.totalItems = $scope.list.length;
})
.controller('ConfigEditCtl', function($scope, $routeParams, $location, $rootScope) {
	$rootScope.leftMenu = 'config';
	
	$scope.className = $routeParams.id;
	
	function setValue(data){			
		$scope.item = data.list;
	}

	$scope.load = function(_id) {
		var data = jcontext.loadJSON('/system/config/classList.json?clazz='+_id);
		setValue(data);
	};
	
	$scope.load($routeParams.id);

	$scope.submit = function(){
		if ($scope.mForm.$valid) {
			$rootScope.searchValue = '';
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($("form[name*='mForm']"),'/system/config/update.json',
				{message:i18n.getLang('common','modify')
					,callback: function(data){
						$scope.$apply(function() {
							$rootScope.currentPage = 1;
							$location.path('/');
						});
					}
				},{ message:i18n.getLang('common','error'),
					callback: function(e){
						alert(e.status);
					}
				}
			);
		} else {
			return false;
		}
	}
}); 
</script>
	<div ng-app="config">
		<!-- left menu -->
		<%@ include file="/WEB-INF/views/system/include/left.jsp" %>
		<!-- //left menu -->
 		<!-- contents -->
		<div class="con">
            <div class="box">
                <div ng-view></div>
            </div>
        </div> 	
	    <!-- //contents -->
	</div>
<%@ include file="/WEB-INF/views/system/include/footer.jsp" %>