<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
            <!-- mem_app -->
            <form name="joinProfile" id="joinProfile" novalidate="true" enctype="multipart/form-data">	
	            <input type="hidden" name="bankCode" id="bankCode" ng-value="bank.code"/>
	            <div class="member_app">
	                <ul class="ma_list">
	                    <li>
	                        <div class="ma_txt mT_01">
	                            <span><spring:message code='mem.lbl.002'/></span>
	                        </div>
	                    </li>
	                    <li>
	                        <div class="ma_txt mT_02">
	                            <span><spring:message code='mem.lbl.003'/></span>
	                        </div>
	                    </li>
	                    <li class="active">
	                        <div class="ma_txt mT_03">
	                            <span><spring:message code='mem.lbl.004'/></span>
	                        </div>
	                    </li>
	                </ul>
	                <h2 class="ma_h3"><spring:message code='mem.lbl.004'/></h2>
	                <div class="em_info">
	                    <p><spring:message code='mem.msg.019'/></p>
	                    <div class="required_item">
	                        <ul class="ri_list">
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.023'/></label>
	                                <div class="col-sm-9">
	                                	<div class="er_box fm_type300">
		                                   	<aon-input-text ng-model="profileTitle" field-name="profileTitle" placeholder="<spring:message code='mem.msg.020'/>" value=""></aon-input-text>
		                                </div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.024'/></label>
	                                <div class="col-sm-9">
	                                    <div class="radio-list" ng-init="open=0">
	                                        <div class="checks">
	                                            <input type="radio" name="open" id="Public" ng-model="open" checked="checked" value="0">
	                                            <label for="Public"><spring:message code='mem.lbl.025'/></label>
	                                        </div>
	                                        <div class="checks">
	                                            <input type="radio" name="open" id="Private" ng-model="open" value="1">
	                                            <label for="Private"><spring:message code='mem.lbl.026'/></label>
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
					                        <option ng-repeat="category in categoryList" ng-selected="{{category.id == depth1}}" value="{{category.id}}">{{category.name | ctgrLang}}</option>
					                    </select>
				                       	<div class="has-feedback i_block">
					                        <select class="form-control wAuto" required-sub-select id="depth2" index="1" ng-model="depth2" ng-show="depthShow1" data-toggle="tooltip" title="<spring:message code='cat.msg.002'/>">
					                        	<option value="0" ><spring:message code='cat.msg.002'/></option>
					                        	<option ng-repeat="category in subCategoryList1" ng-selected="{{category.id == depth2}}" value="{{category.id}}" >{{category.name | ctgrLang}}</option>
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
				                            <option ng-repeat="category in categoryList" ng-selected="{{category.id == depth3}}" value="{{category.id}}">{{category.name | ctgrLang}}</option>
				                        </select>
				                        <div class="has-feedback i_block">
					                        <select class="form-control wAuto" required-sub-select index="2" id="depth4" ng-model="depth4" ng-show="depthShow2" data-toggle="tooltip" title="<spring:message code='cat.msg.002'/>">
					                        	<option value="0" ><spring:message code='cat.msg.002'/></option>
					                        	<option ng-repeat="category in subCategoryList2" ng-selected="{{category.id == depth4}}" value="{{category.id}}" >{{category.name | ctgrLang}}</option>
					                        </select>
				                        </div>
				                        <input type="text" name="categories[1].tag" id="tag2" ng-model="tag2" ng-show="tagShow2" placeholder="<spring:message code='cat.msg.001'/>" class="form-control wAuto"/>
	                                	<input type="hidden" name="categories[1].categoryId" id="depthValue2" ng-model="depthValue2" value="{{depthValue2}}" />
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.030'/> </label>
	                                <div class="col-sm-9">
	                                	<div class="fm_type500">
	                                		<aon-image-file ng-model="profileName" field-name="image"></aon-image-file>
	                                	</div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.031'/></label>
	                                <div class="col-sm-9">
	                                    <div class="aon">
	                                        <span class="aon_span as_left"><spring:message code='mem.lbl.032'/></span>
	                                        <div class="as_right">
													<input type="text" readonly="readonly" ng-value="bank.name" class="form-control fm_type140"/>
	                                            <div class="er_box fm_type300">
	                                            	<aon-bank ng-model="accountNumber" field-name="accountNumber" relative-tag-name="accountNumber,accountName" alert-message="<spring:message code='mem.msg.022'/>" placeholder="<spring:message code='mem.msg.022'/>" ng-required="accountName" />
		                                		</div>
	                                        </div>
	                                    </div>
	                                    <div class="aon">
	                                        <span class="aon_span"><spring:message code='mem.lbl.034'/></span>
	                                        <div class="er_box fm_type300">
	                                        	<aon-bank ng-model="bankAccount.accountName" field-name="accountName" relative-tag-name="accountNumber,accountName" alert-message="<spring:message code='mem.msg.023'/>" placeholder="<spring:message code='mem.msg.023'/>" ng-required="accountNumber" />
											</div>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.035'/></label>
	                                <div class="col-sm-9">
	                                    <aon-textarea name="career" ng-model="career" field-name="career" placeholder="<spring:message code='mem.msg.024'/>" value=""></aon-textarea>
	                                </div>
	                            </li>
	                            <li>
	                                <label class="col-sm-3"><spring:message code='mem.lbl.036'/></label>
	                                <div class="col-sm-9">
	                                    <aon-textarea name="introduce" ng-model="introduce" field-name="introduce" placeholder="<spring:message code='mem.msg.025'/>" value=""></aon-textarea>
	                                </div>
	                            </li>
	                        </ul>
	                    </div>
	                    <div class="btnArea">
	                        <button class="btn btn-primary" data-toggle="modal" ng-click="joinFinish()"><spring:message code='mem.lbl.037'/></button>
	                        <button type="button" class="btn btn-default"><spring:message code='cmm.btn.005'/></button>
	                    </div>
	                    <!-- 가입 확인 레이어 -->
	                    <div class="modal fade" id="confirmJoin" tabindex="-1" aria-hidden="true">
	                        <div class="modal-dialog">
	                            <div class="modal-content">
	                                <div class="modal-header">
	                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                                </div>
	                                <div class="modal-body center">
	                                    <p class="modalTxt1"><spring:message code='mem.msg.026'/></p>
	                                </div>
	                                <div class="modal-footer">
	                                    <button type="button" class="btn green" data-dismiss="modal" ng-disabled="joinProfile.$invalid" ng-click="memberJoinFinish()"><spring:message code='cmm.btn.016'/></button>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                    <!-- //가입 확인 레이어 -->
	                </div>
	            </div>
            </form>
            <!-- //mem_app -->
