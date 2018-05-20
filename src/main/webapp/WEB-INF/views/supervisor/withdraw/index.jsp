<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/supervisor/include/header.jsp" %>
<script type="text/javascript">
var withdraw = angular.module('withdraw', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize', 'aon.admin.diretives'])
.config(function ($httpProvider) {
	  $httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider) {
	$routeProvider.when('/', {
		controller : 'WithdrawListCtl',
		templateUrl : jcontext.getContextPath('/supervisor/withdraw/list.aon')
	}).otherwise({
		redirectTo : '/'
	});
}).controller('WithdrawListCtl',function($scope, $location, $httpParamSerializer) {
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
		$scope.searchItem = data.withdrawSearch;
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
	
	$scope.bankName = function(bankCode) {
		// 은행코드에 해당하는 은행명 추가. 
		var bankList = i18n.getLang('bankAccount','bankType').split('|');
		var bankName;
		for(var i=0; i<bankList.length; i++){
			var bank = bankList[i].split(':');
			if (bank[0] == bankCode) {
				bankName = bank[1];
			} else {
				bankName = '';
			}
		}
		return bankName;
	}
	
	$scope.pageChanged = function() {
		var data = jcontext.loadJSON('/supervisor/module/withdraw/list.json?page='+$scope.currentPage+searchParam());
		init(data);
	}
	$scope.pageChanged();
	
	//register button
	$scope.register = function(_id) {
		var data = jcontext.loadJSON('/supervisor/module/withdraw/read.json?id=' + _id);
		$scope.item = data.item;
		$scope.item.withdraw.confirmPoint = $scope.item.withdraw.requestPoint;
		
		$("#PoinDraw2").modal();
	}
	
	$scope.submit = function() {
		if ($scope.withdrawAdminForm.$valid) {
			$scope.$broadcast("SUBMIT");
			jcontext.formSubmit($("form[name*='withdrawAdminForm']"),"/supervisor/module/withdraw/update.json",
			{
				message:'<spring:message code="cmm.msg.014"/>',
				callback: function(data) {
					$scope.$apply(function() {
						$('#PoinDraw2').modal('hide');
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
<div ng-app="withdraw">
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
