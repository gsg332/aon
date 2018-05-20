<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/system/include/header.jsp" %>
<script type="text/javascript">
var schedule = angular.module('schedule', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider)
{
	$routeProvider.when('/', {
		controller : 'ScheduleListCtl',
		templateUrl : jcontext.getContextPath('/system/schedule/list.aon')
	}).when('/edit/:id', {
		controller : 'ScheduleEditCtl',
		templateUrl : jcontext.getContextPath('/system/schedule/edit.aon')
	}).when('/write', {
		controller : 'ScheduleWriteCtl',
		templateUrl : jcontext.getContextPath('/system/schedule/write.aon')
	}).when('/log', {
		controller : 'ScheduleLogCtl',
		templateUrl : jcontext.getContextPath('/system/schedule/log.aon')
	}).otherwise({
		redirectTo : '/'
	});
});

schedule.controller('ScheduleListCtl', function($scope, $rootScope){
	$rootScope.leftMenu = 'schedule';
	var searchValue = '';
	$scope.searchValue = '';
	
	// 검색어 유지
	if($rootScope.searchValue != undefined && $rootScope.searchValue != ''){
		$scope.searchValue = $rootScope.searchValue;
	}
	
	var init = function(data){
		$scope.list = data.list;
		$scope.totalItems = data.count;
		if(!$rootScope.currentPage)
			$scope.currentPage = 1;
	}
	
	$scope.pageChanged = function() {
		$rootScope.currentPage = $scope.currentPage;
		var data = jcontext.loadJSON('/system/schedule/listPage.json?page='+$scope.currentPage+'&searchValue='+searchValue);
		init(data);
	};

	$scope.search = function(){
		searchValue = $scope.searchValue;
		$rootScope.searchValue = searchValue;
		$scope.pageChanged();
	};
	
	//엔터키 이벤트
	$scope.enterSearch = function($event){
		var keyCode = $event.which || $event.keyCode;
	    if (keyCode === 13) {
	    	$scope.search();
	    }
	}
	
	$scope.cancel = function(){
		$scope.currentPage = 1;
		$scope.searchValue = '';
		$scope.search();
	}
	$scope.search();
})
.controller('ScheduleWriteCtl', function($scope, $location, $rootScope) {
	$rootScope.leftMenu = 'schedule';
	
	$scope.cron = '';
	$scope.interval = '';
	
	$scope.$watch('cron' ,function(newValue){
		if(newValue.length > 0){
			$scope.interval = 0;
		}
	});
	
	$scope.$watch('interval' ,function(newValue){
		if(newValue > 0){
			$scope.cron = '';
		}
	});
	
	$scope.submit = function(){
		if($scope.mForm.$valid){
			$rootScope.searchValue = '';
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($("form[name*='mForm']"),'/system/schedule/register.json',
				{message:i18n.getLang('common','register')
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
})
.controller('ScheduleEditCtl', function($scope, $routeParams, $location, $rootScope, safeApply) {
	$rootScope.leftMenu = 'schedule';
	function setValue(data){			
		$scope.item = data.item;
	}

	$scope.load = function(_id) {
		var data = jcontext.loadJSON('/system/schedule/readForUpdate.json?id='+_id);
		setValue(data);
	};
	
	$scope.load($routeParams.id);

	$scope.$watch('item.cron' ,function(newValue){
		if(newValue.length > 0){
			$scope.item.interval = 0;
		}
	});
	
	$scope.$watch('item.interval' ,function(newValue){
		if(newValue > 0){
			$scope.item.cron = '';
		}
	});
	
	$scope.submit = function(){
		if ($scope.mForm.$valid) {
			$rootScope.searchValue = '';
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($("form[name*='mForm']"),'/system/schedule/update.json',
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
	
	$scope.del = function(){
		$rootScope.searchValue = '';
		$scope.$broadcast('SUBMIT');
		jcontext.formSubmit($("form[name*='mForm']"),'/system/schedule/delete.json',
			{message:i18n.getLang('common','delete')
				,callback: function(data){
					$scope.$apply(function() {
						$location.path('/');
					});
				}
			},{ message:i18n.getLang('common','error'),
				callback: function(e){
					alert(e.status);
				}
			}
		);
	}
	
	var _toggle = false;
	
	$scope.openToggle = function(val){
		_toggle = val;
		$(angular.element(confirmS)[0]).modal();
	}
	
	$scope.toggle = function(){
		var id = $scope.item.id;
		jcontext.jsonAction('/system/schedule/toggle.json','id='+id+'&paused=' + _toggle,
			{
				message:i18n.getLang('contest','process')
			 	,callback: function(data){
					safeApply($scope,function() {
						$scope.item.paused = _toggle;
					});
			    }
			}
		);
	}
	
})
.controller('ScheduleLogCtl', function($scope, $rootScope, $httpParamSerializer){
	$rootScope.leftMenu = 'scheduleLog';
	
	$scope.searchItem = {
			searchValue : '',
			startDate : '',
			endDate : ''
	};
	
	var init = function(data){
		$scope.list = data.list;
		$scope.totalItems = data.count;
		if(!$scope.currentPage)
			$scope.currentPage = 1;
	}
	
	var searchParam = function() {
		var param = '&'+$httpParamSerializer($scope.searchItem);
		return param;
	};
	
	$scope.pageChanged = function() {
		var data = jcontext.loadJSON('/system/schedule/logPage.json?page='+$scope.currentPage + searchParam());
		init(data);
	};

	$scope.search = function(){
		$scope.pageChanged();
	};
	
	//엔터키 이벤트
	$scope.enterSearch = function($event){
		var keyCode = $event.which || $event.keyCode;
	    if (keyCode === 13) {
	    	$scope.search();
	    }
	}
	
	$scope.cancel = function(){
		$scope.currentPage = 1;
		$scope.search();
	}
	$scope.search();
}); 
</script>
	<div ng-app="schedule">
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