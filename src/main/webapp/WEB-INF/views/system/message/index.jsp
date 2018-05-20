<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/system/include/header.jsp" %>
<script src="<c:url value="/resources/js/directives/aon.tree.diretives.js"/>" type="text/javascript"></script>
<link href="<c:url value="/resources/css/tree.css"/>" rel="stylesheet">
<script type="text/javascript">
var message = angular.module('message', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize', 'aon.tree.directives', 'Filters'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider)
{
	$routeProvider.when('/', {
		controller : 'MessageListCtl',
		templateUrl : jcontext.getContextPath('/system/message/list.aon')
	}).otherwise({
		redirectTo : '/'
	});
});

message.controller('MessageListCtl', function($cookies, $scope, $filter, $rootScope){
	$rootScope.leftMenu = 'message';
	
	$rootScope.messageConfig = true;
	$rootScope.defaultLocale = $cookies.get('defaultLocale');
	$scope.localeThis = jcontext.getLocale($cookies);
	$scope.locales = jcontext.getLocalesValue($cookies);
 	$rootScope.item;
	
	$scope.load = function() {
		$rootScope.updateView = false;
		init();
	}
	
	var init = function(){
		$scope.masterTree = jcontext.loadTEXT('/system/message/json.aon');
		$scope.localeThis = jcontext.getLocale($cookies);
		$scope.initTree();
	}
	
	 $scope.initTree = function() {
		var tmpTree;
		$scope.$root.currentNode = null;
	    //console.log('start : ' + new Date().getSeconds() + '/' + new Date().getMilliseconds());
		tmpTree = angular.copy($scope.masterTree);
		tmpTree.sort(function(a, b) {
			return a.sort - b.sort;
		});
		$scope.tree = $scope.changeTreeFormat(tmpTree);
		//console.log('end : ' + new Date().getSeconds() + '/' + new Date().getMilliseconds());
	}
	  
	$scope.changeTreeFormat = function(nodes) {
		var i, key = 'id', parentKey = 'parentId', childKey = 'children';
		if (!key || key=="" || !nodes) return [];

		if ($scope.isArray(nodes)) {
			var r = [];
			var tmpNodes = {};
			for (i=0; i<nodes.length; i++) {
				tmpNodes[nodes[i][key]] = nodes[i];
			}
			$scope.tmpTree = nodes;
			for (i=0; i<nodes.length; i++) {
				if (tmpNodes[nodes[i][parentKey]] && nodes[i][key] != nodes[i][parentKey]) {
					if (!tmpNodes[nodes[i][parentKey]][childKey]) {
						tmpNodes[nodes[i][parentKey]][childKey] = [];
					}
	        	
					if(tmpNodes[nodes[i][parentKey]]['parentId'] > 0){
						tmpNodes[nodes[i][parentKey]]['collapsed'] = (true);
					}
					tmpNodes[nodes[i][parentKey]][childKey].push(nodes[i]);
				} else {
					r.push(nodes[i]);
				}
			}
			return r;
		} else {
			return [nodes];
		}
	}

	$scope.isArray = function(arr) {
		return Object.prototype.toString.apply(arr) === "[object Array]";
	}
	
	$scope.getNodeIndex = function(nodes, node) {
		if (!nodes || !node) return -1;
		for (var i=0; i<nodes.length; i++) {
			if (node === nodes[i]) return i;
		}
	}
	
	$scope.getParentNode = function(nodes, value) {
		if (!nodes) return {};
		var result;
		
		for (var i=0; i<nodes.length; i++) {
			if($scope.forEnd){
				break;
			}
			if (value == nodes[i]['id']) {
				$scope.forEnd = true;
				return nodes[i];
				break;
			}
			result = $scope.getParentNode(nodes[i]['children'], value);
		}
		return result;
	}
	
	$scope.getIsChildren = function(nodes) {
		if (!nodes) return {};
		var resultArray = [];
		for (var i=0; i<nodes.length; i++) {
			resultArray.push(nodes[i]);
			if(nodes[i]['children']){
				resultArray.push.apply(resultArray, $scope.getIsChildren(nodes[i]['children']));
			}
		}
		return resultArray;
	}

	$scope.load();
	
	$scope.submitUpdate = function() {
		if (!$scope.$root.currentNode) {
			new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectUpdateCategory')});
			return false;
		} else {
			jcontext.formSubmit($("form[name*='mForm']"),'/system/config/messageUpdate.json',
				{message:i18n.getLang('common','modify')
					,callback: function(data){
						$scope.$apply(function() {
						});
					}
				},{ message:i18n.getLang('common','error'),
					callback: function(e){
						alert(e.status);
					}
				}
			);
			$rootScope.updateView = false;
		}
	}
	
	function setValue(data){			
		$scope.item = data.list;
	}

	$scope.load = function(_id) {
		var data = jcontext.loadJSON('/system/config/classList.json?clazz='+_id);
		setValue(data);
	};
	
	$scope.setClass = function(_class){
		$scope.item.value.className = _class;
	}
})
.directive('codeReplace', function ($filter) {
    return {
		require: 'ngModel',
        link: function (scope, element, attrs, ctrl) {
            ctrl.$formatters.unshift(function (modelValue) {
                return $filter('codeHtml')(modelValue);
            });
        }
    }
});
</script>
	<div ng-app="message">
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