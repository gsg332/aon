<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/supervisor/include/header.jsp" %>
<script type="text/javascript">
var point = angular.module('point', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize', 'aon.admin.diretives'])
.config(function ($httpProvider) {
	  $httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider) {
	$routeProvider.when('/', {
		controller : 'MemberListCtl',
		templateUrl : jcontext.getContextPath('/supervisor/point/memList.aon')
	}).when('/point/:memberId', {
		controller : 'PointListCtl',
		templateUrl : jcontext.getContextPath('/supervisor/point/pointList.aon')
	}).otherwise({
		redirectTo : '/'
	});
}).controller('MemberListCtl', function($scope, $http, $rootScope, $location) {
	var $form = $("form[name*='mForm']");
	$scope.dateSearchKey = 'insertDate';
	$scope.statusSearchKey = 'activeMember';
	$scope.inputSearchKey = 'loginId';
	
	var init = function(data){
		$scope.list = data.list;
		$scope.totalItems = data.count;
	}

	$scope.reset = function(){
		$scope.inputSearchValue = '';
	}
	
	$scope.pageChanged = function(){
		$http({
	  		method : 'POST',
	  		responseType : 'json',
			data : $form.serialize(),
			//data : $.param({'statusSearchKey' : 4000}),
			headers : {'Content-Type': 'application/x-www-form-urlencoded'},
			url : jcontext.getCsrfPath('/supervisor/module/member/list.json?page=' + $scope.currentPage)
		}).then(
			function successCallback(response) {
				init(response.data);
			},
			function errorCallback(response) {
				new PageAlert({'type':'danger','title':'','message':response.data.exname});
		 	}
		);
	}

	$scope.search = function(){
		$scope.currentPage = 1;
		$scope.pageChanged();
	};
	
	$scope.enterSearch = function($event){
		var keyCode = $event.which || $event.keyCode;
	    if (keyCode === 13) {
	    	$scope.search();
	    }
	}
	$scope.search();
	
	$scope.view = function(id){
		$location.path('/view/' + id);
	}
}).controller('PointListCtl', function($scope, $http, $routeParams) {
	$scope.itemsPerPage = 10;
	$scope.memberId = $routeParams.memberId;
	
	if (!$scope.currentPage) {
		$scope.currentPage = 1;
	}
	
	var init = function(data) {
		$scope.member = data.member;
		$scope.cyberAccount = data.cyberAccount;
		$scope.pointList = data.pointList;
		$scope.totalItems = data.pointCount;
	}
	
	$scope.pageChanged = function() {
		var data = jcontext.loadJSON('/supervisor/module/cyberAccount/pointList.json?page='+$scope.currentPage+'&memberId='+$scope.memberId);
		init(data);
	}
	$scope.pageChanged();
	
	//deposit modal	
	$scope.deposit = function() {
		var data = jcontext.loadJSON('/supervisor/module/member/readForUpdate.json?id='+$scope.memberId);
		$scope.memberItem = data.item;
		data = jcontext.loadJSON('/supervisor/module/cyberAccount/read.json?memberId='+$scope.memberId);
		$scope.cyberAccountItem = data.item;
		
		$scope.depositItem = {
			confirmPoint : '',
			adminComment : ''
		}
		
		$("#PointDeposit").modal();
	}
			
	$scope.depositSubmit = function() {
		if ($scope.depositAdminForm.$valid) {
			$scope.$broadcast("SUBMIT");
			jcontext.formSubmit($("form[name*='depositAdminForm']"),"/supervisor/module/deposit/deposit.json",
			{
				message:'<spring:message code="cmm.msg.014"/>',
				callback: function(data) {
					$scope.$apply(function() {
						$('#PointDeposit').modal('hide');
						$scope.pageChanged();
						//$location.path("/");
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
	
	//withdraw modal
	$scope.withdraw = function() {
		var data = jcontext.loadJSON('/supervisor/module/member/readForUpdate.json?id='+$scope.memberId);
		$scope.memberItem = data.item;
		data = jcontext.loadJSON('/supervisor/module/cyberAccount/read.json?memberId='+$scope.memberId);
		$scope.cyberAccountItem = data.item;
		
		$scope.withdrawItem = {
			confirmPoint : '',
			adminComment : ''
		}
		
		$("#PointWithdraw").modal();
	}
	
	$scope.withdrawSubmit = function() {
		if ($scope.withdrawAdminForm.$valid) {
			$scope.$broadcast("SUBMIT");
			jcontext.formSubmit($("form[name*='withdrawAdminForm']"),"/supervisor/module/withdraw/withdraw.json",
			{
				message:'<spring:message code="cmm.msg.014"/>',
				callback: function(data) {
					$scope.$apply(function() {
						$('#PointWithdraw').modal('hide');
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
});
</script>
<div ng-app="point">
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
