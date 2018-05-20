<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
            <!-- mem_app -->
            <form name="joinForm" id="joinForm" novalidate="true">
	            <input type="hidden" name="type" id="type" ng-model="type" value="{{type}}"/>
	            <div class="member_app">
	                <ul class="ma_list">
	                    <li>
	                        <div class="ma_txt mT_01">
	                            <span><spring:message code='mem.lbl.002'/></span>
	                        </div>
	                    </li>
	                    <li class="active">
	                        <div class="ma_txt mT_02">
	                            <span><spring:message code='mem.lbl.003'/></span>
	                        </div>
	                    </li>
	                    <li>
	                        <div class="ma_txt mT_03">
	                            <span><spring:message code='mem.lbl.004'/></span>
	                        </div>
	                    </li>
	                </ul>
	                <h2 class="ma_h3"><spring:message code='mem.lbl.003'/></h2>
	                <div class="em_info">
	                    <p><spring:message code='mem.msg.029'/></p>
	                    <div class="termBox">
	                        <h3 class="subtit"><spring:message code='mem.lbl.038'/></h3>
	                        <div class="textBox"><spring:message code='mem.msg.110'/></div>
	                        <div class="checks">
	                            <input type="checkbox" id="clauseAgree1" name="clauseAgree1" ng-model="clauseAgree1">
	                            <label for="clauseAgree1"><spring:message code='mem.msg.027'/></label>
	                        </div>
	                        <h3 class="subtit"><spring:message code='mem.lbl.039'/></h3>
	                        <div class="textBox"><spring:message code='mem.msg.111'/></div>
	                        <div class="checks">
	                            <input type="checkbox" id="clauseAgree2" name="clauseAgree2">
	                            <label for="clauseAgree2"><spring:message code='mem.msg.028'/> </label>
	                        </div>
	                    </div>
	                    <p style="margin-bottom:30px;"><spring:message code='mem.msg.030'/></p>
	                    <div class="required_item">
	                        <ul class="ri_list">
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.002'/></label>
	                                <div class="col-sm-9">
	                                    <span ng-show="type == 3000"><spring:message code='mem.lbl.005'/></span>
	                                    <span ng-show="type == 3100"><spring:message code='mem.lbl.006'/></span>
	                                    <!--<a href="#" class="fbLogin2">페이스북 계정으로 회원가입</a>-->
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.007'/></label>
	                                <div class="col-sm-9">
	                                    <div class="check_rs fm_type300">
                                            {{loginId}}
                                            <input type="hidden" name="loginId" id="loginId" value="{{loginId}}" ng-model="loginId" />
	                                    </div>
	                                    <span class="txt_etc block"><spring:message code='mem.msg.003'/></span>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.008'/></label>
	                                <div class="col-sm-9">
	                                    <div class="check_rs fm_type300">
											<aon-input-text ng-model="nickname" field-name="nickname" placeholder="<spring:message code='mem.msg.004'/>" ng-required="true"
											length-check="true" length-message="<spring:message code='mem.err.101'/>" min="2" max="10" alert-message="<spring:message code='mem.err.003'/>"
											duplicated-message="<spring:message code='mem.err.004'/>" exchanged="true" exchanged-type="nick"
											mix-check="true" mix-message="<spring:message code='mem.err.105'/>"></aon-input-text>
	                                    </div>
	                                    <span class="txt_etc block"><spring:message code='mem.msg.005'/></span>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.009'/></label>
	                                <div class="col-sm-9">
	                                    <div class="er_box fm_type300">
	                                        <aon-password ng-model="password" field-name="password" placeholder="<spring:message code='mem.msg.006'/>"
	                                        length-check="true" mix-check="true" length-message="<spring:message code='mem.err.102'/>" min="4" max="20" ng-required="true"
	                                        alert-message="<spring:message code='mem.err.005'/>"
	                                        mix-message="<spring:message code='mem.err.103'/>"
	                                        ></aon-password>
	                                    </div>
	                                    <span class="txt_etc"><spring:message code='mem.msg.007'/></span>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.010'/></label>
	                                <div class="col-sm-9">
	                                    <div class="er_box fm_type300">
	                                        <aon-password ng-model="password2" field-name="password2" placeholder="<spring:message code='mem.msg.006'/>"
	                                        length-check="true" mix-check="true" length-message="<spring:message code='mem.err.102'/>" min="4" max="20" ng-required="true"
	                                        alert-message="<spring:message code='mem.err.005'/>" mix-message="<spring:message code='mem.err.103'/>"
	                                        password-check="true" password-check-form="password" password-check-message="<spring:message code='mem.err.013'/>"></aon-password>
	                                    </div>
	                                    <span class="txt_etc"><spring:message code='mem.msg.007'/></span>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.043'/></label>
	                                <div class="col-sm-9">
	                                    <div class="block_rs">
	                                        <span><spring:message code='mem.lbl.011'/></span>
	                                        <div class="er_box fm_type200">
	                                            <aon-input-text ng-model="firstName" 
												field-name="firstName"  
												placeholder="<spring:message code='mem.msg.008'/>" ng-required="true"
												alert-message="<spring:message code='mem.err.007'/>"></aon-input-text>
	                                        </div>
	                                    </div>
	                                    <div class="block_rs">
	                                        <span><spring:message code='mem.lbl.012'/></span>
	                                        <div class="er_box fm_type200">
	                                        	<aon-input-text ng-model="lastName" 
												field-name="lastName"  
												placeholder="<spring:message code='mem.msg.009'/>" ng-required="true"
												alert-message="<spring:message code='mem.err.006'/>"></aon-input-text>
	                                        </div>
	                                    </div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.013'/></label>
	                                <div class="col-sm-9">
	                                    <div class="radio-list" ng-init="male=1">
	                                        <div class="checks">
	                                            <input type="radio" id="male" name="male" ng-model="male" value="1">
	                                            <label for="male"><spring:message code='mem.lbl.014'/></label>
	                                        </div>
	                                        <div class="checks">
	                                            <input type="radio" id="female" name="male" ng-model="male" value="0">
	                                            <label for="female"><spring:message code='mem.lbl.015'/></label>
	                                        </div>
	                                    </div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.016'/></label>
	                                <div class="col-sm-9">
	                                	<select name="countryCode" id="countryCode" ng-model="countryCode" ng-change="nationChange()" class="form-control fm_type220" aon-select-req aon-required="true">
	                                        <option value=""><spring:message code='mem.lbl.017'/></option>
	                                        <option ng-repeat="nation in nationList | orderBy:'name'" ng-selected="{{compareLocale == nation.code}}" value="{{nation.code}}">{{nation.name}}</option>
	                                    </select>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.018'/></label>
	                                <div class="col-sm-9">
	                                    <div class="er_box fm_type300">
	                                        <aon-input-text ng-model="address" field-name="address" placeholder="<spring:message code='mem.msg.010'/>"></aon-input-text>
	                                    </div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.019'/></label>
	                                <div class="col-sm-9">
	                                    <select name="phoneCountryCode" id="phoneCountryCode" ng-model="phoneCountryCode" class="form-control fm_type220">
	                                        <option value=""><spring:message code='mem.lbl.017'/></option>
	                                        <option ng-repeat="nation in nationList | orderBy:'name'" value="{{nation.phone}}">{{nation.name}} +{{nation.phone}}</option>
	                                    </select>
	                                    <div class="er_box fm_type300">
	                                    	<aon-input-phone ng-model="phoneNumber" field-name="phoneNumber" placeholder="<spring:message code='mem.msg.011'/>"></aon-input-phone>
	                                    </div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.020'/></label>
	                                <div class="col-sm-9">
	                                    <select name="cellPhoneCountryCode" id="cellPhoneCountryCode" ng-model="cellPhoneCountryCode" class="form-control fm_type220" aon-select-req aon-required="true">
	                                        <option value=""><spring:message code='mem.lbl.017'/></option>
	                                        <option ng-repeat="nation in nationList | orderBy:'name'" value="{{nation.phone}}">{{nation.name}} +{{nation.phone}}</option>
	                                    </select>
	                                    <div class="er_box fm_type300">
	                                    	<aon-input-phone ng-model="cellPhoneNumber" field-name="cellPhoneNumber"
	                                    	placeholder="<spring:message code='mem.msg.013'/>" ng-required="true"
	                                    	alert-message="<spring:message code='mem.err.012'/>"></aon-input-phone>
	                                    </div>
	<!--                                     <button type="button" class="btn btn-default num_open">인증번호 <span class="check_fd"> 발송</span></button> -->
	<!--                                     <span class="txt_etc block">회원가입 시 등록한 핸드폰으로 발송됩니다.</span> -->
	                                    <!-- 인증번호 체크 현재 display:none 상태 -->
	                                    <div class="phone_check" style="display:none;">
	                                        <p class="blue normal"><spring:message code='mem.msg.014'/></p>
	                                        <span class="check_rs fm_type220">
	                                            <input type="text" class="form-control" value="">
	                                        </span>
	                                        <button type="button" class="btn btn-default"><spring:message code='cmm.btn.016'/></button>
	                                        <div class="checks">
	                                            <input type="checkbox" id="answerCheck">
	                                            <label for="answerCheck" class="p_check_sf"><spring:message code='mem.msg.015'/></label>
	                                        </div>
	                                    </div>
	                                    <!-- //인증번호 체크 -->
	                                </div>
	                            </li>
	                            <li ng-if="type == 3100">
								    <label class="col-sm-3"><spring:message code='mem.lbl.021'/></label>
								    <div class="col-sm-9">
								        <div class="er_box fm_type300">
								            <aon-input-text ng-model="companyNumber" 
											field-name="companyNumber"  
											placeholder="<spring:message code='mem.msg.016'/>" ng-required="true"
											alert-message="<spring:message code='mem.err.008'/>"></aon-input-text>
								        </div>
								    </div>
								</li>
								<li ng-if="type == 3100">
								    <label class="col-sm-3"><spring:message code='mem.lbl.022'/></label>
								    <div class="col-sm-9">
								        <div class="er_box fm_type300">
								            <aon-input-text ng-model="companyName" 
												field-name="companyName"  
												placeholder="<spring:message code='mem.msg.017'/>" ng-required="true"
												alert-message="<spring:message code='mem.err.009'/>"></aon-input-text>
								        </div>
								        <span class="txt_etc"><spring:message code='mem.msg.018'/></span>
								    </div>
								</li>
	                        </ul>
	                    </div>
	                    <div class="btnArea">
	                        <button type="button" ng-disabled="joinForm.$invalid" ng-click="addUser()" class="btn btn-primary"><spring:message code='cmm.btn.028'/></button>	                        
	                        <button type="button" class="btn btn-default" ng-click="goIndex();"><spring:message code='cmm.btn.005'/></button>
	                    </div>
	                </div>
	            </div>
        	</form>
        	<!-- //mem_app -->
