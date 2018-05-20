<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>

                <h2 class="page_tit"><spring:message code='mem.adm.lbl.009'/></h2>
                <div class="myPage">
                	<form:form name="updateForm" id="updateForm" novalidate="true" enctype="multipart/form-data">
                    	<!-- question input -->
                    	<input type="hidden" name="memberProfile.isImageChange" id="isImageChange" ng-model="member.isImageChange" />
                    	<input type="hidden" name="id" ng-model="member.id" value="{{member.id}}"/>
                    	<input type="hidden" name="type" ng-model="member.type" value="{{member.type}}"/>
                    	<input type="hidden" name="bankCode" ng-value="bank.code"/>
                    	<div class="required_item">
	                        <ul class="ri_list">
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.007'/></label>
	                                <div class="col-sm-9">
	                                    {{member.loginId}}
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.008'/></label>
	                                <div class="col-sm-9">
	                                	<span class="check_rs">
	                                		<aon-input-text ng-model="member.nickname" field-name="nickname" placeholder="<spring:message code='mem.msg.004'/>" ng-required="true" length-check="true" length-message="<spring:message code='mem.msg.005'/>" min="2" max="10" 
	                                			alert-message="<spring:message code='mem.err.003'/>" duplicated-message="<spring:message code='mem.err.004'/>" exchanged="true" exchanged-type="nick"/>
	                                   	</span>
	                                    <span class="txt_etc block"><spring:message code='mem.msg.005'/></span>
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
	                                <label class="col-sm-3"><spring:message code='mem.lbl.046'/></label>
	                                <div class="col-sm-9">
	                                    <span class="check_rs">
	                                        <aon-password ng-model="member.password" field-name="password" placeholder="<spring:message code='mem.msg.006'/>" length-check="true"
	                                        length-message="<spring:message code='mem.msg.003'/>" min="4" max="20"
	                                        required-change="true" required-chainform="password2"
	                                        mix-check="true" mix-message="<spring:message code='mem.err.103'/>"
	                                        />
	                                    </span>
	                                    <span class="txt_etc"><spring:message code='mem.msg.007'/></span>
	                                    <br/>
	                                    <span class="txt_etc"><spring:message code='mem.msg.037' /></span>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.010'/></label>
	                                <div class="col-sm-9">
	                                	<span class="check_rs">
	                                    	<aon-password ng-model="member.password2" field-name="password2" placeholder="<spring:message code='mem.msg.006'/>" length-check="true"
	                                    	length-message="<spring:message code='mem.msg.003'/>" min="4" max="20"
	                                    	mix-check="true" mix-message="<spring:message code='mem.err.103'/>"
	                                    	password-check="true" password-check-form="password" password-check-message="<spring:message code='mem.err.013'/>"
	                                    	required-change="true" required-chainform="password"
	                                    	 />
	                                    </span>
	                                    <span class="txt_etc"><spring:message code='mem.msg.007'/></span>
	                                    <span class="txt_etc" ng-show="member.password != member.password2" ng-hide="member.password == member.password2"><spring:message code='mem.err.013'/></span>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.011'/></label>
	                                <div class="col-sm-9">
	                                	<div class="block_rs">
	                                		<spring:message code='mem.lbl.011'/>
	                                    	<aon-input-text ng-model="member.firstName" field-name="firstName" placeholder="<spring:message code='mem.msg.009'/>" ng-required="true" alert-message="<spring:message code='mem.err.007'/>"/>
	                                    </div>
	                                    <div class="block_rs">
	                                    	<spring:message code='mem.lbl.012'/>
	                                		<aon-input-text ng-model="member.lastName" field-name="lastName" placeholder="<spring:message code='mem.msg.008'/>" ng-required="true" alert-message="<spring:message code='mem.err.006'/>"/>
	                                    </div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.013'/></label>
	                                <div class="col-sm-9">
	                                    <div class="radio-list">
	                                        <div class="checks">
	                                            <input type="radio" id="male" name="male" ng-model="member.male" ng-checked="(member.male == true)" value="1">
	                                            <label for="male"><spring:message code='mem.lbl.014'/></label>
	                                        </div>
	                                        <div class="checks">
	                                            <input type="radio" id="female" name="male" ng-model="member.male" ng-checked="(member.male == false)" value="0">
	                                            <label for="female"><spring:message code='mem.lbl.015'/></label>
	                                        </div>
	                                    </div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.016'/></label>
	                                <div class="col-sm-9">
	                                    <select ng-required="true" class="form-control fm_type220" name="countryCode" id="countryCode" ng-model="member.countryCode" ng-change="nationChange()" aon-select-req aon-required="true">
	                                        <option value=""><spring:message code='mem.lbl.017'/></option>
	                                        <option ng-repeat="nation in nationList | orderBy:'name'" value="{{nation.code}}">{{nation.name}}</option>
	                                    </select>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.018'/></label>
	                                <div class="col-sm-9 fm_type300">
                                        <aon-input-text ng-model="member.address" field-name="address" placeholder="<spring:message code='mem.msg.010'/>"/>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.019'/></label>
	                                <div class="col-sm-9">
	                                	<select class="form-control fm_type220" name="phoneCountryCode" id="phoneCountryCode" ng-model="member.phoneCountryCode">
	                                        <option value=""><spring:message code='mem.lbl.017'/></option>
	                                        <option ng-repeat="nation in nationList | orderBy:'name'" value="{{nation.phone}}">{{nation.name}} +{{nation.phone}}</option>
	                                    </select>
	                                    <div class="er_box fm_type300">
	                                    	<aon-input-phone ng-model="member.phoneNumber" field-name="phoneNumber" placeholder="<spring:message code='mem.msg.011'/>" format-message="<spring:message code='mem.err.104'/>" format-type="N" formated="true" alert-message="<spring:message code='mem.err.104'/>"></aon-input-phone>
	                                    </div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.020'/></label>
	                                <div class="col-sm-9">
	                                	<span>
		                                	<select ng-required="true" class="form-control fm_type220" name="cellPhoneCountryCode" id="cellPhoneCountryCode" ng-model="member.cellPhoneCountryCode" aon-select-req aon-required="true">
							                    <option value=""><spring:message code='mem.lbl.017'/></option>
							                    <option ng-repeat="nation in nationList | orderBy:'name'" value="{{nation.phone}}">{{nation.name}} +{{nation.phone}}</option>
							                </select>
							            </span>
	                                    <div class="er_box fm_type220">
	                                    	<aon-input-phone ng-model="member.cellPhoneNumber" field-name="cellPhoneNumber" placeholder="<spring:message code='mem.msg.013'/>" alert-message="<spring:message code='mem.err.012'/>" ng-required="true"/>
	                                    </div>
	                                </div>
	                            </li>
	                            <li ng-if="member.type == 3100">
								    <label class="col-sm-3"><spring:message code='mem.lbl.021'/></label>
								    <div class="col-sm-9">
								        <div class="er_box fm_type300">
								            <aon-input-text ng-model="member.companyNumber" field-name="companyNumber" placeholder="<spring:message code='mem.msg.016'/>" ng-required="true" alert-message="<spring:message code='mem.err.008'/>"/>
								        </div>
								    </div>
								</li>
								<li ng-if="member.type == 3100">
								    <label class="col-sm-3"><spring:message code='mem.lbl.022'/></label>
								    <div class="col-sm-9">
								        <div class="er_box fm_type300">
								            <aon-input-text ng-model="member.companyName" field-name="companyName" placeholder="<spring:message code='mem.msg.017'/>" ng-required="true" alert-message="<spring:message code='mem.err.009'/>"/>
								        </div>
								        <span class="txt_etc"><spring:message code='mem.msg.018'/></span>
								    </div>
								</li>
								<li>
					                <label class="col-sm-3"><spring:message code='mem.lbl.023'/></label>
					                <div class="col-sm-9">
					                    <aon-input-text ng-model="member.memberProfile.profileTitle" field-name="memberProfile.profileTitle" placeholder="<spring:message code='mem.msg.020'/>"></aon-input-text>
					                </div>
					            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.024'/></label>
	                                <div class="col-sm-9">
	                                    <div class="radio-list">
	                                        <div class="checks">
	                                            <input type="radio" name="memberProfile.open" id="open" ng-model="member.memberProfile.open" ng-checked="(member.memberProfile.open == true)" value="1">
	                                            <label for="open"><spring:message code='mem.lbl.025'/></label>
	                                        </div>
	                                        <div class="checks">
	                                            <input type="radio" name="memberProfile.open" id="closed" ng-model="member.memberProfile.open" ng-checked="(member.memberProfile.open == false)" value="0">
	                                            <label for="closed"><spring:message code='mem.lbl.026'/></label>
	                                        </div>
	                                        <span class="txt_etc"><spring:message code='mem.msg.021'/></span>
	                                    </div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.027'/></label>
	                                <div class="col-sm-9">
	                                    <select class="form-control wAuto fm_type180" required-select id="depth1" index="1" ng-model="depth1">
											<option value="0" selected="selected" ><spring:message code='cat.msg.002'/></option>
					                        <option ng-repeat="category in categoryList" ng-selected="{{category.id == depth1}}" value="{{category.id}}">{{category.name}}</option>
					                    </select>
				                        <div class="has-feedback i_block">
					                        <select class="form-control wAuto" required-sub-select id="depth2" index="1" ng-model="depth2" ng-show="depthShow1" data-toggle="tooltip" title="<spring:message code='cat.msg.002'/>">
					                        	<option value="0" ><spring:message code='cat.msg.002'/></option>
					                        	<option ng-repeat="category in subCategoryList1" ng-selected="{{category.id == depth2}}" value="{{category.id}}" >{{category.name}}</option>
					                        </select>
				                        </div>
				                        <input type="text" name="categories[0].tag" id="tag1" ng-model="tag1" ng-show="tagShow1" placeholder="<spring:message code='cat.msg.001'/>" class="form-control wAuto"/>
	                                	<input type="hidden" name="categories[0].categoryId" id="depthValue1" ng-model="depthValue1" value="{{depthValue1}}" />
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.028'/></label>
	                                <div class="col-sm-9">
	                                   <select class="form-control wAuto" id="depth3" required-select index="2" ng-model="depth3">
				                            <option value="0" ><spring:message code='cat.msg.002'/></option>
				                            <option ng-repeat="category in categoryList" ng-selected="{{category.id == depth3}}" value="{{category.id}}">{{category.name}}</option>
				                        </select>
				                        <div class="has-feedback i_block">
					                        <select class="form-control wAuto" required-sub-select index="2" id="depth4" ng-model="depth4" ng-show="depthShow2" data-toggle="tooltip" title="<spring:message code='cat.msg.002'/>">
					                        	<option value="0" ><spring:message code='cat.msg.002'/></option>
					                        	<option ng-repeat="category in subCategoryList2" ng-selected="{{category.id == depth4}}" value="{{category.id}}" >{{category.name}}</option>
					                        </select>
				                        </div>
				                        <input type="text" name="categories[1].tag" id="tag2" ng-model="tag2" ng-show="tagShow2" placeholder="<spring:message code='cat.msg.001'/>" class="form-control wAuto"/>
										<input type="hidden" name="categories[1].categoryId" id="depthValue2" ng-model="depthValue2" value="{{depthValue2}}" />
									</div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.030'/></label>
	                                <div class="col-sm-9">
	                                	<div class="fm_type500">
	                                		<aon-image-file ng-model="member.memberProfile.image" field-name="memberProfile.image"></aon-image-file>
	                                		<span class="txt_etc"><spring:message code='mem.msg.035'/></span>
	                                	</div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.031'/></label>
	                                <div class="col-sm-9">
	                                   <div>
	                                        <span class="aon_span"><spring:message code='mem.lbl.032'/></span>
	                                        <span>
		                                        <input type="text" readonly="readonly" ng-value="bank.name" class="form-control fm_type140"/>
	                                        </span>
	                                        <div class="er_box fm_type300">
	                                   			<aon-bank ng-model="bankAccount.accountNumber" field-name="accountNumber" relative-tag-name="accountNumber,accountName" alert-message="<spring:message code='mem.msg.022'/>" placeholder="<spring:message code='mem.msg.022'/>" ng-required="bankAccount.accountName" /> 
	                                		</div>
	                                    </div>
	                                    <div>
	                                        <span class="aon_span"><spring:message code='mem.lbl.034'/></span>
	                                        <div class="i_block">
	                                        	<aon-bank ng-model="bankAccount.accountName" field-name="accountName" relative-tag-name="accountNumber,accountName" alert-message="<spring:message code='mem.msg.023'/>" placeholder="<spring:message code='mem.msg.023'/>" ng-required="bankAccount.accountNumber" />
											</div>
										</div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.035'/></label>
	                                <div class="col-sm-9">
	                                	<aon-textarea ng-model="member.memberProfile.career" field-name="memberProfile.career" placeholder="<spring:message code='mem.msg.024'/>"/>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.036'/></label>
	                                <div class="col-sm-9">
	                                	<aon-textarea ng-model="member.memberProfile.introduce" field-name="memberProfile.introduce" placeholder="<spring:message code='mem.msg.025'/>"/>
	                                </div>
	                            </li>
	                        </ul>
	                    </div>
	                    <h3 class="blue plus_info"><spring:message code='mem.adm.lbl.016'/></h3>
	                    <table class="adminTable">
	                        <tbody>
	                            <tr>
	                                <td style="width:12%" class="head"><spring:message code='mem.lbl.011'/></td>
	                                <td style="width:21%">{{member.lastName}} {{member.firstName}} </td>
	                                <td style="width:12%" class="head"><spring:message code='mem.lbl.007'/></td>
	                                <td style="width:21%">{{member.loginId}}</td>
	                                <td style="width:12%" class="head"></td>
	                                <td style="width:22%"></td>
	                            </tr>
	                            <tr>
	                                <th scope="row"><spring:message code='pnt.lbl.003'/></th>
	                                <td class="right"><span class="blue">{{cyberAccount.depositSum | Apoint}}</span></td>
	                                <th scope="row"><spring:message code='pnt.lbl.002'/></th>
	                                <td class="right"><span class="red">{{cyberAccount.withdrawSum | Apoint}}</span></td>
	                                <th scope="row"><spring:message code='pnt.lbl.001'/></th>
	                                <td class="right">{{cyberAccount.balance | Apoint}}</td>
	                            </tr>
	                            <tr>
	                                <th scope="row"><spring:message code='mem.adm.lbl.017'/></th>
	                                <td>{{member.totalAccessCnt}}</td>
	                                <th scope="row"><spring:message code='mem.adm.lbl.013'/></th>
	                                <td>{{member.lastAccessDate | date : Adate}}</td>
	                                <th scope="row"><spring:message code='mem.adm.lbl.018'/></th>
	                                <td>{{member.ipAddress}}</td>
	                            </tr>
	                            <tr>
	                                <th scope="row"><spring:message code='mem.adm.lbl.019'/></th>
	                                <td colspan="5" class="left">
	                                	<aon-textarea name="introduce" ng-model="member.adminComment" field-name="adminComment" placeholder="<spring:message code='cmm.msg.003'/>">{{member.adminComment}}</aon-textarea>
	                                </td>
	                            </tr>
	                        </tbody>
	                    </table>
	                    <!-- //question input -->
	                    <div class="btnArea">
	                        <button type="button" id="regBtn" class="btn btn-primary" ng-click="memberModify()" ng-disabled="updateForm.$invalid"><spring:message code='cmm.btn.004'/></button>
	                        <button type="button" class="btn btn-default" ng-click="back()"><spring:message code='cmm.btn.005'/></button>
	                    </div>
                    </form:form>
                </div>
