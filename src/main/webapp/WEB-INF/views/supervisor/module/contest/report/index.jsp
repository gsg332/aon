<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/supervisor/include/header.jsp"%>
<script type="text/javascript">
var report = angular.module('Report', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize',  'aon.admin.diretives', 'Filters'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
}).config(function($routeProvider){
	$routeProvider.when('/', {
		controller : 'ReportListCtl',
		templateUrl : jcontext.getContextPath('/supervisor/module/contest/report/list.aon')
	}).when('/view/:id', {
		controller : 'ReportReadCtl',
		templateUrl : jcontext.getContextPath('/supervisor/module/contest/report/view.aon')
	}).otherwise({
		redirectTo : '/'
	});	
});
report.controller('ReportListCtl', function($scope, $route, $rootScope, $httpParamSerializer) {
	$rootScope.leftMenu = 'report';
	
	$scope.openSingleConfirm = function (id) {
		$scope.adminComment=null;
		var data = jcontext.loadJSON('/supervisor/module/contest/report/readSingle.json?id='+id);
		$scope.items=data.item;
		$(angular.element(confirmL)[0]).modal();
	};
	
	$scope.confirm = function() {
		if($scope.confirmForm.$valid){
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($('form[name=confirmForm]'),'/supervisor/module/contest/report/singleConfirm.json',
				  	 {message:i18n.getLang('contest','process')
				     ,callback: function(data){
			  			 $scope.$apply(function() {
			  				$(angular.element(confirmL)[0]).modal('hide');
			  				$scope.pageChanged();
			  			  });
		  			    }
				   	}
				   ,{ message:i18n.getLang('common','error'),
					  callback: function(e){
						  alert(e.status);
					   }
					}
				);
		} else {
			return false;
		}
	}
	
	$scope.searchItem = {
			searchKey : 'reportUser',
			startDate : '',
			endDate : ''
		};
	
	if($rootScope.searchText != undefined && $rootScope.searchText != ''){
		$scope.searchItem.searchKey = $rootScope.searchKey;
		$scope.searchItem.searchText = $rootScope.searchText;
	}
	
	if($rootScope.startDate != undefined && $rootScope.startDate != ''){
		$scope.searchItem.startDate = $rootScope.startDate;
	}
	
	if($rootScope.endDate != undefined && $rootScope.endDate != ''){
		$scope.searchItem.endDate = $rootScope.endDate;
	}
	
	var init = function(data) {
		$scope.list = data.list;
		$scope.totalItems = data.count;
		if (!$rootScope.currentPage)
			$scope.currentPage = 1;
	};
	
	var searchParam = function() {
		var param = '&'+$httpParamSerializer($scope.searchItem);
		return param;
	};
	
	$scope.pageChanged = function() {
		$rootScope.currentPage = $scope.currentPage;
		var data = jcontext.loadJSON('/supervisor/module/contest/report/listPage.json?page='+$scope.currentPage + searchParam());
		init(data);
	};	
	
	$scope.checkEnter = function($event){
		var keyCode = $event.which || $event.keyCode;
	    if (keyCode === 13) {
	    	$scope.searchList();
	    }
	};
	
	$scope.searchList = function(){
		$rootScope.searchKey = $scope.searchItem.searchKey;
		$rootScope.searchText = $scope.searchItem.searchText;
		$rootScope.startDate = $scope.searchItem.startDate;
		$rootScope.endDate = $scope.searchItem.endDate;
		$scope.pageChanged();
	};
	
	$scope.searchReset = function(){
		$scope.currentPage = 1;
		$scope.searchItem.searchKey='reportUser';
		$scope.searchItem.searchText=null;
		$scope.searchItem.startDate = '';
		$scope.searchItem.endDate = '';
		$scope.searchList();
	}
	
	$scope.searchList();	
}).controller('ReportReadCtl',function($scope, $rootScope, $routeParams, $location, $route, safeApply) {
	$rootScope.leftMenu = 'report';
	
	$scope.contestBtn=true;
	function setValue(data)
	{			
		$scope.item = data.contest;
		$scope.reportList = data.reportList;		
	}
	
	// 경고 처리
	$scope.block = function(){
		var id = $scope.item.id;
		jcontext.jsonAction('/supervisor/module/contest/setWarnnig.json','id='+id,
			{
				message:i18n.getLang('contest','process')
			 	,callback: function(data){
					safeApply($scope,function() {
						$route.reload()
					});
			    }
			}
		);		
	};
	
	// 공모 취소 승인 처리
	$scope.permit = function(){
		var id = $scope.item.id;
		jcontext.jsonAction('/supervisor/module/contest/cancel.json','id='+id,
				{
					message:i18n.getLang('contest','process')
				 	,callback: function(data){
						safeApply($scope,function() {
							$route.reload()
						});
				    }
				}
		);
	};
	
	//신고 확인	
	$scope.confirm = function(id) {
		var form = 'confirmForm'+id;
		$scope.$broadcast("SUBMIT");
		jcontext.formSubmit($("form[name*='"+form+"']"),"/supervisor/module/contest/report/singleConfirm.json",
			{
				message:i18n.getLang('contest','process')
				,callback: function(data){
					$route.reload()
				}
		  	},
			{ 
		  		message:i18n.getLang('common','error')
				,callback: function(e){
					  alert(e.status);
				}
			}
	  	);	
	}
	
	$scope.goList = function(){
		$location.path('/');
	}
	
	$scope.load = function(qaId) {
		var data = jcontext.loadJSON('/supervisor/module/contest/report/readAll.json?qaId='+qaId);
		setValue(data); 
	};
	$scope.load($routeParams.id);
});
</script>
<div ng-app="Report">  
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
<!-- //contents --> 
<%@ include file="/WEB-INF/views/supervisor/include/footer.jsp" %>