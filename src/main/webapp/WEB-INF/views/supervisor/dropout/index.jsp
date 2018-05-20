<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/supervisor/include/header.jsp" %>
 <style type="text/css"> 
.file_input_div     {position: relative;width:90px;height:26px;overflow: hidden; } 
.file_input_button  {width: 90px;position:absolute;top:0px; 
border:none; font-size:12px;height:16px;margin-left:2px; } 
.file_input_hidden {font-size:45px;position:absolute;right:0px;top:0px;cursor:pointer;opacity:0;filter:alpha(opacity=0);-ms-filter:"alpha 
(opacity=0)";-khtml-opacity:0;-moz-opacity:0;}
.alert {
    margin-bottom: 0px;
}
</style>
<script>
var dropoutApp = angular.module('dropout', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'aon.admin.diretives'])
.config(function ($httpProvider) {
	  $httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider)
{
	$routeProvider.when('/', {
		controller : 'DropoutListCtl',
		templateUrl : jcontext.getContextPath('/supervisor/dropout/listup.aon')
	}).otherwise({
		redirectTo : '/'
	});
}).controller('DropoutListCtl',function($rootScope, $scope, $http, $location, $httpParamSerializer){
	$scope.itemsPerPage = 10;
	var searchReset = function() {
		$scope.searchItem = {
			dateSearchKey : 'insertDate',
			startDate : '',
			endDate : '',
			inputSearchKey : 'all',
			inputSearchValue : ''
		}
	};
	searchReset();
	
	if (!$scope.currentPage) {
		$scope.currentPage = 1;
	}
	
	var init = function(data){
		$scope.list = data.list;
		$scope.totalItems = data.count;
		$scope.searchItem = data.memberSearch;
	}
	
	var searchParam = function() {
		var param = '&'+$httpParamSerializer($scope.searchItem);
		return param;
	}
	
	$scope.pageChanged = function(){
		var data = jcontext.loadJSON('/supervisor/module/dropout/list.json?page='+ $scope.currentPage+searchParam());
		init(data);
	};
	$scope.pageChanged();
	
	$scope.search = function(){
		$scope.currentPage = 1;
		$scope.pageChanged();
	};
	
	$scope.searchCancel = function() {
		$scope.currentPage = 1;
		searchReset();
		$scope.pageChanged();
	};

	$scope.enterSearch = function($event){
		var keyCode = $event.which || $event.keyCode;
	    if (keyCode === 13) {
	    	$scope.search();
	    }
	}

	$scope.view = function(index){
		$rootScope.member = $scope.list[index];
		$('#WithdrawalReason').modal('show');  
	};
})
</script>
<div ng-app="dropout">
	<!-- left menu -->
	<%@ include file="/WEB-INF/views/supervisor/include/left.jsp" %>
	<!-- //left menu -->
 	<!-- contents -->
	<div class="con">
    	<div class="box">
        	<div ng-view></div>
        </div>
    </div>
    <!-- //contents --> 	
</div>
<%@ include file="/WEB-INF/views/supervisor/include/footer.jsp" %>
