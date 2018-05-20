<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
                <div class="sub_section">
                    <h3 class="sub_tit"><spring:message code='cmm.menu.012'/></h3>
                    <div class="info_box">
                        <div class="info_view">
                            <div class="info_top i_q">
                                <div class="info_tbox">
                                    <strong class="info_tit">
                                        <span class="qNo">No.{{item.id}}</span> <p ng-bind-html="item.title"></p>
                                    </strong>
                                    <ul class="info_etc info_etc_b">
										<li ng-repeat="categ in item.categories[0].path" ng-if="!$first && categ != ''"><span>{{categ | ctgrLang}}</span></li>
										<li ng-if="item.categories[0].tag != ''"><span>{{item.categories[0].tag | ctgrLang}}</span></li>
									</ul>
                                    <ul class="info_etc">
                                        <li><span class="name black">{{item.registerUser.displayName}}</span></li>
                                        <li><span>{{item.point | Apoint}}</span></li>
                                        <li><span class="ie_date">{{item.expireDate | Adate }}</span></li>
                                        <li>
											<span class="status adopt" ng-if="item.choose"><spring:message code='cts.lbl.004'/></span>	
											<span class="status noadopt" ng-if="!item.choose"><spring:message code='cts.lbl.005'/></span>						
										</li>
										<li ng-if="item.status == 2000"><span class="status done"><spring:message code='cts.lbl.020'/></span></li>
										<li ng-if="item.status == 1000"><span class="status done"><spring:message code='cts.lbl.021'/></span></li>
										<li ng-if="item.status == 3000"><span class="status done"><spring:message code='cts.lbl.022'/></span></li>
										<li ng-if="item.status == 4000"><span class="status done"><spring:message code='cts.lbl.023'/></span></li>
										<li ng-if="item.status == 4100"><span class="status done"><spring:message code='cts.lbl.024'/></span></li>
										<li ng-if="item.status == 4200"><span class="status done"><spring:message code='cts.lbl.054'/></span></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="info_body" ng-bind-html="item.content"></div>
                            <div class="info_bottom">
                                <div class="info_file" ng-show="item.attachments.length > 0">
                                    <strong class="if_tit"><spring:message code='cmm.lbl.007'/></strong>
                                    <ul class="if_list" ng-repeat="attach in item.attachments">
										<li>
											<p><a href="<c:url value="/module/contest/download.aon?id="/>{{attach.id}}">{{attach.filename}}</a> (${(attach.size/1024)+(1-((attach.size/1024)%1)%1)} KB)</p>
										</li>
									</ul>
                                </div>
                                <div class="shareSNS">
									<span class="ss_tit"><spring:message code='cmm.lbl.008'/></span>
									<div class="ss_fb ss_icon" data-ng-click='postNewsfeed()'>facebook <spring:message code='cmm.btn.021'/></div>
					                <div class="ss_tw ss_icon" data-ng-click='postTwitter()'>twitter <spring:message code='cmm.btn.021'/></div>
				                </div>
                            </div>
                            <div class="center info_detail_btn">
								<button type="button" class="btn blue btn-outline" ng-if="item.status == 2000 && !item.choose" ng-click="openCancel()"><spring:message code='cmm.btn.029'/></button>
                            </div>
                            <!-- 질문취소 레이어 -->
                            <div id="cancelQ" class="modal fade cancelQ" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                            <h4 class="modal-title"><spring:message code='cts.lbl.031'/></h4>
                                        </div>
                                        <div class="modal-body">
                                            <p class="modalTxt1 center"><spring:message code='cts.msg.015'/></p>
                                            <p class="modalTxt2"><span class="modalTxt3"><spring:message code='cts.msg.016'/></span> <spring:message code='cts.msg.017'/></p>
                                            <form:form  name="cForm" method="post" novalidate="true">
                                            	<input type="hidden" name="id" value="{{item.id}}"/>
                                            	<aon-textarea ng-model="cancelReason" field-name="cancelReason" placeholder="<spring:message code='cmm.msg.003'/>" ng-required="true" alert-message="<spring:message code='cts.err.002'/>"></aon-textarea>
                                            </form:form>
                                            <span class="helpTxt"><spring:message code='cts.msg.018'/></span>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn green" ng-disabled="!cancelReason" ng-click="cancelSubmit()"><spring:message code='cmm.btn.030'/></button>
                                            <button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code='cmm.btn.027'/></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- //질문취소 레이어 -->
                        </div>
                        <div ng-repeat="question in replyList">
                        <!-- 답변 -->
                        <div class="info_view info_view_A" ng-if="question.position == 1">
                            <span class="iv_check" ng-class="favorite ? 'on' : ''"><spring:message code='cts.lbl.032'/></span>
                            <div class="info_top i_a">
                                <div class="info_tbox">
                                    <strong class="info_tit" ng-bind-html="question.title"></strong>
                                    <ul class="info_etc">
                                        <li><span class="name black">{{question.registerUser.displayName}}</span></li>
                                        <li><span class="ie_date">{{question.insertDate | Adate }}</span></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="info_body" ng-bind-html="question.content"></div>
                            <div class="info_bottom">
                            	<reply-file data-id="{{question.id}}"></reply-file>
                                <div class="info_score">
                                    <span class="head"><spring:message code='cts.lbl.033'/></span>
                                    <select class="form-control i_block" ng-model="gradePoint" ng-init="gradePoint=question.gradePoint" ng-options="point.id as point.name for point in gradePoints"></select>
                                    <button type="button" class="btn blue btn-outline" ng-click="gradePointSubmit(question.id, gradePoint)"><spring:message code='cmm.btn.031'/></button>
                                </div>
                            </div>
                            <div class="center info_detail_btn">
								<button type="button" class="btn btn-danger" ng-if="item.status == 2000 && canChoose && !question.choose" ng-click="openAgree()"><spring:message code='cmm.btn.004'/></button>
    	                        <button type="button" class="btn blue btn-outline" ng-click="addReply(question.groupId, question.id, question.answerGroupId)"><spring:message code='cmm.btn.032'/></button>
    	                        <button type="button" class="btn blue btn-outline" ng-show="!favorite" ng-click="favoriteToggle(question.id, true)"><spring:message code='cmm.btn.033'/></button>
    	                        <button type="button" class="btn blue btn-outline" ng-show="favorite" ng-click="favoriteToggle(question.id, false)"><spring:message code='cmm.btn.034'/></button>
	                        </div>
	                        <!-- 채택 확인 레이어 -->
                            <div id="adoptA" class="modal fade adoptA" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                            <h4 class="modal-title"><spring:message code='cts.lbl.034'/></h4>
                                        </div>
                                        <div class="modal-body center">
                                            <p class="modalTxt1"><spring:message code='cts.msg.019'/></p>
                                            <p class="modalTxt2"><spring:message code='cts.msg.020'/></p>
                                            <div class="checks modal_la">
                                            	<input type="checkbox" id="clauseAgree2" ng-model="clauseAgree2" ng-click="clauseAgreeClick()">
                                                <label for="clauseAgree2"><spring:message code='cts.msg.004'/></label>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn green" ng-disabled="!clauseAgree2" ng-click="clauseAgree(question.groupId, question.id)"><spring:message code='cmm.btn.004'/></button>
                                            <button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code='cmm.btn.030'/></button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- //채택 확인 레이어 -->
                        </div>
                        <!-- //답변 -->
                        <!-- 추가질문 -->
                        <div class="add_Q" ng-if="question.position > 1 && question.position % 2 == 0">
                            <div class="info_top i_q">
                                <div class="info_tbox">
                                    <strong class="info_tit"><spring:message code='cts.lbl.035'/></strong>
                                    <ul class="info_etc">
                                        <li><span class="name black">{{question.registerUser.displayName}}</span></li>
                                        <li><span class="ie_date">{{question.insertDate | Adate }}</span></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="info_body" ng-bind-html="question.content"></div>
                            <div class="info_bottom">
                            	<reply-file data-id="{{question.id}}"></reply-file>
                            </div>
                        </div>
                        <!-- //추가질문 -->
                        <!-- 추가답변 -->
                        <div class="add_A" ng-if="question.position > 1 && question.position % 2 == 1">
                            <div class="info_top i_a">
                                <div class="info_tbox">
                                    <strong class="info_tit"><spring:message code='cts.lbl.036'/></strong>
                                    <ul class="info_etc">
                                        <li><span class="name black">{{question.registerUser.displayName}}</span></li>
                                        <li><span class="ie_date">{{question.insertDate | Adate }}</span></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="info_body" ng-bind-html="question.content"></div>
                            <div class="info_bottom">
                            	<reply-file data-id="{{question.id}}"></reply-file>
                            </div>
                            <div class="center info_detail_btn">
                                <button type="button" class="btn blue btn-outline" ng-click="addReply(question.groupId, question.id, question.answerGroupId)"><spring:message code='cmm.btn.032'/></button>
                            </div>
                        </div>
                        <!-- //추가답변 -->
                        </div>
                        <!-- 추가 입력 창 -->
                        <div id="addReply" class="plus_box">
                        <form:form name="mForm" method="post" novalidate="true" enctype="multipart/form-data" ng-show="writeForm">
                        	<input type="hidden" name="title" ng-model="title" value="{{title}}">
							<input type="hidden" name="parentId" ng-model="parentId" value="{{parentId}}">
							<input type="hidden" name="groupId" ng-model="groupId" value="{{groupId}}">
							<input type="hidden" name="answerGroupId" ng-model="answerGroupId" value="{{answerGroupId}}">
                            <div class="required_item">
								<ul class="ri_list">
									<li>
										<label class="col-sm-3"><spring:message code='cts.lbl.037'/></label>
										<div class="col-sm-9">
											<aon-editor ng-model="content" field-name="content" label="" placeholder="<spring:message code='cmm.msg.003'/>" ng-required="true" alert-message="<spring:message code='ntc.err.002'/>"></aon-editor>
											<p class="txt_etc"><spring:message code='cmm.msg.004'/></p>
										</div>
									</li>
									<li>
                                    	<label class="col-sm-3"><spring:message code='cmm.lbl.007'/></label>
										<div class="col-sm-9 upload_file">
											<aon-files ng-model="attachments" field-name="attachments" label="FILES" insert-button-label="<spring:message code='cmm.btn.022'/>" delete-button-label="<spring:message code='cmm.btn.023'/>"></aon-files>
											<p class="txt_etc"><spring:message code='cmm.msg.005'/></p>
										</div>
									</li>
								</ul>
							</div>
							<div class="btnArea">
								<button type="button" class="btn btn-primary" ng-click="questionSubmit()" ng-disabled="mForm.$invalid"><spring:message code='cmm.btn.004'/></button>
								<button type="button" class="btn btn-default" ng-click="questionCancel()"><spring:message code='cmm.btn.005'/></button>
							</div>
						</form:form>
                        </div>
                        <!-- //추가 입력 창 -->
                    </div>
                    <div class="btnArea btn_show">
				        <button type="button" ng-click="historyBack()" class="btn btn-default"><spring:message code='cmm.btn.002'/></button>
				    </div>
                </div>