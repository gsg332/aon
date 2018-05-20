<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/supervisor/include/header.jsp"%>
<script type="text/javascript">
var contest = angular.module('Contest', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize',  'aon.admin.diretives', 'Filters'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider)
{
	$routeProvider.when('/', {
		controller : 'ContestListCtl',
		templateUrl : jcontext.getContextPath('/supervisor/list.aon')
	}).when('/view/:id', {
		controller : 'ContestReadCtl',
		templateUrl : jcontext.getContextPath('/supervisor/view.aon')
	}).otherwise({
		redirectTo : '/'
	});
});
	
contest.controller('ContestListCtl', function($scope, $rootScope, $httpParamSerializer) {
	$rootScope.leftMenu = 'adminMain';
	
$scope.depthShow = false;
	
	$scope.searchItem = {
			searchKey : 'title',
			searchChoose : '-1',
			searchStatus : '-1',
			categoryId : '-1',
			categorySub : '-1',
			startDate : '',
			endDate : ''
		};
	
	var catlist = jcontext.loadJSON('/sys/category/getListByParent.json?pid=whatinfo');
	$scope.catlist = catlist.list;
	
	$scope.categoryChange = function(){
		if ($scope.searchItem.categoryId != '-1') {
			$scope.searchItem.categorySub = '-1';
			var subCategory = jcontext.loadJSON('/sys/category/getListByParent.json?pid='+$scope.searchItem.categoryId);
			$scope.subCategoryList = subCategory.list;
			if($scope.subCategoryList.length > 0){
				$scope.depthShow = true;
			}else{
				$scope.depthShow = false;
			}
		}else{
			$scope.depthShow = false;
			$scope.searchItem.categorySub = '-1';
		}
	}
	
	// 검색어 유지
	if($rootScope.searchText != undefined && $rootScope.searchText != ''){
		$scope.searchItem.searchKey = $rootScope.searchKey;
		$scope.searchItem.searchText = $rootScope.searchText;
	}
	
	if($rootScope.searchChoose != undefined && $rootScope.searchChoose != ''){
		$scope.searchItem.searchChoose = $rootScope.searchChoose;
	}
	
	if($rootScope.searchStatus != undefined && $rootScope.searchStatus != ''){
		$scope.searchItem.searchStatus = $rootScope.searchStatus;
	}
	
	if($rootScope.categoryId != undefined && $rootScope.categoryId != ''){
		$scope.searchItem.categoryId = $rootScope.categoryId;
		$scope.categoryChange();
	}
	
	if($rootScope.categorySub != undefined && $rootScope.categorySub != ''){
		$scope.searchItem.categorySub = $rootScope.categorySub;
	}
	
	if($rootScope.searchPoint != undefined && $rootScope.searchPoint != ''){
		$scope.searchItem.searchPoint = $rootScope.searchPoint;
	}
	
	if($rootScope.startDate != undefined && $rootScope.startDate != ''){
		$scope.searchItem.startDate = $rootScope.startDate;
	}
	
	if($rootScope.endDate != undefined && $rootScope.endDate != ''){
		$scope.searchItem.endDate = $rootScope.endDate;
	}
	
	var init = function(data){
		$scope.list = data.list;
		$scope.totalItems = data.count;
		if(!$rootScope.currentPage)
			$scope.currentPage = 1;
	};	
	
	var searchParam = function() {
		var param = '&'+$httpParamSerializer($scope.searchItem);
		return param;
	};
	
	$scope.pageChanged = function() {
		$rootScope.currentPage = $scope.currentPage;
		var data = jcontext.loadJSON('/supervisor/module/contest/listPage.json?page='+$scope.currentPage + searchParam());
		init(data);
	};	
	
	$scope.checkEnter = function($event){
		var keyCode = $event.which || $event.keyCode;
	    if (keyCode === 13) {
	    	$scope.searchList();
	    }
	};
	
	$scope.searchList = function(){
		$rootScope.searchPoint = $scope.searchItem.searchPoint;
		$rootScope.searchKey = $scope.searchItem.searchKey;
		$rootScope.searchChoose = $scope.searchItem.searchChoose;
		$rootScope.searchStatus = $scope.searchItem.searchStatus;
		$rootScope.categoryId = $scope.searchItem.categoryId;
		$rootScope.categorySub = $scope.searchItem.categorySub;
		$rootScope.searchText = $scope.searchItem.searchText;
		$rootScope.startDate = $scope.searchItem.startDate;
		$rootScope.endDate = $scope.searchItem.endDate;
		$scope.pageChanged();
	};
	
	$scope.searchReset = function(){
		$scope.currentPage = 1;
		$scope.searchItem.searchPoint=null;
		$scope.searchItem.searchChoose='-1';
		$scope.searchItem.searchStatus='-1';
		$scope.searchItem.categoryId='-1';
		$scope.searchItem.categorySub='-1';
		$scope.searchItem.searchKey='title';
		$scope.searchItem.searchText=null;
		$scope.searchItem.startDate = '';
		$scope.searchItem.endDate = '';
		$scope.searchList();
	};
	$scope.searchList();
}).controller('ContestReadCtl',function($scope, $rootScope, $routeParams, $location, $route, safeApply) {
	$rootScope.leftMenu = 'adminMain';
	
	$scope.contestBtn=true;
	function setValue(data)
	{			
		$scope.item = data.item;
		$scope.register = data.register;	
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
	
	$scope.load = function(id) {
		var data = jcontext.loadJSON('/supervisor/module/contest/read.json?id='+id);
		setValue(data); 
	};
	
	$scope.load($routeParams.id);
}).directive('listContest', function() {
	return function(scope, element, attrs) {
		if(scope.$last){
			element.ready(function () {
				$(".el_txt").dotdotdot({
					watch: "window"
				});
			});
		}
	};
}).directive('numbersOnly', function () {
    return {
        require: 'ngModel',
        link: function (scope, element, attr, ngModelCtrl) {
            function fromUser(text) {
                if (text) {
                    var transformedInput = text.replace(/[^0-9]/g, '');

                    if (transformedInput !== text) {
                        ngModelCtrl.$setViewValue(transformedInput);
                        ngModelCtrl.$render();
                    }
                    return transformedInput;
                }
                return undefined;
            }            
            ngModelCtrl.$parsers.push(fromUser);
        }
    };
});
</script>
<div ng-app="Contest">  
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
