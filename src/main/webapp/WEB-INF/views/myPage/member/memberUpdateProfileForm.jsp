<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<div class="sub_section">
	<h3 class="sub_tit"><spring:message code='mem.lbl.101'/></h3>
	<form name="memberUpdateProfileForm" id="memberUpdateProfileForm" novalidate="true" enctype="multipart/form-data">
	<input type="hidden" name="isImageChange" id="isImageChange" ng-model="isImageChange" value="" /> 
	<input type="hidden" name="bankCode" id="bankCode" ng-model="member.bankCode" value="{{bankAccount.bankCode}}" />
	<div class="myPage">
	    <!-- question input -->
	    <div class="required_item">
	        <ul class="ri_list">
	            <li>
	                <label class="col-sm-3"><spring:message code='mem.lbl.023'/></label>
	                <div class="col-sm-9">
	                    <aon-input-text ng-model="profile.profileTitle" field-name="profileTitle" placeholder="<spring:message code='mem.msg.020'/>" value=""></aon-input-text>
	                </div>
	            </li>
	            <li>
	                <label class="col-sm-3"><spring:message code='mem.lbl.024'/></label>
	                <div class="col-sm-9">
	                    <div class="radio-list">
	                        <div class="checks">
	                            <input type="radio" id="open" name="open" ng-model="profile.open" value="0">
	                            <label for="open"><spring:message code='mem.lbl.025'/></label>
	                        </div>
	                        <div class="checks">
	                            <input type="radio" id="closed" name="open" ng-model="profile.open" value="1">
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
	                        <option ng-repeat="category in categoryList" ng-selected="{{category.id == depth1}}" value="{{category.id}}">{{ category.name | ctgrLang }}</option>
	                    </select>
                       	<div class="has-feedback i_block">
	                        <select class="form-control wAuto" required-sub-select id="depth2" index="1" ng-model="depth2" ng-show="depthShow1" data-toggle="tooltip" title="<spring:message code='cat.msg.002'/>">
	                        	<option value="0" ><spring:message code='cat.msg.002'/></option>
	                        	<option ng-repeat="category in subCategoryList1" ng-selected="{{category.id == depth2}}" value="{{category.id}}" >{{ category.name | ctgrLang }}</option>
	                        </select>
                        </div>
                        <input type="text" name="categories[0].tag" id="tag1" ng-model="tag1" ng-show="tagShow1" placeholder="<spring:message code='cat.msg.001'/>" class="form-control wAuto"/>
	                    <input type="hidden" name="categories[0].categoryId" id="depthValue1" ng-model="depthValue1" value="{{depthValue1}}" />
	                    <span class="txt_etc"><spring:message code='mem.msg.100'/></span>
	                </div>
	            </li>
	            <li>
	                <label class="col-sm-3"><spring:message code='mem.lbl.028'/></label>
	                <div class="col-sm-9">
	                    <select class="form-control wAuto" id="depth3" required-select index="2" ng-model="depth3">
                            <option value="0" ><spring:message code='cat.msg.002'/></option>
                            <option ng-repeat="category in categoryList" ng-selected="{{category.id == depth3}}" value="{{category.id}}">{{ category.name | ctgrLang }}</option>
                        </select>
                        <div class="has-feedback i_block">
	                        <select class="form-control wAuto" required-sub-select index="2" id="depth4" ng-model="depth4" ng-show="depthShow2" data-toggle="tooltip" title="<spring:message code='cat.msg.002'/>">
	                        	<option value="0" ><spring:message code='cat.msg.002'/></option>
	                        	<option ng-repeat="category in subCategoryList2" ng-selected="{{category.id == depth4}}" value="{{category.id}}" >{{category.name | ctgrLang}}</option>
	                        </select>
                        </div>
                        <input type="text" name="categories[1].tag" id="tag2" ng-model="tag2" ng-show="tagShow2" placeholder="<spring:message code='cat.msg.001'/>" class="form-control wAuto"/>
	                    <input type="hidden" name="categories[1].categoryId" id="depthValue2" ng-model="depthValue2" value="{{depthValue2}}" />
	                    <span class="txt_etc"><spring:message code='mem.msg.100'/></span>
	                </div>
	            </li>
	            <li>
	                <label class="col-sm-3"><spring:message code='mem.lbl.030'/></label>
	                <div class="col-sm-9">
	                    <aon-image-file ng-model="profileName" field-name="image"></aon-image-file>
	                </div>
	            </li>
	            <!--
	            <li>
	                <label class="col-sm-3"><spring:message code='mem.lbl.031'/></label>
	                <div class="col-sm-9">
	                    <div>
	                        <span class="aon_span"><spring:message code='mem.lbl.032'/></span>
								<input type="text" readonly="readonly" ng-value="bank.name" class="form-control fm_type140"/>
	                        <div class="i_block fm_type180">
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
	            -->
	            <li>
	                <label class="col-sm-3"><spring:message code='mem.lbl.035'/></label>
	                <div class="col-sm-9">
	                    <aon-textarea name="career" ng-model="profile.career" field-name="career" placeholder="<spring:message code='mem.msg.024'/>" alert-message="<spring:message code='mem.err.010'/>" value=""></aon-textarea>
	                </div>
	            </li>
	            <li>
	                <label class="col-sm-3"><spring:message code='mem.lbl.036'/></label>
	                <div class="col-sm-9">
	                    <aon-textarea name="introduce" ng-model="profile.introduce" field-name="introduce" placeholder="<spring:message code='mem.msg.025'/>" alert-message="<spring:message code='mem.err.011'/>" value=""></aon-textarea>
	                </div>
	            </li>
	        </ul>
	    </div>
	    <!-- //question input -->
	    <div class="btnArea">
	        <!--<button type="button" class="btn btn-primary" ng-click="memberUpdate()"><spring:message code='mem.btn.102'/></button>-->
	        <button type="button" class="btn btn-primary" ng-disabled="memberUpdateProfileForm.$invalid" ng-click="memberProfileModify()"><spring:message code='mem.btn.101'/></button>
	        <button type="button" class="btn btn-default" ng-click="goIndex();"><spring:message code='cmm.btn.005'/></button>
	    </div>
	</div>
	</form>
</div>