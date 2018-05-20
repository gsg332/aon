<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/supervisor/include/header.jsp"%>
<script type="text/javascript">
var onlineask = angular.module('onlineask', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider) {
	$routeProvider.when('/', {
		controller : 'OnlineAskListCtl',
		templateUrl : jcontext.getContextPath('/supervisor/module/onlineAsk/list.aon')
	}).otherwise({
		redirectTo : '/'
	});
});

onlineask.controller('OnlineAskListCtl', function($scope, $route){
	$scope.modalOpen = function (id) {
		$scope.adminComment=null;
		var data = jcontext.loadJSON('/supervisor/module/onlineAsk/read.json?id='+id);
		$scope.items = data.item;
		$(angular.element(confirmL)[0]).modal();
	};
	
	$scope.submit = function(){
		if($scope.mForm.$valid){
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($('form[name=mForm]'),'/supervisor/module/onlineAsk/complete.json',
				  	 {message:i18n.getLang('common','register')
				     ,callback: function(data){
			  			 $scope.$apply(function() {
			  				$(angular.element(confirmL)[0]).modal('hide');
			  				$route.reload();
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
	
	var init = function(data) {
		$scope.list = data.list;
		$scope.totalItems = data.count;
		if (!$scope.currentPage)
			$scope.currentPage = 1;
	};
		
	$scope.pageChanged = function() {
		var data = jcontext.loadJSON('/supervisor/module/onlineAsk/listPage.json?page='+ $scope.currentPage);
		init(data);
	};
	$scope.pageChanged();	
});
</script>
<div ng-app="onlineask">
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

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
