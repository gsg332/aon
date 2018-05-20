<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/supervisor/include/header.jsp" %>
<script type="text/javascript">
var notice = angular.module('notice', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize', 'aon.admin.diretives'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider)
{
	$routeProvider.when('/', {
		controller : 'NoticeListCtl',
		templateUrl : jcontext.getContextPath('/supervisor/notice/list.aon')
	}).when('/edit/:id', {
		controller : 'NoticeEditCtl',
		templateUrl : jcontext.getContextPath('/supervisor/notice/edit.aon')
	}).when('/write', {
		controller : 'NoticeWriteCtl',
		templateUrl : jcontext.getContextPath('/supervisor/notice/write.aon')
	}).otherwise({
		redirectTo : '/'
	});
});

notice.controller('NoticeListCtl', function($scope, $rootScope){
	var searchKey = '';
	var searchValue = '';
	$scope.searchKey = 'title';
	$scope.searchValue = '';
	
	// 검색어 유지
	if($rootScope.searchValue != undefined && $rootScope.searchValue != ''){
		$scope.searchKey = $rootScope.searchKey;
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
		var data = jcontext.loadJSON('/supervisor/module/notice/listPage.json?page='+$scope.currentPage+'&searchKey='+encodeURIComponent(searchKey)+'&searchValue='+encodeURIComponent(searchValue));
		init(data);
	};

	$scope.search = function(){
		searchKey = $scope.searchKey;
		searchValue = $scope.searchValue;
		$rootScope.searchKey = searchKey;
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
		$scope.searchKey = 'title';
		$scope.searchValue = '';
		$scope.search();
	}
	$scope.search();
})
.controller('NoticeWriteCtl', function($scope, $location, $rootScope) {
	$scope.item;
	$scope.submit = function(){
		if($scope.mForm.$valid){
			$rootScope.searchValue = '';
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($("form[name*='mForm']"),'/supervisor/module/notice/register.json',
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
.controller('NoticeEditCtl', function($scope, $routeParams, $location, $rootScope) {
	function setValue(data){			
		$scope.item = data.item;
	}

	$scope.load = function(_id) {
		var data = jcontext.loadJSON('/supervisor/module/notice/readForUpdate.json?id='+_id);
		setValue(data);
	};
	
	$scope.load($routeParams.id);

	$scope.submit = function(){
		if ($scope.mForm.$valid) {
			$rootScope.searchValue = '';
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($("form[name*='mForm']"),'/supervisor/module/notice/update.json',
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
		jcontext.formSubmit($("form[name*='mForm']"),'/supervisor/module/notice/delete.json',
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
});
</script>
	<div ng-app="notice">
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