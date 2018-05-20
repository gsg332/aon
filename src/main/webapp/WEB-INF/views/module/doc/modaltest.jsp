<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
 <style type="text/css"> 
.file_input_div     {position: relative;width:90px;height:26px;overflow: hidden; } 
.file_input_button  {width: 90px;position:absolute;top:0px; 
border:none; font-size:12px;height:16px;margin-left:2px; } 
.file_input_hidden {font-size:45px;position:absolute;right:0px;top:0px;cursor:pointer;opacity:0;filter:alpha(opacity=0);-ms-filter:"alpha 
(opacity=0)";-khtml-opacity:0;-moz-opacity:0;}
</style>
<script>
(function() {
	"use strict"
	 angular.module('mainApp', [ 'ngSanitize', 'ui.bootstrap','aon.input.directives' ])
	 .config(function ($httpProvider) {   ///이렇게 추가 하지 않으면 json request 처리하여 오류발생  
	  	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
	}).controller('TestUiController', [ '$scope','$uibModal' ,function($scope,$uibModal) {
		$scope.items = ['item1', 'item2', 'item3'];
		$scope.animationsEnabled = true;
		$scope.open = function (size) {

		    var modalInstance = $uibModal.open({
		      animation: $scope.animationsEnabled,
		      templateUrl:jcontext.getContextPath('/module/doc/myModalContent.aon'),
		      controller: 'ModalInstanceCtrl',
		      size: size,
		      resolve: {
		        items: function () {
		          return $scope.items;
		        }
		      }
		    });
		    
		    modalInstance.result.then(function (selectedItem) {
		        $scope.selected = selectedItem;
		      }, function () {
		        //$log.info('Modal dismissed at: ' + new Date());
		      });
		  };
/*
		  $scope.toggleAnimation = function () {
			    $scope.animationsEnabled = !$scope.animationsEnabled;
		  };
*/
	   
	}])
	.service('DocItemSvc', [ '$http', function($http) {

	} ]);
})();




/////////modal용으로  합치기 
angular.module('mainApp').controller('ModalInstanceCtrl', function ($scope, $uibModalInstance, items) {

	  $scope.items = items;
	  $scope.selected = {
	    item: $scope.items[0]
	  };

	  $scope.ok = function () {
	    $uibModalInstance.close($scope.selected.item);
	  };

	  $scope.cancel = function () {
	    $uibModalInstance.dismiss('cancel');
	  };
	});
</script>
<div class="container" ng-app="mainApp" ng-controller="TestUiController">

    <div ng-show="selected">Selection from a modal: {{ selected }}</div>

    <button type="button" class="btn btn-default" ng-click="open()">Open me!</button>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
