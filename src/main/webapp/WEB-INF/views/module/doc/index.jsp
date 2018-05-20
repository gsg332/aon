<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
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
var docItem = angular.module('DocItem', ['ngRoute','ngSanitize', 'ui.bootstrap','aon.input.directives'])
.config(function ($httpProvider) {
	  $httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider)
{
	$routeProvider.when('/', {
		controller : 'DocItemListCtl',
		templateUrl : jcontext.getContextPath('/module/doc/listup.aon')
	}).when('/view/:id', {
		controller : 'DocItemReadCtl',
		templateUrl : jcontext.getContextPath('/module/doc/view.aon')
	}).when('/edit/:id', {
		controller : 'DocItemEditCtl',
		templateUrl : jcontext.getContextPath('/module/doc/edit.aon')
	}).when('/write', {
		controller : 'DocItemWriteCtl',
		templateUrl : jcontext.getContextPath('/module/doc/write.aon')
	}).otherwise({
		redirectTo : '/'
	});
});

docItem.controller('DocItemListCtl',function($scope){
	var init = function(data) {
		$scope.list = data.list;
		$scope.totalItems = data.count;
		if (!$scope.currentPage)
			$scope.currentPage = 1;
	}

	$scope.pageChanged = function() {
		var data = jcontext.loadJSON('/module/doc/list.json?page='+ $scope.currentPage);
		init(data);
	};
	$scope.pageChanged();
})
.controller('DocItemWriteCtl',function($scope,$location){
	
	$scope.item;
	$scope.submit = function(){
		
		if($scope.mForm.$valid){
	          $scope.$broadcast("SUBMIT");
			  jcontext.formSubmit($("form[name*='mForm']"),"/module/doc/register.json",
			  	 {message:'등록되었습니다.'
			     ,callback: function(data){
				  			 $scope.$apply(function() {
				        		$location.path("/");
				  			  });
			  			    }
			   	}
			   ,{ message:'오류가 발생하였습니다.'
				}
			);
		}else{
			return false;
		}
	}
})
.controller('DocItemReadCtl',function($scope, $routeParams,$location,safeApply) {
	function setValue(data)
	{			
		$scope.item = data.item;
	}

	$scope.load = function(id) {
		var data = jcontext.loadJSON('/module/doc/read.json?id='+id);
		setValue(data);
	};
	
	$scope.load($routeParams.id);
	
	$scope.deleteItem = function(){
		 jcontext.jsonAction('/module/doc/delete.json','id='+$scope.item.id,
			  	 {message:'삭제되었습니다.'
			     ,callback: function(data){
			    	 safeApply($scope,function() {
			        		$location.path("/");
			  			  });
		  			    }
			   	}
			);
		
	}
})
.controller('DocItemEditCtl',function($scope,$location,$routeParams) {
	$scope.item;

	$scope.load = function(id) {
		var data = jcontext.loadJSON('/module/doc/readForUpdate.json','id='+id,
				//callback이 없으면 이전 페이지로.
		function(){
			 $scope.$apply(function() {
	        		$location.path("/view/"+id);
	  	    })
		});
		$scope.item = data.item;
	};

	$scope.submit = function() {
		if ($scope.mForm.$valid) {
			 $scope.$broadcast("SUBMIT");
		    jcontext.formSubmit($("form[name*='mForm']"),"/module/doc/update.json",
				  	 {message:'수정 되었습니다.'
					     ,callback: function(data){
						  			 $scope.$apply(function() {
						        		$location.path("/");
						  			  });
					  			    }
					   	}
					   ,{ message:'오류가 발생하였습니다.'
						}
					);
		} else {
			return false;
		}
	}
	$scope.load($routeParams.id);
});
</script>
<div role="main" ng-app="DocItem">
 <div ng-view></div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
