<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/supervisor/include/header.jsp" %>
<script type="text/javascript">
var memberApp = angular.module('member', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize', 'aon.admin.diretives'])
.run(function($rootScope, $http){
  	 /**
	 * 중복체크 확인용 ajax 메소드
	 * 중복체크 후 중복되었으면 false, 중복되지 않았으면 true 반환
	 */
	$rootScope.chkDuplicate = function(value, type){
		if(type == 'nick'){
			var param = {nickname : value, memberId : $rootScope.memberId};
			var data = jcontext.postJSON('/sys/member/duplicateNickCheck.json', param);
			return data.nickChk;
		}
	 };
})
.config(function ($httpProvider){
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider){
	$routeProvider.when('/', {
		controller : 'MemberListCtl',
		templateUrl : jcontext.getContextPath('/supervisor/member/listup.aon')
	}).when('/view/:id', {
		controller : 'MemberViewCtl',
		templateUrl : jcontext.getContextPath('/supervisor/member/view.aon')
	}).otherwise({
		redirectTo : '/'
	});
})
.service('MemberService', function($location){
	this.categoryChange = function(index, $scope){
		if ($scope.depth1 != '0') {
			if(index == 1){
				$scope.depth2 = '0';
				$scope.tag1 = '';
				$scope.depthShow1 = true;
				$scope.tagShow1 = false; 
				subCategory = jcontext.loadJSON('/module/contest/subCategoryList.json?pid='+$scope.depth1);
				$scope.subCategoryList1 = subCategory.list;
				
				if( $scope.category1[0] != 0  ){
					$scope.depth2 = $scope.category1[0].toString();
					$scope.category1[0] = 0;
				}
				if( $scope.depth2 == 0){
					$scope.category1[4] = '';
				}
				
			}else{
				$scope.depth4 = '0';
				$scope.tag2 = '';
				$scope.depthShow2 = true;
				$scope.tagShow2 = false;
				subCategory = jcontext.loadJSON('/module/contest/subCategoryList.json?pid='+$scope.depth3);
				$scope.subCategoryList2 = subCategory.list;
				
				if( $scope.category2[0] != 0  ){
					$scope.depth4 = $scope.category2[0].toString();
					$scope.category2[0] = 0;
				}
				if( $scope.depth4 == 0){
					$scope.category2[4] = '';
				}
			}
		}else{
			if(index == 1){
				$scope.depthShow1 = false;
				$scope.tagShow1 = false;
				$scope.depth1 = '0';
				$scope.depth2 = '0';
				console.log('3');
				$scope.category1[4] = '';
			}else{
				$scope.depthShow2 = false;
				$scope.tagShow2 = false;
				$scope.depth3 = '0';
				$scope.depth4 = '0';
				$scope.category2[4] = '';
				console.log('4');
			}
		}
	}
	
	this.subChange = function(index, $scope){
		var cnt = 1;
		var depth;
		var selectText;
		if(index == 1){
			depth = $scope.depth2;
			selectText = $('#depth2 option:checked').text();	
		}else{
			depth = $scope.depth4;
			selectText = $('#depth4 option:checked').text();
		}
		var compareText = i18n.getLang('category','etc');
		$scope.$evalAsync(function(){
			if (depth != '0') {
				if (selectText == compareText)	{
					if(index == 1){
						$scope.tag1 = '';
						$scope.tagShow1 = true;
						if($scope.category1[4] != ''){
							$scope.tag1 = $scope.category1[4];	
						}
					}else{
						$scope.tag2 = '';
						$scope.tagShow2 = true;
						if($scope.category2[4] != ''){
							$scope.tag2 = $scope.category2[4];
						}
					}
				} else {
					if(index == 1){
						$scope.tag1 = '';
						$scope.tagShow1 = false;
						$scope.category1[4] = '';
					}else{
						$scope.tag2 = '';
						$scope.tagShow2 = false;
						$scope.category1[4] = '';
					}
				}
			} else {
				if(index == 1){
					$scope.tag1 = '';
					$scope.tagShow1 = false;
					$scope.category1[4] = '';
				}else{
					$scope.tag2 = '';
					$scope.tagShow2 = false;
					$scope.category2[4] = '';
				}
				depth = '0';	
			}
		})
	}
})
.controller('MemberListCtl',function($scope, $http, $rootScope, $location, $httpParamSerializer){
	$scope.itemsPerPage = 10;
	var searchReset = function() {
		$scope.searchItem = {
			dateSearchKey : 'insertDate',
			startDate : '',
			endDate : '',
			statusSearchKey : 'activeMember',
			inputSearchKey : 'loginId',
			inputSearchValue : ''
		}
	};
	searchReset();
	
	if (!$scope.currentPage) {
		$scope.currentPage = 1;
	}
	
	var init = function(data){
		$scope.list = data.list;
		$scope.totalItems = data.count;
		$scope.searchItem = data.memberSearch;
	}
	
	var searchParam = function() {
		var param = '&'+$httpParamSerializer($scope.searchItem);
		return param;
	}
	
	$scope.pageChanged = function(){
		var data = jcontext.loadJSON('/supervisor/module/member/list.json?page=' + $scope.currentPage+searchParam());
		init(data);
	};
	$scope.pageChanged();
	
	$scope.search = function(){
		$scope.currentPage = 1;
		$scope.pageChanged();
	};
	
	$scope.searchCancel = function() {
		$scope.currentPage = 1;
		searchReset();
		$scope.pageChanged();
	};
	
	$scope.enterSearch = function($event){
		var keyCode = $event.which || $event.keyCode;
	    if (keyCode === 13) {
	    	$scope.search();
	    }
	}
	
	$scope.view = function(id){
		$location.path('/view/' + id);
	};
})
.controller('MemberViewCtl',function($scope, $http, $routeParams, $location, $route, $rootScope, MemberService){
	
	$scope.depth1 = '0';
 	$scope.depth2 = '0';
 	$scope.depth3 = '0';
 	$scope.depth4 = '0';
 	$scope.depthShow1 = false;
 	$scope.tagShow1 = false;
 	$scope.depthShow2 = false;
 	$scope.tagShow2 = false;
	
	var data = jcontext.loadJSON('/supervisor/module/member/readForUpdate.json?id=' + $routeParams.id);
	$scope.member = data.item;
	$rootScope.memberId = $scope.member.id; //닉네임 중복확인용.
	
	var bankData = jcontext.loadJSON('/supervisor/module/bankAccount/getBankAccountInfo.json?id=' + $routeParams.id);
	$scope.bankAccount = bankData.bankAccount;
	
	var cyberData = jcontext.loadJSON('/supervisor/module/cyberAccount/read.json?memberId=' + $routeParams.id);
	$scope.cyberAccount = cyberData.item;
	
	$scope.back = function(){
		$location.path('/');
	}
	
	var categoryData = jcontext.loadJSON('/sys/category/getListByParent.json?pid=whatinfo');
	$scope.categoryList = categoryData.list;
	
	$scope.categoryList = categoryData.list;
	
	var categoriesData = jcontext.postJSON('/supervisor/module/member/getSpecialty.json?memberId=' + $routeParams.id);
	$scope.category1 = categoriesData.list[0]; 
	$scope.category2 = categoriesData.list[1];
	
	if($scope.category1 != null || $scope.category1 != undefined){
		var category1 = $scope.category1;
		$scope.depthShow1 = true;
		$scope.depth1 = category1[1].toString();
		MemberService.categoryChange(1, $scope); //셀렉트박스 체인지 이벤트
		setTimeout(function(){
			MemberService.subChange(1, $scope);
		}, 300);
	}
	
	if($scope.category2 != null || $scope.category2 != undefined){
		var category2 = $scope.category2;
		$scope.depthShow2 = true;
		$scope.depth3 = category2[1].toString();
		MemberService.categoryChange(2, $scope); //셀렉트박스 체인지 이벤트
		setTimeout(function(){
			MemberService.subChange(2, $scope);
		}, 300);	
	}
	
	$scope.categoryChange = function(index){
		MemberService.categoryChange(index, $scope); //셀렉트박스 체인지 이벤트
	}
	
	$scope.subChange = function(index) {
		MemberService.subChange(index, $scope);
	}

	//국가 데이터 로드
    $http.get(jcontext.getLocationPath('/sys/member/getNations.json'))
		.success(function(data) {
			$scope.nationList = data.nationList;
		})
		.error(function (data) {
			new PageAlert({'type':'success','title':i18n.getLang('member','nation'),'message':i18n.getLang('member','nationError')});
		});
	//닉네임 중복체크
	
	$scope.memberModify = function(){
		
		if($('input[name=imgfile]').val() != ''){
			$('#isImageChange').val('true');
		};
		$scope.$broadcast("SUBMIT");
		jcontext.formSubmit($("form[name*='updateForm']") ,jcontext.getLocationPath("/supervisor/module/member/modify.json"), {
			message: i18n.getLang('member','updateSuccess'),
			callback: function(data){
				$route.reload(); //파일을 저장한 후라면 파일이 세팅이 되어 있어 다시 바로 저장시 오류가 발생
			}
		},
		{
			message:i18n.getLang('member','updateFail'),
			callback: function(e){
				var error = jQuery.parseJSON(e.responseText);
				if(error.exname.indexOf('BeforePasswordException') > -1){
					this.message = i18n.getLang('member','beforePasswordError');	
				}
  				//alert(e.status);
			}
		});
	}
	
	var bankSplit = function(){
		var bankType = i18n.getLang('bankAccount','bankType');
		var bank = bankType.split(':');
		$scope.bank = {'code':bank[0], 'name':bank[1]};
	}
	bankSplit();
	
	$scope.nationChange = function(){
		var index = $("select#countryCode > option:selected").index();
		var $cellPhoneCountryCode = $('#cellPhoneCountryCode');
		var $phoneCountryCode = $('#phoneCountryCode');
		$phoneCountryCode.children('option').eq(index).prop("selected", "selected");
		$cellPhoneCountryCode.children('option').eq(index).prop("selected", "selected");
 		if(index > 0){
 			$cellPhoneCountryCode.parent().removeClass('has-error').addClass('has-success');	
 		}else{
 			$cellPhoneCountryCode.parent().removeClass('has-success').addClass('has-error');
 		}
	}
})
.directive('requiredSelect', function () {
	return {
		restrict: 'AE',
		require: 'ngModel',
		link: function($scope, $element, $attrs, $formCtrl) {
			var compareText = i18n.getLang('category','etc');
			var selectText = $($element[0]).find('option:selected').text();
			//카테고리 값 null방지를 위한 초기값
			$scope.depthValue1 = 0;
			$scope.depthValue2 = 0;
			
			if($scope.category1 != undefined && $scope.category1.length != 0){
				if($scope.category1[4] == null){
					$scope.depth1 = $scope.category1[1].toString();	
					$scope.depthValue1 = $scope.depth1; 
				}else{
					$scope.depth1 = $scope.category1[3].toString();
					$scope.depth2 = $scope.category1[1].toString();
					$scope.depthShow1 = true;
					$scope.tagShow1 = false;
					setTimeout(function(){
						if($scope.category1[8] == compareText){
							$scope.$evalAsync(function(){
								$scope.tagShow1 = true;
								$scope.tag1 = $scope.category1[7].toString();
							});
						}
					},200);	
					$scope.depthValue1 = $scope.depth2;
					$($element).parent().find('.has-feedback').addClass('has-success').removeClass('has-error');
				}
				subCategory = jcontext.loadJSON('/sys/category/getListByParent.json?pid='+$scope.depth1);
				$scope.subCategoryList1 = subCategory.list;
			};
			
			if($scope.category2 != undefined && $scope.category2.length != 0){
				if($scope.category2[4] == null){
					$scope.depth3 = $scope.category2[1].toString();	
					$scope.depthValue2 = $scope.depth3; 
				}else{
					$scope.depth3 = $scope.category2[3].toString();
					$scope.depth4 = $scope.category2[1].toString();
					$scope.depthShow2 = true;
					$scope.tagShow2 = false;
					$scope.tag2 = $scope.category2[7].toString();
					setTimeout(function(){
						if($scope.category2[8] == compareText){
							$scope.$evalAsync(function(){
								$scope.tagShow2 = true;
								$scope.tag2 = $scope.category2[7].toString();
							});
						}
					},200);	
					$scope.depthValue2 = $scope.depth4;
					$($element).parent().find('.has-feedback').addClass('has-success').removeClass('has-error');
				}
				subCategory = jcontext.loadJSON('/sys/category/getListByParent.json?pid='+$scope.depth3);
				$scope.subCategoryList2 = subCategory.list;
			};
			
			$element.off().on('change', function(){
				if($attrs.index == 1){
					$(angular.element(depth1)).parent().find('.tooltip').tooltip('hide');
					$scope.depthShow1 = false;
					$scope.tagShow1 = false;
				}else{
					$(angular.element(depth3)).parent().find('.tooltip').tooltip('hide');
					$scope.depthShow2 = false;
					$scope.tagShow2 = false;
				}
				
				if($element[0].value == '0'){ //값이 없을때
					if($attrs.index == 1){
						$scope.$evalAsync(function(){
							$scope.depthShow1 = false;
							$scope.tagShow1 = false;
							$scope.depth1 = '0';
							$scope.depth2 = '0';
							if($scope.category1.length != 0){
								$scope.category1.tag = '';
							}
							$scope.depthValue1 = 0;
						})
					}else{
						$scope.$evalAsync(function(){
							$scope.depthShow2 = false;
							$scope.tagShow2 = false;
							$scope.depth3 = '0';
							$scope.depth4 = '0';
							if($scope.category2.length != 0 ){
								$scope.category2.tag = '';
							}
							$scope.depthValue2 = 0;
						})
					}				
				}else{ //값이 있을때 첫번째 셀렉트 박스
					subCategory = jcontext.loadJSON('/sys/category/getListByParent.json?pid='+$element[0].value);
					if($attrs.index == 1){
    		  			$scope.$evalAsync(function(){
        					$scope.subCategoryList1 = subCategory.list;
        					$scope.depth2 = '0';
    						$scope.tag1 = '';
    						$scope.tagShow1 = false;
        					if($scope.subCategoryList1.length != 0){
            		  			$scope.depthShow1 = true;
        					}else{
            		  			$scope.depthShow1 = false;
        					}
        					$scope.depthValue1 = $element[0].value;
    		  			})
    		  		}else{
    		  			$scope.$evalAsync(function(){
        					$scope.subCategoryList2 = subCategory.list;
        					$scope.depth4 = '0';
        		  			$scope.tag2 = '';
        		  			$scope.tagShow2 = false;
        					if($scope.subCategoryList2.length != 0){
        						$scope.depthShow2 = true;
        					}else{
            		  			$scope.depthShow2 = false;
        					}
        					$scope.depthValue2 = $element[0].value;
    		  			})
    		  		}
				}
			}).on('focusout', function(){
    		  	
    	  	}).on('focusin', function(){
    		  	
    	  	})
      	}
	}
})
.directive('requiredSubSelect', function () {
	return {
		restrict: 'AE',
		require: 'ngModel',
		link: function($scope, $element, $attrs, $formCtrl) {
			var depth;
			var selectText;
			var compareText = i18n.getLang('category','etc');
			
			if($scope.depth2 == 0 || $scope.depth4 == 0){
				$($element).parent().addClass('has-error').removeClass('has-success');
			}			
			
			$element.off().on('change', function(){
				selectText = $($element[0]).find('option:selected').text();
					if($element[0].value == '0'){
						$(this).attr('data-original-title', $attrs.title);
						$(this).tooltip('show');
					 	$($element).parent().addClass('has-error').removeClass('has-success');
					 	
					 	if($attrs.index == 1){
							$scope.depth2 = '0'
							$scope.tag1 = '';
							$scope.tagShow1 = false;
							$scope.depthValue1 = 0;
						}else{
							$scope.depth4 = '0'
							$scope.tag2 = '';
							$scope.tagShow2 = false;
							$scope.depthValue2 = 0;
						}
						$scope.$apply(function(){
					  		$scope.memberUpdateProfileForm.$invalid = true;
					  		$scope.memberUpdateProfileForm.$valid = false;
						});
	    		  	}else{
	    			  	$($element).parent().addClass('has-success').removeClass('has-error');
	    			      			  	
	    			  	if(selectText == compareText){
	    			  		if($attrs.index == 1){
	    			  			$scope.tag1 = '';
	    			  			$scope.tagShow1 = true;
	    			  			$scope.depthValue1 = $element[0].value;
	    			  		}else{
	    			  			$scope.tag2 = '';
	    			  			$scope.tagShow2 = true;
	    			  			$scope.depthValue2 = $element[0].value;
	    			  		}
	    			  	}else{
	    			  		if($attrs.index == 1){
	    						$scope.tag1 = '';
	    						$scope.tagShow1 = false;
	    						$scope.depthValue1 = $element[0].value;
	    					}else{
	    						$scope.tag2 = '';
	    						$scope.tagShow2 = false;
	    						$scope.depthValue2 = $element[0].value;
	    					}
	    			  	}
	    			  	$scope.$apply(function(){
					  		$scope.memberUpdateProfileForm.$invalid = false;
					  		$scope.memberUpdateProfileForm.$valid = true;
						});
	    			  	
	    		  	}
    	  	}).on('focusout', function(){
    		  	if($element[0].value == '0'){
    			  	$(this).attr('data-original-title', $attrs.title);
    			  	$(this).tooltip('show');
    			  	$scope.$apply(function(){
    			  		$scope.memberUpdateProfileForm.$invalid = true;
    			  		$scope.memberUpdateProfileForm.$valid = false;
					});
    			  	$($element).parent().addClass('has-error').removeClass('has-success');
    		  	}else{
    			  	$(this).tooltip('hide');
    			  	$($element).parent().addClass('has-success').removeClass('has-error');
    			  	$scope.$apply(function(){
    			  		$scope.memberUpdateProfileForm.$invalid = false;
    			  		$scope.memberUpdateProfileForm.$valid = true;
					});
    		  	}
    	  	}).on('focusin', function(){
    		  	$(this).tooltip('hide');
    	  	})
      	}
	}
})
</script>
<div ng-app="member">
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
