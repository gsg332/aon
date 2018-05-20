<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp"%>
<div class="sub_section">
	<h3 class="sub_tit"><spring:message code='mem.lbl.100' /></h3>
	<form name="memberUpdateForm" id="memberUpdateForm" novalidate="true">
	<input type="hidden" name="type" id="type" ng-model="member.type" value="{{member.type}}" />
		<div class="myPage">
			<!-- question input -->
			<div class="required_item">
				<ul class="ri_list">
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.007' /></label>
						<div class="col-sm-9">{{member.loginId}}</div>
					</li>
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.008' /></label>
						<div class="col-sm-9">
							<span class="check_rs">
								<aon-input-text ng-model="member.nickname" field-name="nickname" placeholder="<spring:message code='mem.msg.004'/>" ng-required="true"
								length-check="true" length-message="<spring:message code='mem.err.101'/>" min="2" max="10" alert-message="<spring:message code='mem.err.003'/>"
								duplicated-message="<spring:message code='mem.err.004'/>" exchanged="true" exchanged-type="nick"></aon-input-text>
							</span>
							<span class="txt_etc block"><spring:message code='mem.msg.005' /></span>
						</div>
					</li>
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.045' /></label>
						<div class="col-sm-9">
							<span class="check_rs">
								<aon-before-password ng-model="beforePassword" field-name="beforePassword" placeholder="<spring:message code='mem.msg.006'/>" length-check="true"
								length-message="<spring:message code='mem.msg.003'/>" min="4" max="20" mix-check="true" mix-message="<spring:message code='mem.err.103'/>"
								ng-required="true"/>
							</span>
						</div>
					</li>
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.046' /></label>
						<div class="col-sm-9">
							<span class="check_rs">
								<aon-password ng-model="password" field-name="password" placeholder="<spring:message code='mem.msg.006'/>" length-check="true"
								length-message="<spring:message code='mem.msg.003'/>" min="4" max="20" mix-check="true" mix-message="<spring:message code='mem.err.103'/>"
								required-change="true" required-chainform="password2"></aon-password>
							</span>
							<span class="txt_etc"><spring:message code='mem.msg.007' /></span>
							<br/>
							<span class="txt_etc"><spring:message code='mem.msg.037' /></span>
						</div>
					</li>
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.010' /></label>
						<div class="col-sm-9">
							<span class="check_rs">
								<aon-password ng-model="password2" field-name="password2" placeholder="<spring:message code='mem.msg.006'/>" length-check="true" 
								length-message="<spring:message code='mem.msg.003'/>" min="4" max="20" mix-check="true" mix-message="<spring:message code='mem.err.103'/>"
								password-check="true" password-check-form="password" password-check-message="<spring:message code='mem.err.013'/>"
								required-change="true" required-chainform="password"></aon-password>
							</span>
							<span class="txt_etc"><spring:message code='mem.msg.007' /></span>							
						</div>
					</li>
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.043' /></label>
						<div class="col-sm-9">
							<span class="block_rs">
								<spring:message code='mem.lbl.011' />
								<aon-input-text ng-model="member.firstName" field-name="firstName"
								placeholder="<spring:message code='mem.msg.009'/>" ng-required="true"
								alert-message="<spring:message code='mem.err.007'/>"></aon-input-text>
							</span>
							<span class="block_rs">
								
								<spring:message code='mem.lbl.012' />
								<aon-input-text ng-model="member.lastName" field-name="lastName"
								placeholder="<spring:message code='mem.msg.008'/>" ng-required="true"
								alert-message="<spring:message code='mem.err.006'/>" ></aon-input-text>
							</span>
						</div>
					</li>
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.013' /></label>
						<div class="col-sm-9">
							<div class="radio-list">
								<div class="checks">
									<input type="radio" id="male" name="male" ng-model="member.male" ng-checked="(member.male == true)" value="1">
									<label for="male"><spring:message code='mem.lbl.014' /></label>
								</div>
								<div class="checks">
									<input type="radio" id="female" name="male" ng-model="member.male" ng-checked="(member.male == false)" value="0">
									<label for="female"><spring:message code='mem.lbl.015' /></label>
								</div>
							</div>
						</div>
					</li>
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.016'/></label>
						<div class="col-sm-9">
							<select name="countryCode" id="countryCode" ng-change="nationChange()" class="form-control fm_type220" ng-model="member.countryCode" aon-select-req aon-required="true">
								<option value=""><spring:message code='mem.lbl.017'/></option>
								<option ng-repeat="nation in nationCodeList | orderBy:'name'" value="{{nation.code}}">{{nation.name}}</option>
							</select>
						</div>
					</li>
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.018' /></label>
						<div class="col-sm-9 fm_type300">
							<aon-input-text ng-model="member.address" field-name="address" placeholder="<spring:message code='mem.msg.010'/>"></aon-input-text> 
						</div>
					</li>
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.019'/></label>
						<div class="col-sm-9">
							<select name="phoneCountryCode" id="phoneCountryCode" class="form-control fm_type220" ng-model="member.phoneCountryCode">
								<option value=""><spring:message code='mem.lbl.017'/></option>
								<option value="{{x.phone}}" ng-repeat="x in nationCodeList | orderBy:'name'">{{x.name}} +{{x.phone}}</option>
							</select>
							<div class="er_box fm_type220">
								<aon-input-phone ng-model="member.phoneNumber" field-name="phoneNumber" placeholder="<spring:message code='mem.msg.011'/>"
								format-message="<spring:message code='mem.err.104'/>" format-type="N" formated="true"></aon-input-phone>
							</div>
						</div>
					</li>
					<li>
						<label class="col-sm-3"><spring:message code='mem.lbl.020'/></label>
						<div class="col-sm-9">
							<select class="form-control fm_type220" name="cellPhoneCountryCode" id="cellPhoneCountryCode" ng-model="member.cellPhoneCountryCode" aon-select-req aon-required="true">
								<option value=""><spring:message code='mem.lbl.017'/></option>
								<option value="{{x.phone}}" ng-repeat="x in nationCodeList | orderBy:'name'">{{x.name}} +{{x.phone}}</option>
							</select>
							<div class="er_box fm_type220">
								<aon-input-phone name="cellPhoneNumber" ng-model="member.cellPhoneNumber" field-name="cellPhoneNumber" placeholder="<spring:message code='mem.msg.011'/>"
								ng-required="true" alert-message="<spring:message code='mem.err.012'/>"
								format-message="<spring:message code='mem.err.104'/>" format-type="N" formated="true"></aon-input-phone>
							</div>
						</div>
					</li>
					<li ng-if="member.type == 3100"> 
						<label class="col-sm-3"><spring:message code='mem.lbl.021'/></label>
						<div class="col-sm-9 fm_type300">
							<aon-input-text ng-model="member.companyNumber" field-name="companyNumber" placeholder="<spring:message code='mem.msg.016'/>"
							ng-required="true" alert-message="<spring:message code='mem.err.008'/>"></aon-input-text>
						</div>
					</li>
					<li ng-if="member.type == 3100">
						<label class="col-sm-3"><spring:message code='mem.lbl.022'/></label>
						<div class="col-sm-9 fm_type300">
							<aon-input-text ng-model="member.companyName" field-name="companyName" placeholder="<spring:message code='mem.msg.017'/>"
							ng-required="true" alert-message="<spring:message code='mem.err.009'/>"></aon-input-text>
						</div>
					</li>
				</ul>
			</div>
			<div class="btnArea">
				<button type="button" class="btn btn-primary" ng-disabled="memberUpdateForm.$invalid" ng-click="memberModify()"><spring:message code='mem.btn.100'/></button>
				<!--<button type="button" class="btn btn-primary" ng-click="profileUpdate()"><spring:message code='mem.btn.101'/></button>-->
				<button type="button" class="btn btn-default" ng-click="goIndex();"><spring:message code='cmm.btn.005'/></button>
			</div>
		</div>
	</form>
</div>