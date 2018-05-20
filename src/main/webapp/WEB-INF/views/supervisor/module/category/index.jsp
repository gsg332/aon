<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/supervisor/include/header.jsp" %>
<script src="<c:url value="/resources/js/directives/aon.tree.diretives.js"/>" type="text/javascript"></script>
<link href="<c:url value="/resources/css/tree.css"/>" rel="stylesheet">
<script type="text/javascript">
var category = angular.module('category', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize', 'aon.admin.diretives', 'aon.tree.directives'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider){
	$routeProvider.when('/', {
		controller : 'CategoryListCtl',
		templateUrl : jcontext.getContextPath('/supervisor/module/category/list.aon')
	}).otherwise({
		redirectTo : '/'
	});
});
category.controller('CategoryListCtl', function($cookies, $scope, $filter, $rootScope){
	$rootScope.leftMenu = 'category';	
	$scope.name = '';
	$scope.nameList = {};
	$scope.className = '';
	$scope.item = null;
	$scope.forEnd = false;
	$scope.defaultLocale = $cookies.get('defaultLocale');
	$scope.alertText = '';
	
	$(angular.element(error)[0]).on('hidden.bs.modal', function() {
		$scope.$apply(function() {
			$scope.load();
		});
	});
	
	$scope.load = function() {
		$scope.addView = false;
		$scope.updateView = false;
		init();
	}
	
	var init = function(){
		var data = jcontext.loadJSON('/sys/category/list.json');
		$scope.masterTree = data.list;
		$scope.locales = jcontext.getLocalesValue($cookies);
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
				if(nodes[i]['name'].indexOf('{') > -1 && nodes[i]['name'].indexOf('{') > -1){
					nodes[i]['nameList'] = jQuery.parseJSON(nodes[i]['name']);
				}else{
					nodes[i]['nameList'] = jQuery.parseJSON('{"' + $scope.defaultLocale + '" :' + '"' + nodes[i]['name'] + '"}');
				}
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
	
	$scope.topNode = function() {
		if (!$scope.$root.currentNode) {
			new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectCategory')});
			return false;
		} else {
			if($scope.$root.currentNode.parentId == 0){
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFail')});
				return false;
			}
			$scope.forEnd = false;
			var parentNode = $scope.getParentNode($scope.tree, $scope.$root.currentNode.parentId);
			var index = $scope.getNodeIndex(parentNode.children, $scope.$root.currentNode);
			if (index > 0) {
				jcontext.jsonAction('/sys/category/topNode.json','id='+$scope.$root.currentNode.id+'&parentId='+parentNode.id,
					{message:i18n.getLang('common','moved')
						,callback: function(data){
							$scope.$root.currentNode.sort = parentNode.children[0].sort - 1;
							parentNode.children.splice(index,1);
							parentNode.children.unshift($scope.$root.currentNode);
						}
					}
					,{ message:i18n.getLang('common','error'),
						callback: function(e){
							$(angular.element(error)[0]).modal();
						}
					}
				);
			} else {
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFirst')});
				return false;
			}
		}
	}
	
	$scope.upNode = function() {
		if (!$scope.$root.currentNode) {
			new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectCategory')});
			return false;
		} else {
			if($scope.$root.currentNode.parentId == 0){
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFail')});
				return false;
			}
			$scope.forEnd = false;
			var parentNode = $scope.getParentNode($scope.tree, $scope.$root.currentNode.parentId);
			var index = $scope.getNodeIndex(parentNode.children, $scope.$root.currentNode);
			if (index > 0) {
				jcontext.jsonAction('/sys/category/swapNode.json','upId='+parentNode.children[index].id+'&upParentId='+parentNode.children[index].parentId+'&upSort='+parentNode.children[index].sort+'&downId='+parentNode.children[index-1].id+'&downParentId='+parentNode.children[index-1].parentId+'&downSort='+parentNode.children[index-1].sort,
					{message:i18n.getLang('common','moved')
						,callback: function(data){
							tmpNode = parentNode.children[index-1];
							var tempSort = tmpNode.sort;
							parentNode.children[index] = tmpNode;
							parentNode.children[index].sort = $scope.$root.currentNode.sort;
							parentNode.children[index-1] = $scope.$root.currentNode;
							parentNode.children[index-1].sort = tempSort;
						}
					}
					,{ message:i18n.getLang('common','error'),
						callback: function(e){
							$(angular.element(error)[0]).modal();
						}
					}
				);
			} else {
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFirst')});
				return false;
			}
		}
	}

	$scope.downNode = function() {
		if (!$scope.$root.currentNode) {
			new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectCategory')});
			return false;
		} else {
			if($scope.$root.currentNode.parentId == 0){
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFail')});
				return false;
			}
			$scope.forEnd = false;
			var parentNode = $scope.getParentNode($scope.tree, $scope.$root.currentNode.parentId);
			var index = $scope.getNodeIndex(parentNode.children, $scope.$root.currentNode);
			if (index < parentNode.children.length - 1) {
				jcontext.jsonAction('/sys/category/swapNode.json','upId='+parentNode.children[index+1].id+'&upParentId='+parentNode.children[index+1].parentId+'&upSort='+parentNode.children[index+1].sort+'&downId='+parentNode.children[index].id+'&downParentId='+parentNode.children[index].parentId+'&downSort='+parentNode.children[index].sort,
					{message:i18n.getLang('common','moved')
						,callback: function(data){
							tmpNode = parentNode.children[index+1];
							var tempSort = tmpNode.sort;
							parentNode.children[index] = tmpNode;
							parentNode.children[index].sort = $scope.$root.currentNode.sort;
							parentNode.children[index+1] = $scope.$root.currentNode;
							parentNode.children[index+1].sort = tempSort;
						}
					}
					,{ message:i18n.getLang('common','error'),
						callback: function(e){
							$(angular.element(error)[0]).modal();
						}
					}
				);
			} else {
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveLast')});
				return false;
			}
		}
	}
	
	$scope.bottomNode = function() {
		if (!$scope.$root.currentNode) {
			new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectCategory')});
			return false;
		} else {
			if($scope.$root.currentNode.parentId == 0){
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFail')});
				return false;
			}
			$scope.forEnd = false;
			var parentNode = $scope.getParentNode($scope.tree, $scope.$root.currentNode.parentId);
			var index = $scope.getNodeIndex(parentNode.children, $scope.$root.currentNode);
			if (index < parentNode.children.length - 1) {
				jcontext.jsonAction('/sys/category/bottomNode.json','id='+$scope.$root.currentNode.id+'&parentId='+parentNode.id,
					{message:i18n.getLang('common','moved')
						,callback: function(data){
							$scope.$root.currentNode.sort = parentNode.children[parentNode.children.length - 1].sort + 1;
							parentNode.children.splice(index,1);
							parentNode.children.push($scope.$root.currentNode);	
						}
					}
					,{ message:i18n.getLang('common','error'),
						callback: function(e){
							$(angular.element(error)[0]).modal();
						}
					}
				);
			} else {
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveLast')});
				return false;
			}
		}
	}
	
	$scope.addNode = function() {
		if (!$scope.$root.currentNode) {
			$scope.$root.currentNode = [];
			$scope.$root.currentNode.id = '0';
		}
		$scope.addView = true;
		$scope.updateView = false;
		$scope.name = ''; 
		$scope.nameList = {};
		$scope.className = '';
	}	
	
	$scope.submitAdd = function() {
		if (!$scope.$root.currentNode) {
			new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectParent')});
			return false;
		} else {
			$(angular.element).find('input[name=parentId]').val($scope.$root.currentNode.id);
			jcontext.formSubmit($('form[name=categoryWriteForm]'),'/sys/category/addNode.json',
				{message:i18n.getLang('common','register')
					,callback: function(data){
						$scope.$apply(function() {
							$scope.item = angular.fromJson(data);
							$scope.name = JSON.stringify($scope.nameList);
							var item = {id: $scope.item.category.id, parentId: $scope.$root.currentNode.id, name: $scope.name, className : $scope.className, nameList: $scope.nameList, rootId: $scope.item.category.rootId};
							if($scope.$root.currentNode.id > 0){
								if ($scope.$root.currentNode.children) {
									$scope.$root.currentNode.children.push(item);
								} else {
									$scope.$root.currentNode.children = [item];
								}	
							}else{
								$scope.tree.push(item);
							}
							$scope.$root.currentNode.selected = '';
							$scope.$root.currentNode = null;
						});
					}
			   	}
				,{ message:i18n.getLang('common','error'),
					callback: function(e){
						$(angular.element(error)[0]).modal();
					}
				}
			);
		}
		$scope.addView = false;
	}

	$scope.updateNode = function() {
		if (!$scope.$root.currentNode) {
			new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectUpdateCategory')});
			return false;
		} else {
			$scope.addView = false;
			$scope.updateView = true;
			$scope.name = $scope.$root.currentNode.name;
			$scope.nameList = $scope.$root.currentNode.nameList;
			$scope.className = $scope.$root.currentNode.className;
			$(angular.element).find('input[name=id]').val($scope.$root.currentNode.id);
		}
	}
	
	$scope.submitUpdate = function() {
		if (!$scope.$root.currentNode) {
			new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectUpdateCategory')});
			return false;
		} else {
			$scope.name = JSON.stringify($scope.nameList);
			jcontext.formSubmit($('form[name=categoryUpdateForm]'),'/sys/category/updateNode.json',
				{message:i18n.getLang('common','modify')
					,callback: function(data){
			  			$scope.$apply(function() {
			  				$scope.$root.currentNode.name = JSON.stringify($scope.nameList);
			  				$scope.$root.currentNode.nameList = $scope.nameList;
			  				$scope.$root.currentNode.className = $scope.className;
			  				$scope.$root.currentNode.selected = '';
			  				$scope.$root.currentNode = null;
			  			});
					}
				}
				,{ message:i18n.getLang('common','error'),
					callback: function(e){
						$(angular.element(error)[0]).modal();
					}
				}
			);
			$scope.updateView = false;
		}
	}
	
	$scope.deleteNode = function() {
		if (!$scope.$root.currentNode) {
			new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectDeleteCategory')});
			return false;
		} else {
			if (!$scope.$root.currentNode.children) {
				var count = jcontext.loadJSON('/supervisor/module/contest/getContentsCount.json?categoryId='+$scope.$root.currentNode.id);
				if (count.contentsCount[0] > 0) {
					new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','requestContentsMove')});
					return false;
				} else {
					jcontext.jsonAction('/sys/category/deleteNode.json','id='+$scope.$root.currentNode.id+'&parentId='+$scope.$root.currentNode.parentId,
						{message:i18n.getLang('common','delete')
							,callback: function(data){
								$scope.$apply(function() {
									$scope.forEnd = false;
									$scope.addView = false;
									$scope.updateView = false;
									if($scope.$root.currentNode.parentId > 0){
										var parentNode = $scope.getParentNode($scope.tree, $scope.$root.currentNode.parentId);
										var i = $scope.getNodeIndex(parentNode.children, $scope.$root.currentNode);
										parentNode.children.splice(i,1);
										if (parentNode.children.length == 0) {
								        	delete parentNode.children;
								        }
									}else{
										var i = $scope.getNodeIndex($scope.tree, $scope.$root.currentNode);
										$scope.tree.splice(i,1);
									}
									$scope.$root.currentNode.selected = '';
									$scope.$root.currentNode = null;
								});
							}
						}
						,{ message:i18n.getLang('common','error'),
							callback: function(e){
								$(angular.element(error)[0]).modal();
							}
						}
					);
				}
			} else {
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','deleteChild')});
				return false;
			}
		}
	}
	
	$scope.moveNode = function() {
		if (!$scope.$root.currentNode) {
			new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectCategory')});
			return false;
		} else {
			$scope.addView = false;
			$scope.updateView = false;
			$rootScope.contentsFlag = false;
			if($scope.$root.currentNode.parentId == 0){
				$scope.$root.currentNode.selected = '';
				$scope.$root.currentNode = null;
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFail')});
				return false;
			}
			var count = jcontext.loadJSON('/supervisor/module/contest/getContentsCount.json?categoryId='+$scope.$root.currentNode.id);
			if (count.contentsCount[0] > 0) {
				$scope.$root.currentNode.selected = '';
				$scope.$root.currentNode = null;
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','requestContentsMove')});
				return false;
			}else{
				$scope.alertText = i18n.getLang('category','moveCategory');
				$(angular.element(alertText)[0]).modal();
				$rootScope.moveFlag = true;
				$rootScope.moveChildren = $scope.getIsChildren($scope.$root.currentNode['children']);
				$scope.forEnd = false;
				$rootScope.moveNode = $scope.getParentNode($scope.tree, $scope.$root.currentNode.parentId);
		        $rootScope.moveNodeNum = $scope.getNodeIndex($rootScope.moveNode.children, $scope.$root.currentNode);
			}
		}
	}
	
	$scope.contentsMove = function() {
		if (!($scope.$root.currentNode)) {
			new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectParent')});
			return false;
		} else {
			$scope.addView = false;
			$scope.updateView = false;
			$rootScope.moveFlag = false;
			if($scope.$root.currentNode.parentId == 0){
				$scope.$root.currentNode.selected = '';
				$scope.$root.currentNode = null;
				new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFail')});
				return false;
			}
			$scope.alertText = i18n.getLang('category','moveCategory');
			$(angular.element(alertText)[0]).modal();
			$rootScope.contentsFlag = true;
			$scope.forEnd = false;
			$rootScope.moveNode = $scope.getParentNode($scope.tree, $scope.$root.currentNode.parentId);
	        $rootScope.moveNodeNum = $scope.getNodeIndex($rootScope.moveNode.children, $scope.$root.currentNode);
		}
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

});
</script>
<div ng-app="category">  
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
