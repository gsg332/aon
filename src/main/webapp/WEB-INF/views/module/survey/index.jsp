<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/module/survey/inc_header.jsp"%>
<script type="text/javascript">
var app = angular.module('PollApp', ['ngRoute', 'ui.bootstrap','aon.input.directives'])  
.config(function ($httpProvider, $routeProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };

	$routeProvider
	.when('/', {
		controller : 'surveyController',
		templateUrl : jcontext.getContextPath('/module/survey/surveyOffice.aon')
	})
	.when('/office', {
		controller : 'surveyController',
		templateUrl : jcontext.getContextPath('/module/survey/surveyOffice.aon')
	})
	.when('/residence', {
		controller : 'surveyController',
		templateUrl : jcontext.getContextPath('/module/survey/surveyResidence.aon')
	})
	.when('/retail', {
		controller : 'surveyController',
		templateUrl : jcontext.getContextPath('/module/survey/surveyRetail.aon')
	})
	.when('/apart', {
		controller : 'surveyController',
		templateUrl : jcontext.getContextPath('/module/survey/surveyApart.aon')
	})
	.when('/food', {
		controller : 'surveyController',
		templateUrl : jcontext.getContextPath('/module/survey/surveyFood.aon')
	})
	.when('/beauty', {
		controller : 'surveyController',
		templateUrl : jcontext.getContextPath('/module/survey/surveyBeauty.aon')
	})
	.when('/sport', {
		controller : 'surveyController',
		templateUrl : jcontext.getContextPath('/module/survey/surveySport.aon')
	})
	.when('/fashion', {
		controller : 'surveyController',
		templateUrl : jcontext.getContextPath('/module/survey/surveyFashion.aon')
	})
	.when('/hotel', {
		controller : 'surveyController',
		templateUrl : jcontext.getContextPath('/module/survey/surveyHotel.aon')
	})
	.otherwise({
		redirectTo : '/'
	});
})
.controller('surveyController', function($scope, $rootScope, $routeParams, $http, $location, $cookies, $window) {
	$('.dep_01').hide();
	$('.step0').show();
	
	var tmpName = [];
	var inputName = [];
	var selectResult = false;
	var textResult = true;
	var result = false;
	
	$scope.userlocale = jcontext.getLocale($cookies);
	$scope.secondStep = function(preStep, nextStep){
		var chkEmail = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
		
		var email = $('input[name=email]');
		var surveyId = $('input[name=surveyId]').val();
		if(!chkEmail.test(email.val())){
			alert('not valid email ');
			email.focus();
			result = false;	
			return false;
		} else {
			$scope.email = email.val();
			$scope.surveyId = surveyId
			result = true;
		}
		
		var data =  jcontext.loadJSON('/module/survey/alreadyJoin.json?email='+$scope.email +'&surveyId='+$scope.surveyId);
		if(data.alreadyJoin)	{
			alert('your already join');
			email.val(null);
			email.focus();
			return false;
		}
		
		$('.'+preStep).find('input').each(function(){
			tmpName.push($(this).attr('name'));	
		});
		
		$.each(tmpName, function(i,el){
			if($.inArray(el, inputName) == -1){
				inputName.push(el);
			}
		});
		
		$.each(inputName, function(idx, names){
			var value;
			var size = $('input[name='+names+']').size();
			var id = $('input[name='+names+']').attr('id');
			var type = $('input[name='+names+']').attr('type');
			if(type == 'radio'){
				value = $('input[name='+names+']:checked').val();	
			}else if(type == 'hidden'){
				value = $('input[name='+names+']').val();
			}
			
			if(names.indexOf('text') == -1){
				if(value == null || value == undefined || value == ''){
					selectResult = false;	
				}else{
					selectResult = true;
				}
			}
			
			if($('#'+id.slice(0, -1) + size).is(':checked')){
				var dataId = $('#'+id.slice(0, -1) + size).data('etc');
				if(dataId == 'etc'){
					if($('input[name='+names+'text]').val() == ''){
						selectResult = false;
					}else{
						selectResult = true;
					}
				}	
			}
		});
		
		$('.'+preStep).find('textarea').each(function(){
			if($(this).val() == ''){
				textResult = false;
			}else{
				textResult = true;
			}	
		});

		if(selectResult && textResult){
			$('.'+preStep).hide();
			$('.'+nextStep).show();
		}else{
			alert(i18n.getLang('survey','doComplete'));
			return false;
		}
	}
	
	$scope.nextStep = function(preStep, nextStep, skipGroup){

		if($scope.checkImprove ==1){
			$('input[name=1-3]').remove();
			$('input[name=1-3text]').remove();
			$('input[name=1-4]').remove();
			$('input[name=1-4text]').remove();
			$('input[name=1-5]').remove();
			$('textarea[name=1-5text]').remove();
		}
		if($scope.checkImprove==2){
			$('input[name=1-2]').remove();
			$('input[name=1-2text]').remove();
		}
		$('.'+preStep).find('input').each(function(){
			tmpName.push($(this).attr('name'));	
		});
		
		$.each(tmpName, function(i,el){
			if($.inArray(el, inputName) == -1){
				inputName.push(el);
			}
		});
		
		$.each(inputName, function(idx, names){
			
			var value;
			var size = $('input[name='+names+']').size();
			var id = $('input[name='+names+']').attr('id');
			var type = $('input[name='+names+']').attr('type');
			if(type == 'radio'){
				value = $('input[name='+names+']:checked').val();	
			}else if(type == 'hidden'){
				value = $('input[name='+names+']').val();
			}
			
			if(names.indexOf('text') == -1){
				if(value == null || value == undefined || value == ''){
					selectResult = false;	
				}else{
					selectResult = true;
				}
			}
			
			if($('#'+id.slice(0, -1) + size).is(':checked')){
				var dataId = $('#'+id.slice(0, -1) + size).data('etc');
				if(dataId == 'etc'){
					if($('input[name='+names+'text]').val() == ''){
						selectResult = false;
					}else{
						selectResult = true;
					}
				}	
			}
		});
		
		$('.'+preStep).find('textarea').each(function(){
			if($(this).val() == ''){
				textResult = false;
			}else{
				textResult = true;
			}	
		});
		
		if(selectResult && textResult){
			if(nextStep == 'submit'){
				$scope.$broadcast("SUBMIT");
				  jcontext.formSubmit($("form[name*='surveyForm']"),"/module/survey/insertSurvey.json",
				  	{message:i18n.getLang('common','register') 
					  ,callback: function(data){
			  			 $scope.$apply(function() {
			  				 var rtnUrl = jcontext.getContextPath("/module/survey/coupon/index.aon#/createCoupon/"+$scope.email+"/"+$scope.surveyId)
			  				 $window.location.href = rtnUrl;
			  			 });
	  			    	}
				   	}
				   ,{ message:i18n.getLang('common','error')
					}
				);
			}else{
				if(skipGroup == 'food'){
					var skipVal = $('input[name=1-2]:checked').val();
					if(skipVal == '1'){ // 예
						nextStep = 'step2';
					}else{
						nextStep = 'step3';
					}
					$('.'+preStep).hide();
					$('.'+nextStep).show();
				}else if(skipGroup == 'beauty'){
					var skipVal = $('input[name=1-2]:checked').val();
					if(skipVal == '1'){
						nextStep = 'step2';
					}else{
						nextStep = 'step3';
					}
					$('.'+preStep).hide();
					$('.'+nextStep).show();
				}else if(skipGroup == 'sport'){
					var skipVal = $('input[name=1-2]:checked').val();
					if(skipVal == '1'){
						nextStep = 'step2';
						$('.step3').remove();
					}else{
						nextStep = 'step3';
						$('.step2').remove();
					}
					$('.'+preStep).hide();
					$('.'+nextStep).show();
				}else if(skipGroup == undefined){
					$('.'+preStep).hide();
					$('.'+nextStep).show();	
				}
			}
		}else{
			alert(i18n.getLang('survey','doComplete'));
			return false;
		}
	}
})	
</script>
<div role="main" ng-app="PollApp">
	<!-- contents -->
	<div class="contents">
	    <div class="container">
	        <div class="wrap">
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