<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp"%>
<div class="sub_section">
	<h3 class="sub_tit"><spring:message code='mem.lbl.103' /></h3>
	<div class="my_page">
		<ul class="drop_top">
			<li>
				<span><spring:message code='mem.lbl.038' /></span>
				<p><spring:message code='mem.msg.101' /></p>
			</li>
			<li>
				<span><spring:message code='mem.lbl.104' /></span>
				<p><spring:message code='mem.msg.102' /></p>
			</li>
			<li>
				<span><spring:message code='mem.lbl.105' /></span>
				<p><spring:message code='mem.msg.103' /></p>
			</li>
			<li>
				<span><spring:message code='mem.lbl.106' /></span>
				<p><spring:message code='mem.msg.104' /></p>
			</li>
			<li>
				<span><spring:message code='mem.lbl.107' /></span>
				<p><spring:message code='mem.msg.105' /></p>
			</li>
			<li>
				<span><spring:message code='mem.lbl.108' /></span>
				<p><spring:message code='mem.msg.106' /></p>
			</li>
		</ul>
		<!-- drop form -->
		<form name="memberWithdrawalForm" id="memberWithdrawalForm" novalidate="true">
			<input type="hidden" name="id" id="id" ng-model="id" value="{{member.id}}">
			<div class="required_item">
				<ul class="ri_list">
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.009' /></label>
						<div class="col-sm-9">
							<span class="check_rs">
								<aon-password ng-model="password" field-name="password"
								placeholder="<spring:message code='mem.msg.006'/>" ng-required="true"
								alert-message="<spring:message code='mem.err.005'/>"></aon-password>
							</span>
						</div>
					</li>
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.109' /></label>
						<div class="col-sm-9">
							<aon-textarea name="dropoutReason" ng-model="dropoutReason" field-name="dropoutReason"
								placeholder="<spring:message code='mem.msg.107'/>" ng-required="true"
								alert-message="<spring:message code='mem.err.100'/>"></aon-textarea>
							<div class="checks">
								<input type="checkbox" name="answerCheck" ng-model="answerCheck" id="answerCheck">
								<label for="answerCheck"><spring:message code='mem.msg.108' /></label>
							</div>
						</div>
					</li>
				</ul>
			</div>
			<!-- //drop form -->
			<div class="btnArea">
				<button type="submit" class="btn btn-primary" ng-click="memberWithdrawal()"><spring:message code='mem.btn.103' /></button>
				<button type="button" class="btn btn-default" ng-click="goIndex();"><spring:message code='cmm.btn.005' /></button>
			</div>
		</form>
	</div>
</div>
<div class="modal fade" id="agreeChk" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
				<h4 class="modal-title"><spring:message code='mem.lbl.110'/></h4>
			</div>
			<div class="modal-body">
				<p class="modalTxt2"><spring:message code='mem.msg.109' /></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn green" data-dismiss="modal" aria-hidden="true"><spring:message code='cmm.btn.016' /></button>
			</div>
		</div>
	</div>
</div>
