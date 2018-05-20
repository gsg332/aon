<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">
var app = angular.module('myPageApp', ['ngRoute', 'ui.bootstrap','aon.input.directives','contactUs', 'Filters'])  
.run(function($rootScope, $http, $location){
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
	 $rootScope.location = $location;
 })
.config(function ($httpProvider, $routeProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
	
	$routeProvider.when('/', {
		controller : 'myPageModifyCtl',
		templateUrl : jcontext.getContextPath('/myPage/member/memberUpdateForm.aon')
	})
	.when('/memberUpdateProfileForm/', {
		controller : 'myPageProfileCtl',
		templateUrl : jcontext.getContextPath('/myPage/member/memberUpdateProfileForm.aon')
	}).otherwise({
		redirectTo : '/'
	});
})
.controller('myPageCtl', function($scope, $routeParams, $http, $location) {


})
.controller('myPageModifyCtl', function($scope, $rootScope, $window, $routeParams, $http, $location) {
 	
	$scope.init = function(){
		//접속 유저의 정보를 조회
		var data = jcontext.postJSON('/sys/member/getMemberInfo.json');
		$scope.member = data.memberInfo;
		$rootScope.memberId = data.memberInfo.id;
		
		//국가 데이터 로드
		var nation = jcontext.postJSON('/sys/member/getNations.json');
		$scope.nationCodeList = nation.nationList
	}
	$scope.init();
	
	//마이페이지 수정 submit
	$scope.memberModify = function(){
		if($scope.memberUpdateForm.$valid){
			$scope.$broadcast("SUBMIT");
			
			jcontext.formSubmit($('form[name=memberUpdateForm]'), jcontext.getLocationPath("/sys/member/memberModify.json"),
			{
				message:i18n.getLang('member','updateSuccess'),
				callback: function(data){
	 				$scope.$apply(function(){
						$location.path("/index.aon");}
					);
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
			}
		)};
	}
	
	//국가변경시 전호번호,핸드폰 코드 변경
    $scope.nationChange = function(){
		var index = $("select#countryCode > option:selected").index();
		var $cellPhoneCountryCode = $('#cellPhoneCountryCode');
		var $phoneCountryCode = $('#phoneCountryCode');
		$phoneCountryCode.find('option').eq(index).prop("selected", true);
		$cellPhoneCountryCode.find('option').eq(index).prop("selected", true);
		$scope.phoneCountryCode = $phoneCountryCode.val();
		$scope.cellPhoneCountryCode = $cellPhoneCountryCode.val(); 
 		if(index > 0){
 			$cellPhoneCountryCode.parent().removeClass('has-error').addClass('has-success');	
 		}else{
 			$cellPhoneCountryCode.parent().removeClass('has-success').addClass('has-error');
 		}
	}
	
	//취소버튼
	$scope.goIndex = function(){
		$window.history.back();
	}
	//프로필 업데이트 버튼
	$scope.profileUpdate = function(){
		$location.path('/memberUpdateProfileForm/');
	}
	
	$scope.req = false;
	
})
.controller('myPageProfileCtl', function($scope, $routeParams, $http, $location) {
	$scope.depth1 = '0';
 	$scope.depth2 = '0';
 	$scope.depth3 = '0';
 	$scope.depth4 = '0';
 	$scope.depthShow1 = false;
 	$scope.tagShow1 = false;
 	$scope.depthShow2 = false;
 	$scope.tagShow2 = false;
	
	//member profile 정보를 조회
	var data = jcontext.postJSON('/sys/member/getMemberInfo.json');
	$scope.profile = data.memberInfo.memberProfile;
	
	//bankAccount정보를 조회
	var bankData = jcontext.postJSON('/module/bankAccount/getBankAccount.json');
	$scope.bankAccount = bankData.bankAccount;
	
	var bankType = i18n.getLang('bankAccount','bankType');
	var bank = bankType.split(':');
	$scope.bank = {'code':bank[0], 'name':bank[1]};
	
	var categoryData = jcontext.loadJSON('/sys/category/getListByParent.json?pid=whatinfo');
	$scope.categoryList = categoryData.list;
	
	var categoriesData = jcontext.postJSON('/sys/member/getSpecialty.json');
	$scope.category1 = categoriesData.list[0]; 
	$scope.category2 = categoriesData.list[1];
	
	//멤버프로필 submit
	$scope.memberProfileModify = function(){
		if($('input[name=imgfile]').val() != ''){
			$('#isImageChange').val('true');
		};
		if($scope.memberUpdateProfileForm.$valid){
			$scope.$broadcast("SUBMIT");
			   jcontext.formSubmit($('form[name=memberUpdateProfileForm]'), jcontext.getLocationPath("/sys/member/memberProfileModify.json"),{
				   message:i18n.getLang('member','updateProfileSuccess') ,
				   callback: function(data){
					   	$scope.$apply(function()
							{$location.path('/memberUpdateProfileForm/');
					   	});
				   	}
			   	}
			   ,{ msssage:i18n.getLang('member','updateProfileFail'),
				  callback: function(e){
					  //alert(e.status);
				   }
				}
			);
		}
	}
	//목록으로
	$scope.goIndex = function(){
		$location.path('/');
	}
	
	//멤버수정으로 이동
	$scope.memberUpdate = function(){
		$location.path('/memberUpdateForm/');
	}
})
.directive('requiredSelect', function ($cookies) {
	return {
		restrict: 'AE',
		require: 'ngModel',
		link: function($scope, $element, $attrs, $formCtrl) {
			var compareText = i18n.getLang('category','etc');
			var selectText = $($element[0]).find('option:selected').text();
			//카테고리 값 null방지를 위한 초기값
			$scope.depthValue1 = 0;
			$scope.depthValue2 = 0;
			var etc;
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
						etc = jcontext.getLocaleValue($cookies, jQuery.parseJSON($scope.category1[8]));
						if(etc == compareText){
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
						etc = jcontext.getLocaleValue($cookies, jQuery.parseJSON($scope.category2[8]));
						if(etc == compareText){
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
	<!-- sub visual -->
    <%@ include file="/WEB-INF/views/myPage/subVisual.jsp" %>
    <!-- //sub visual -->
    
    <!-- contents -->
	<div class="contents" ng-app="myPageApp">
		<div class="container">
			<div class="wrap">
				<!-- navigation -->
				<nav>
				    <ul class="navi">
				        <li><a href='<c:url value="/index.aon"/>'><spring:message code='cmm.nav.001'/></a></li>
		                <li><a href='<c:url value="/myPage/myInfo/index.aon"/>'><spring:message code='cmm.menu.010'/></a></li>
		                <li><spring:message code='cmm.menu.015'/></li>
				    </ul>
				</nav>
				<!-- //navigation -->
				
				<!-- sub_con -->
				<div ng-view list-contest></div>
				<!-- //sub_con -->
				<!-- right_menu -->
				<div class="sub_aside">
				    <div class="rm_top">
				        <h2><spring:message code='cmm.menu.010'/></h2>
				        <ul class="right_menu">
				            <li><a href='<c:url value="/myPage/myInfo/index.aon"/>'><spring:message code='cmm.menu.011'/></a></li>
	                            <li><a href='<c:url value="/myPage/myQuestion/index.aon"/>'><spring:message code='cmm.menu.012'/></a></li>
	                            <li><a href='<c:url value="/myPage/myAnswer/index.aon"/>'><spring:message code='cmm.menu.013'/></a></li>
	                            <li><a href='<c:url value="/myPage/myPoint/index.aon"/>'><spring:message code='cmm.menu.014'/></a></li>
	                            <li ng-class="location.path() == '/' ? 'on' : ''"><a href='<c:url value="#/"/>'><spring:message code='cmm.menu.015'/></a></li>
	                            <li ng-class="location.path() == '/memberUpdateProfileForm/' ? 'on' : ''"><a href='<c:url value="/myPage/member/index.aon#/memberUpdateProfileForm"/>'><spring:message code='cmm.menu.017'/></a></li>
	                            <li><a href='<c:url value="/myPage/drop/index.aon"/>'><spring:message code='cmm.menu.016'/></a></li>
				        </ul>
				    </div>
					<%@ include file="/WEB-INF/views/include/contactUs.jsp" %>
				</div>
				<!-- //right_menu -->
	        </div>
	    </div>
	</div>
	<!-- //contents --> 
<%@ include file="/WEB-INF/views/include/footer.jsp"%>