angular.module('aon.tree.directives', [ 'ngCookies' ,'Filters' ])
.directive("aonTreeView", function($compile, $rootScope) {
	return {
		restrict: 'AE',
		scope: {
			treeModel: '='
		},
		link: function($scope, $element, $attrs) {
			var template = '<ul ng-repeat="node in treeModel"><li ng-class="$last ? \'last\' : \'\'">\
								<div data-ng-show="node.children.length" class="hitarea" ng-class="node.children.length && node.collapsed ? \'expandable-hitarea\' : \'collapsable-hitarea\'" data-ng-click="selectNodeHead(node)"></div>\
								<span ng-class="node.selected" ng-click="selectNode(node)">\
								<i class="collapsed" data-ng-show="node.children.length && node.collapsed"></i>\
								<i class="expanded" data-ng-show="node.children.length && !node.collapsed"></i>\
								<i class="normal" data-ng-hide="node.children.length"></i>\
								{{node.name | ctgrLang}}</span>\
								<aon-tree-view ng-hide="node.collapsed" tree-model="node.children"></aon-tree-view>\
							</li></ul>';
			
			$scope.selectNodeHead = function(node) {
				node.collapsed = !node.collapsed;
			};
			
			$scope.selectNode = function(node) {
				if ($rootScope.moveFlag) {
					if (!$scope.$root.currentNode) {
						new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','selectCategory')});
						return false;
					} else {
						var childrenCheck = true;
						if($rootScope.moveChildren) {
							for (var i=0; i<$rootScope.moveChildren.length; i++) {
								if ($rootScope.moveChildren[i]['id'] == node.id) {
									childrenCheck = false;
								}
							}
						}
						if($scope.$root.currentNode.id == node.id){
							new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFailSelect')});
							$rootScope.moveFlag = false;
							$scope.$root.currentNode.selected = '';
							$scope.$root.currentNode = null;
						} else if ($scope.$root.currentNode.rootId != node.rootId) {
							new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFailRoot')});
							$rootScope.moveFlag = false;
							$scope.$root.currentNode.selected = '';
							$scope.$root.currentNode = null;
						} else if (childrenCheck) {
							jcontext.jsonAction('/sys/category/moveNode.json','id='+$scope.$root.currentNode.id+'&parentId='+$scope.$root.currentNode.parentId+'&targetId='+node.id+'&targetParentId='+node.parentId,
								{message:i18n.getLang('common','moved')
									,callback: function(data){
										$rootScope.moveNode.children.splice($rootScope.moveNodeNum,1);
										if ($rootScope.moveNode.children.length == 0) {
								        	delete $rootScope.moveNode.children;
								        }
										$scope.$root.currentNode.parentId = node.id;
										if (node.children) {
											node.children.push($scope.$root.currentNode);
										} else {
											node.children = [$scope.$root.currentNode];
										}
										$rootScope.moveFlag = false;
									}
								}
								,{ message:i18n.getLang('common','error'),
									callback: function(e){
										$rootScope.moveFlag = false;
										$(angular.element(error)[0]).modal();
									}
								}
							);
						} else {
							new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFailChild')});
							$rootScope.moveFlag = false;
							$scope.$root.currentNode.selected = '';
							$scope.$root.currentNode = null;
						}
					}
				} else if($rootScope.contentsFlag) {
					var childrenCheck = true;
					if($rootScope.moveChildren) {
						for (var i=0; i<$rootScope.moveChildren.length; i++) {
							if ($rootScope.moveChildren[i]['id'] == node.id) {
								childrenCheck = false;
							}
						}
					}
					if($scope.$root.currentNode.id == node.id){
						new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFailSelect')});
						$rootScope.contentsFlag = false;
						$scope.$root.currentNode.selected = '';
						$scope.$root.currentNode = null;
					} else if ($scope.$root.currentNode.rootId != node.rootId) {
						new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFailRoot')});
						$rootScope.contentsFlag = false;
						$scope.$root.currentNode.selected = '';
						$scope.$root.currentNode = null;
					} else if (childrenCheck) {
						jcontext.jsonAction('/supervisor/module/contest/moveContents.json','id='+$scope.$root.currentNode.id+'&parentId='+$scope.$root.currentNode.parentId+'&targetId='+node.id+'&targetParentId='+node.parentId,
							{message:i18n.getLang('common','moved')
								,callback: function(data){
									$rootScope.contentsFlag = false;
								}
							}
							,{ message:i18n.getLang('common','error'),
								callback: function(e){
									$rootScope.contentsFlag = false;
									$(angular.element(error)[0]).modal();
								}
							}
						);
					} else {
						new PageAlert({'type':'danger','title':' ','message':i18n.getLang('category','moveFailChild')});
						$rootScope.contentsFlag = false;
						$scope.$root.currentNode.selected = '';
						$scope.$root.currentNode = null;
					}
				}else{
					if ($scope.$root.currentNode && $scope.$root.currentNode.selected) {
						$scope.$root.currentNode.selected = '';
					}
					node.selected = 'selected';
					$scope.$root.currentNode = node;
				}
				if($rootScope.messageConfig) {
					if($scope.$root.currentNode.parentId > 0){
						$rootScope.updateView = true;
						$(angular.element).find('input[name=key]').val($scope.$root.currentNode.id);
						
						var data = jcontext.loadJSON('/system/config/classRead.json?clazz='+$scope.$root.currentNode.id);
						$rootScope.item = data;
						if($rootScope.item.value != null){
							if($rootScope.item.value.indexOf('{') > -1 && $rootScope.item.value.indexOf('{') > -1){
								$rootScope.item.value = jQuery.parseJSON($rootScope.item.value);
							} else {
								$rootScope.item.value = jQuery.parseJSON('{"' + $rootScope.defaultLocale + '" :' + '"' + $rootScope.item.value + '"}');
							}
						}
					}else{
						$rootScope.updateView = false;
					}
				}
			}
				
			$element.html('').append($compile(template)($scope));			
		}
	}
});