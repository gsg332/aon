<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<script type="text/javascript">
var point = angular.module('point', ['ngRoute', 'ui.bootstrap', 'aon.input.directives', 'ngSanitize','contactUs'])
.config(function ($httpProvider) {
	  $httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider)
{	
	$routeProvider.when('/', {
		controller : 'PointCtl',
		templateUrl : jcontext.getContextPath('/myPage/myPoint/point.aon')
	}).when('/deposit', {
		controller : 'DepositCtl',
		templateUrl : jcontext.getContextPath('/myPage/myPoint/deposit.aon')
	}).when('/depositPaypal', {
		controller : 'DepositPaypalCtl',
		templateUrl : jcontext.getContextPath('/myPage/myPoint/depositPaypal.aon')
	}).when('/withdraw', {
		controller : 'WithdrawCtl',
		templateUrl : jcontext.getContextPath('/myPage/myPoint/withdraw.aon')
	}).otherwise({
		redirectTo : '/'	
	});
});

point.controller('PointCtl', function($scope, $location) {
	$scope.itemsPerPage = 10;
	
	if (!$scope.currentPage) {
		$scope.currentPage = 1;
	}
	
	var init = function(memberData, cyberAccountData) {
		$scope.member = memberData.memberInfo;
		$scope.cyberAccount = cyberAccountData.cyberAccount;
		$scope.points = cyberAccountData.points;
		$scope.totalItems = cyberAccountData.pointsCount;
	}
	
	$scope.pageChanged = function() {
		var memberData = jcontext.loadJSON('/sys/member/getMemberInfo.json');
		var cyberAccountData = jcontext.loadJSON('/module/cyberAccount/all.json?page='+$scope.currentPage);
		init(memberData, cyberAccountData);
	}
	$scope.pageChanged();
	
	//충전
	$scope.deposit = function() {
		$location.path("/deposit");
	}
	
	//충전 - paypal
	$scope.depositPaypal = function() {
		$location.path("/depositPaypal");
	}
	
	//출금	
	$scope.withdraw = function() {
		$location.path("/withdraw");
	}
})
.controller('DepositCtl', function($scope, $location) {
	$scope.item;
	
	$scope.submit = function() {
		if ($scope.depositForm.$valid) {
			$scope.$broadcast("SUBMIT");
			jcontext.formSubmit($("form[name*='depositForm']"),"/module/deposit/register.json",
			{
				message:'<spring:message code="cmm.msg.014"/>',
				callback: function(data) {
					$scope.$apply(function() {
						$location.path("/");
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
	
	$scope.cancel = function() {
		 window.history.back();
	}
})
.controller('DepositPaypalCtl', function($scope, $location, $window, $http) {
	$scope.submit = function() {
		var form = $('form[name*="depositForm"]')[0];
		form.action = jcontext.getContextPath('/module/deposit/paypal.json');
		form.submit();
	}
	
	$scope.cancel = function() {
		 window.history.back();
	}
})
.controller('WithdrawCtl', function($scope, $location) {
	$scope.item = {};
	
	var init = function(cyberAccountData, memberData, bankAccountData) {
		$scope.cyberAccount = cyberAccountData.cyberAccount;
		$scope.member = memberData.memberInfo;
		$scope.bankAccount = bankAccountData.bankAccount;
		
		if (!$scope.bankAccount) {
			$("#adoptA").modal();
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
	
	$scope.loadData = function() {
		var cyberAccountData = jcontext.loadJSON('/module/cyberAccount/read.json');
		var memberData = jcontext.loadJSON('/sys/member/getMemberInfo.json');
		var bankAccountData = jcontext.loadJSON('/module/bankAccount/getBankAccount.json');
		init(cyberAccountData, memberData, bankAccountData);
	}
	$scope.loadData();
	
	$scope.submit = function() {
		if ($scope.withdrawForm.$valid) {
			$scope.$broadcast("SUBMIT");
			jcontext.formSubmit($("form[name*='withdrawForm']"),"/module/withdraw/register.json",
			{
				message:'<spring:message code="cmm.msg.014"/>',
				callback: function(data) {
					$scope.$apply(function() {
						$location.path("/");
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
	
	//인증번호 발송	
	$scope.callbackSend = function() {
		var data = jcontext.loadJSON('/module/withdraw/sendSms.json');
		return data.result;
	}
	
	//인증번호 체크	
	$scope.callbackAuth = function() {
		var inputNum = $('#chkNumber').val();
		var data = jcontext.loadJSON('/module/withdraw/checkCertifyNumber.json?certifyNumber='+inputNum);
		var result = false;
		
		if (data.result.resultCode == 2000) {
			$scope.item.certifyId = data.result.id;
			$scope.$apply();
			result = true;
		}
		return result;
	}
	
	$scope.cancel = function() {
		 window.history.back();
	}
	
	$scope.goBankAccountUpdate = function() {
		$(location).attr('href', jcontext.getLocationPath('/myPage/member/index.aon#/memberUpdateProfileForm/'));
	}
});
</script>
<!-- sub visual -->
<%@ include file="/WEB-INF/views/myPage/subVisual.jsp"%>
<!-- //sub visual -->

<!-- contents -->
<div class="contents" ng-app="point">
	<div class="container">
		<div class="wrap">
			<!-- navigation -->
			<nav>
				<ul class="navi">
					<li><a href='<c:url value="/index.aon"/>'><spring:message code='cmm.nav.001' /></a></li>
					<li><a href='<c:url value="/myPage/myInfo/index.aon"/>'><spring:message code='cmm.menu.010' /></a></li>
					<li><spring:message code='cmm.menu.014' /></li>
				</ul>
			</nav>
			<!-- //navigation -->
			<!-- sub_con -->
			<div ng-view></div>
			<!-- //sub_con -->
			<!-- right_menu -->
			<div class="sub_aside">
				<div class="rm_top">
					<h2>
						<spring:message code='cmm.menu.010' />
					</h2>
					<ul class="right_menu">
						<li><a href='<c:url value="/myPage/myInfo/index.aon"/>'><spring:message code='cmm.menu.011' /></a></li>
						<li><a href='<c:url value="/myPage/myQuestion/index.aon"/>'><spring:message code='cmm.menu.012' /></a></li>
						<li><a href='<c:url value="/myPage/myAnswer/index.aon"/>'><spring:message code='cmm.menu.013' /></a></li>
						<li class="on"><a href='<c:url value="#/"/>'><spring:message code='cmm.menu.014' /></a></li>
						<li><a href='<c:url value="/myPage/member/index.aon"/>'><spring:message code='cmm.menu.015' /></a></li>
						<li><a href='<c:url value="/myPage/member/index.aon#/memberUpdateProfileForm"/>'><spring:message
									code='cmm.menu.017' /></a></li>
						<li><a href='<c:url value="/myPage/drop/index.aon"/>'><spring:message code='cmm.menu.016' /></a></li>
					</ul>
				</div>
				<%@ include file="/WEB-INF/views/include/contactUs.jsp"%>
			</div>
			<!-- //right_menu -->
		</div>
	</div>
</div>
<!-- //contents -->

<%@ include file="/WEB-INF/views/include/footer.jsp"%>