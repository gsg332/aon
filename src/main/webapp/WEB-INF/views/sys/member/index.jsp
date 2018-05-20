<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">
var app = angular.module('JoinApp', ['ngRoute', 'ui.bootstrap','aon.input.directives','Filters'])  
.run(function($rootScope, $http, $route){
		 /**
		 * 중복체크 확인용 ajax 메소드
		 * 중복체크 후 중복되었으면 false, 중복되지 않았으면 true 반환
		 */ 
	$rootScope.loginId = '${member.loginId}';
	$rootScope.memberId = '${member.id}';
	
	$rootScope.chkDuplicate = function(value, type){
		if(type == 'nick'){
			var param = {nickname : value, memberId : $rootScope.memberId};
			var data = jcontext.postJSON('/sys/member/duplicateNickCheck.json', param);
			return data.nickChk;
		}
	 };
	 $rootScope.$route = $route;
 })
.config(function ($httpProvider, $routeProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };

	$routeProvider.when('/', {
		controller : 'joinForm1Ctl',
		templateUrl : jcontext.getContextPath('/sys/member/joinForm.aon')
	})
	.when('/joinForm2/:type', {
		controller : 'joinForm2Ctl',
		templateUrl : jcontext.getContextPath('/sys/member/joinForm2.aon'),
	})
	.when('/joinForm3/', {
		controller : 'joinForm3Ctl',
		templateUrl : jcontext.getContextPath('/sys/member/joinForm3.aon'),
		resolve : {
			inputParams : function($route){ $route.current }
		}
	}).when('/findLoginPw/', {
		controller : 'findLoginPwCtl',
		templateUrl : jcontext.getContextPath('/sys/member/findLoginPw.aon')
	}).when('/findLoginPwResult/', {
		controller : 'findLoginPwResultCtl',
		templateUrl : jcontext.getContextPath('/sys/member/findLoginPwResult.aon')
	}).when('/emailConfirm/', {
		controller : 'emailConfirmCtl',
		templateUrl : jcontext.getContextPath('/sys/member/emailConfirm.aon')
	}).otherwise({
		redirectTo : '/'
	});
})
.service('joinFormSrv', function(){
		return {};
})
.controller('joinForm1Ctl', function($scope, $rootScope, $routeParams, joinFormSrv, $http, $location) {
	//로그인 아이디가 없을시 뒤로 튕김
	if($rootScope.loginId == null || $rootScope.loginId == '' || $rootScope.loginId == undefined){
		new PageAlert({'type':'danger','title':'','message':i18n.getLang('member','wrongway')});
		$location.path("/emailConfirm/");
	}
	
	$scope.joinFormSrv = joinFormSrv;
	
	
})
.controller('joinForm2Ctl', function($scope, $rootScope, $routeParams, joinFormSrv, $http, $location) {
	//개인회원, 기업회원 구분
	$scope.type = $routeParams['type'];
	
	$scope.joinFormSrv = joinFormSrv;
	$scope.loginId = $rootScope.loginId;
	
	$scope.goIndex = function(){
		joinFormSrv.goIndex();
	}
	
	//타입이 없을시 첫페이지로 튕김
	$scope.init = function(){
		//개인or기업 타입값이 없음 튕김
		if ($scope.type == undefined){
			new PageAlert({'type':'danger','title':'','message':i18n.getLang('member','wrongway')});
			$location.path("/emailConfirm/");
		}
		
		//국가 데이터 로드
		var nation = jcontext.loadJSON('/sys/member/getNations.json');
		$scope.nationList = nation.nationList
		$scope.compareLocale = nation.compareLocale;
		$scope.countryCode = $scope.compareLocale;
		
		if( $scope.countryCode != ''){
			setTimeout(function(){
				var index = $("select#countryCode > option:selected").index();
				var $cellPhoneCountryCode = $('#cellPhoneCountryCode');
				var $phoneCountryCode = $('#phoneCountryCode');
				$phoneCountryCode.find('option').eq(index).prop("selected", true);
				$cellPhoneCountryCode.find('option').eq(index).prop("selected", true);
			},300)
		}
	}
	$scope.init();
	
	$scope.goIndex = function(){
		$location.path('/');
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
	
    //다음스텝으로 넘어가기위해 데이터를 담는다.
	$scope.addUser = function(){
		
    	if(!$('#clauseAgree1').is(':checked') || !$('#clauseAgree2').is(':checked')){
			$('#agreeChk').modal('show');
			return false;
		}
		
		if($scope.joinForm.$valid && $scope.password == $scope.password2){
			$scope.joinFormSrv.type = $scope.type;
			$scope.joinFormSrv.loginId = $rootScope.loginId;
			$scope.joinFormSrv.nickname = $scope.nickname;
			$scope.joinFormSrv.password = $scope.password;
			$scope.joinFormSrv.firstName = $scope.firstName;
			$scope.joinFormSrv.lastName = $scope.lastName;
			$scope.joinFormSrv.male = $scope.male;
			$scope.joinFormSrv.countryCode = $scope.countryCode;
			$scope.joinFormSrv.address = $scope.address;
			$scope.joinFormSrv.phoneCountryCode = $('#cellPhoneCountryCode').val();
			$scope.joinFormSrv.phoneNumber = $scope.phoneNumber;
			$scope.joinFormSrv.cellPhoneCountryCode = $('#cellPhoneCountryCode').val(); 
			$scope.joinFormSrv.cellPhoneNumber = $scope.cellPhoneNumber;
 			$scope.joinFormSrv.email = $rootScope.loginId; 
 			$scope.joinFormSrv.companyName = $('input[name=companyName]').val();
 			$scope.joinFormSrv.companyNumber = $('input[name=companyNumber]').val();
// 			$scope.joinFormSrv.companyNumber = $scope.companyNumber; //이유를 모르겠음 값이 undifined
// 			$scope.joinFormSrv.companyName = $scope.companyName; //이유를 모르겠음 값이 undifined
			$location.path('/joinForm3/');
		}
	}
})
.controller('joinForm3Ctl', function($scope, $rootScope, $routeParams, $http, $location, $rootScope, joinFormSrv) {
	
	$scope.depth1 = '0';
 	$scope.depth2 = '0';
 	$scope.depth3 = '0';
 	$scope.depth4 = '0';
 	$scope.depthShow1 = false;
 	$scope.tagShow1 = false;
 	$scope.depthShow2 = false;
 	$scope.tagShow2 = false;
	
	$scope.joinFormSrv = joinFormSrv;
	$scope.init = function(){
		//2단계에서 필수값 입력이 없으면 튕김
		if ($scope.joinFormSrv.type == undefined || $rootScope.loginId == undefined || $scope.joinFormSrv.nickname == undefined){
			new PageAlert({'type':'danger','title':'','message':i18n.getLang('member','wrongway')});
			$location.path("/emailConfirm/");
		}
		
		var bankType = i18n.getLang('bankAccount','bankType');
		var bank = bankType.split(':');
		$scope.bank = {'code':bank[0], 'name':bank[1]};
	}
	$scope.init();
	
	$scope.goIndex = function(){
		$location.path('/');
	}
	
	var categoryData = jcontext.loadJSON('/sys/category/getListByParent.json?pid=whatinfo');
	$scope.categoryList = categoryData.list;
	
	//가입최종 프로세스 submit
	$scope.joinFinish = function(){
		if($scope.joinProfile.$valid){
			var data = $scope.joinFormSrv;
			var form = $("form[name*='joinProfile']"); 
			if(data){
				for(var key in data){
					var value = data[key];
					if(value === undefined){
						value = '';
					}
					form.append($('<input type="hidden" name="'+key+'" value="'+value+'" />'));
				}
			}
			
			$scope.$broadcast("SUBMIT");
			   jcontext.formSubmit(form ,jcontext.getLocationPath("/sys/member/joinMember.json"),{
	// 			   message:'사용자가 등록되었습니다.' ,
				   callback: function(data){
						$('#confirmJoin').modal('show');
					   	$scope.$apply(function(){
							//location.href = jcontext.getContextPath('/sys/login/loginForm.aon');
					   	});
				   	}
			   	}
			   ,{ msssage:i18n.getLang('common','error'),
				  callback: function(e){
					  alert(e.status);
				   }
				}
			);
		}
	}
	//완료후 모달창에 확인버튼 클릭시 로그인 페이지로 리다이렉트
	$scope.memberJoinFinish = function(){
		location.href = jcontext.getContextPath('/sys/login/loginForm.aon');
	}
})
.controller('emailConfirmCtl', function($scope, $routeParams, joinFormSrv, $http, $location, $route) {
	//기존 가입자 여부 확인
	$scope.loginIdConfirm = function(){
		var loginId = $scope.loginId;
		if(loginId != null){
			var param = {loginId : loginId};
			$scope.rtnData = jcontext.postJSON('/sys/member/emailConfirmUserStatus.json', param);
			
			//1000(신규),1100(재가입),2000(회원),8000,9000(탈퇴회원)
			if($scope.rtnData.status == 2000){
				$('#exitsEmailId').modal('show');			
// 				location.href = jcontext.getContextPath('/sys/login/loginForm.aon');
			}else{
				$('#emailConfirm').modal('show');
				return false;
			}
		}	
	}
	
	$scope.gotoLogin = function(){
			location.href = jcontext.getContextPath('/sys/login/loginForm.aon');
	}
	
	//가입 이메일 전달
	$scope.confirmEmailSend = function(){
		var loginId = $scope.loginId;
		var status = $scope.status;
		var param = {loginId : loginId, status : status};
		if(loginId != null){
			jcontext.postJSON('/sys/member/emailInvitation.json', param);
		}	
	}
})
.controller('findLoginPwCtl', function($scope, $routeParams, joinFormSrv, $http, $location) {
	//비밀번호 찾기 버튼 클릭 이벤트
	$scope.joinFormSrv = joinFormSrv;
	
	//비밀번호 찾기
	$scope.findPassword = function(){
		if($scope.findPasswordForm.$valid){
			var param = {loginId : $scope.loginId,firstName : $scope.firstName,lastName : $scope.lastName};
			$scope.rtnData = jcontext.postJSON('/sys/member/findMemberPassword.json', param);
			if($scope.rtnData.member.id != undefined){
				$scope.joinFormSrv.loginId = $scope.loginId;
				$location.path('/findLoginPwResult/');
			}else{
				$('#noMember').modal('show');
			}
		}	
	}
})
.controller('findLoginPwResultCtl', function($scope, $routeParams, joinFormSrv, $http, $location) {
	$scope.joinFormSrv = joinFormSrv;
	$scope.loginId = $scope.joinFormSrv.loginId;
	
	//확인버튼 클릭시 로그인 페이지로 이동
	$scope.loginPage = function(){
		location.href = jcontext.getContextPath('/sys/login/loginForm.aon');
	}
})
.directive('fileInput', function() {
	return function(scope, element, attrs) {
// 		if(scope.$last){ ng-repeat 처리후 주석제거
			element.ready(function () {
				//긴글 ... 처리 jquery.dotdotdot.min.js
				$(".el_txt").dotdotdot({
					watch: "window"
				});
			});
// 		}
	};
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
					  		$scope.joinProfile.$invalid = true;
					  		$scope.joinProfile.$valid = false;
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
					  		$scope.joinProfile.$invalid = false;
					  		$scope.joinProfile.$valid = true;
						});
	    			  	
	    		  	}
    	  	}).on('focusout', function(){
    		  	if($element[0].value == '0'){
    			  	$(this).attr('data-original-title', $attrs.title);
    			  	$(this).tooltip('show');
    			  	$scope.$apply(function(){
    			  		$scope.joinProfile.$invalid = true;
    			  		$scope.joinProfile.$valid = false;
					});
    			  	$($element).parent().addClass('has-error').removeClass('has-success');
    		  	}else{
    			  	$(this).tooltip('hide');
    			  	$($element).parent().addClass('has-success').removeClass('has-error');
    			  	$scope.$apply(function(){
    			  		$scope.joinProfile.$invalid = false;
    			  		$scope.joinProfile.$valid = true;
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
    <%@ include file="/WEB-INF/views/sys/member/subVisual.jsp" %>
    <!-- //sub visual -->
    
<div role="main" ng-app="JoinApp">
	<!-- contents -->
	<div class="contents">
	    <div class="container">
	        <div class="wrap">
	            <!-- navigation -->
				<nav>
					<ul class="navi">
						<li><a href='<c:url value="/index.aon"/>'><spring:message code='cmm.nav.001'/></a></li>
						<li ng-if="$route.current.$$route.controller != 'findLoginPwCtl'"><spring:message code='cmm.btn.020'/></li>
						<li ng-if="$route.current.$$route.controller == 'findLoginPwCtl'"><spring:message code='cmm.btn.046'/></li>
					</ul>
				</nav>
				<!-- //navigation -->
				<!-- sub_con -->
				<div ng-view></div>
				<!-- //sub_con -->
	        </div>
	    </div>
	</div>
	<!-- //contents -->
	<div class="modal fade" id="agreeChk" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title"><spring:message code='mem.lbl.001'/></h4>
                </div>
                <div class="modal-body">
                    <p class="modalTxt2"><spring:message code='mem.msg.002'/></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn green" data-dismiss="modal" aria-hidden="true"><spring:message code='cmm.btn.016'/></button>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>