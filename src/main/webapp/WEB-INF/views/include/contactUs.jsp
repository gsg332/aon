<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
	var contactUs = angular.module('contactUs', []);
	contactUs.controller('contactCtrl', [ '$scope', function($scope) {
		var form = $("form[name*='onlineAskForm']");
		$scope.modalOpen = function() {
			$scope.user = {
					'userName' : null,
					'loginid' : null,
					'isLogin' : false
			};
			$scope.content=null;
			var data = jcontext.loadJSON('/module/onlineAsk/memberInfo.json');
			if(data.member){
				$scope.user = {
						'userName' : data.member.nickname,
						'loginid' : data.member.loginId,
						'isLogin' : true
				};
			}
			$("#onlineAskModal").modal();
		}
		$scope.sendInquiry = function() {
			if ($scope.onlineAskForm.$valid) {
				$scope.$broadcast("SUBMIT");
				jcontext.formSubmit(form,"/module/onlineAsk/register.json",	{
					message:i18n.getLang('common','register'),
					callback: function(data){
						$("#onlineAskModal").modal('hide');
				 	}
				}, {
					message:'<spring:message code="cmm.msg.015"/>',
					callback: function(e) {
					}
				})
			}
		}
	} ]);
</script>
<div>
	<a href='<c:url value="/module/contest/index.aon#/write"/>' class="btn btn_nQuest" ng-if="!htmlView"><spring:message code='ask.lbl.015' /></a>
	<div ng-app="contactUs" ng-controller="contactCtrl">
		<div class="rm_contact">
			<span class="rm_Ctit"><spring:message code='ask.lbl.010' /></span> 
			<span class="rm_Cnum"><spring:message code='ask.lbl.011' /></span> 
			<span class="rm_Ctime"><spring:message code='ask.lbl.012' /></span>
			<p class="rm_Ctxt">
				<spring:message code='ask.lbl.013' />
			</p>
			<button type="button" class="btn btn_inquireO"	style="width: 190px; margin-top: 12px" data-toggle="modal"	ng-click="modalOpen()">
				<span><spring:message code='ask.lbl.001' /></span>
			</button>
			<form:form id="onlineAskForm" name="onlineAskForm" method="post">
				<div class="modal fade confirmL" id="onlineAskModal" tabindex="-1" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true" ng-click="modalReset()" ></button>
	                            <h4 class="modal-title"><spring:message code='ask.lbl.001'/></h4>
							</div>
							<div class="modal-body">
							   	<aon-input-text ng-model="user.userName" field-name="userName"  label="userName" 
							   		placeholder="<spring:message code='ask.msg.001'/>" ng-required="true" alert-message="<spring:message code='ask.err.001'/>">
							   	</aon-input-text>
								<br>
								<aon-input-email ng-model="user.loginid" field-name="loginid"  label="loginid" 
									placeholder="<spring:message code='ask.msg.002'/>" ng-required="true" format-message="<spring:message code='ask.err.003'/>" 
									formated="true" alert-message="<spring:message code='ask.err.002'/>">
								</aon-input-email>
								<br>
								<aon-textarea  ng-model="content"  field-name="content" 
									placeholder="<spring:message code='ask.msg.003'/>" ng-required="true" alert-message="<spring:message code='ask.err.004'/>">
								</aon-textarea>
							    <p class="helpTxt"><spring:message code='ask.msg.004'/></p>
							</div>
							<div class="modal-footer">
								<button id="onlineAskWriteBtn" type="button" class="btn green" ng-disabled="onlineAskForm.$invalid" ng-click="sendInquiry()">
									<spring:message code='cmm.btn.004'/>
								</button>
								<button id="onlineAskCancelBtn" type="button" class="btn dark btn-outline" ng-click="modalReset()" data-dismiss="modal" >
									<spring:message code='cmm.btn.005'/>
								</button>
                          	</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</div>
</div>