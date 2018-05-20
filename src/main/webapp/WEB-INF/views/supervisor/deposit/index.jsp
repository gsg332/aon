<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/supervisor/include/header.jsp" %>
<script type="text/javascript">
var deposit = angular.module('deposit', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize', 'aon.admin.diretives'])
.config(function ($httpProvider) {
	  $httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider) {
	$routeProvider.when('/', {
		controller : 'DepositListCtl',
		templateUrl : jcontext.getContextPath('/supervisor/deposit/list.aon')
	}).otherwise({
		redirectTo : '/'
	});
});

deposit.controller('DepositListCtl',function($scope, $http, $rootScope, $httpParamSerializer) {	
	$scope.itemsPerPage = 10;
	$scope.searchItem = {
		dateSearchKey : 'insertDate',
		startDate : '',
		endDate : '',
		memberSearchKey : 'loginId',
		memberSearchValue : ''
	}
	
	if (!$scope.currentPage) {
		$scope.currentPage = 1;
	}
	
	var init = function(data) {
		$scope.list = data.list;
		$scope.totalItems = data.count;
		$scope.searchItem = data.depositSearch;
	}
	
	var searchParam = function() {
		var param = '&'+$httpParamSerializer($scope.searchItem);
		return param;
	}
	
	var searchReset = function() {
		$scope.searchItem = {
			dateSearchKey : 'insertDate',
			startDate : '',
			endDate : '',
			memberSearchKey : 'loginId',
			memberSearchValue : ''
		}
	}
	
	$scope.pageChanged = function() {
		var data = jcontext.loadJSON('/supervisor/module/deposit/list.json?page='+$scope.currentPage+searchParam());
		init(data);
	}
	$scope.pageChanged();
	
	//register modal
	$scope.register = function(_id) {
		var data = jcontext.loadJSON('/supervisor/module/deposit/read.json?id=' + _id);
		$scope.item = data.item;
		$scope.item.deposit.confirmPoint = $scope.item.deposit.requestPoint;
		
// 		$scope.item.deposit.confirmPoint = $scope.item.deposit.requestPoint;
// 		$scope.item.deposit.confirmAccountName = $scope.item.deposit.requestAccountName;

		$("#PoinDraw1").modal();
	}
	
	$scope.submit = function() {
		if ($scope.depositAdminForm.$valid) {
			$scope.$broadcast("SUBMIT");
			jcontext.formSubmit($("form[name*='depositAdminForm']"),"/supervisor/module/deposit/update.json",
			{
				message:'<spring:message code="cmm.msg.014"/>',
				callback: function(data) {
					$scope.$apply(function() {
						$('#PoinDraw1').modal('hide');
						$scope.pageChanged();
					});
				}
			}, {
				message:'<spring:message code="cmm.msg.015"/>',
				callback: function(e) {
				}
			});
		} else {
			return false;
		}
	}
	
	$scope.search = function() {
		$scope.currentPage = 1;
		$scope.pageChanged();
	}
	
	$scope.searchCancel = function() {
		$scope.currentPage = 1;
		searchReset();
		$scope.pageChanged();
	}
});
</script>
<div ng-app="deposit">
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