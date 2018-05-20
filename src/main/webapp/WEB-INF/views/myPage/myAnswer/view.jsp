<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
                <div class="sub_section">
                    <h3 class="sub_tit"><spring:message code='cmm.menu.013'/></h3>
                    <div class="info_box">
                        <div class="info_view">
                            <div class="info_top i_q">
                                <div class="info_tbox">
                                    <strong class="info_tit">
                                        <span class="qNo">No.{{item.id}}</span> <p ng-bind-html="item.title"></p>
                                    </strong>
                                    <ul class="info_etc info_etc_b  block">
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
                        </div>
                        <div ng-repeat="answer in replyList">
                        <!-- 답변 -->
                        <div class="info_view info_view_A" ng-if="answer.position == 1">
                            <div class="info_top i_a">
                                <div class="info_tbox">
                                    <strong class="info_tit" ng-bind-html="answer.title"></strong>
                                    <ul class="info_etc">
                                        <li><span class="name black">{{answer.registerUser.displayName}}</span></li>
                                        <li><span class="ie_date">{{answer.insertDate | Adate }}</span></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="info_body" ng-bind-html="answer.content"></div>
                            <div class="info_bottom">
                            	<reply-file data-id="{{answer.id}}"></reply-file>
                                <div class="info_score">
                                    <span class="head"><spring:message code='cts.lbl.033'/></span>
                                    <span class="grade">{{answer.gradePoint}}</span>
                                </div>
                            </div>
                        </div>
                        <!-- //답변 -->
                        <!-- 추가질문 -->
                        <div class="add_Q" ng-if="answer.position > 1 && answer.position % 2 == 0">
                            <div class="info_top i_q">
                                <div class="info_tbox">
                                    <strong class="info_tit"><spring:message code='cts.lbl.035'/></strong>
                                    <ul class="info_etc">
                                        <li><span class="name black">{{answer.registerUser.displayName}}</span></li>
                                        <li><span class="ie_date">{{answer.insertDate | Adate }}</span></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="info_body" ng-bind-html="answer.content"></div>
                            <div class="info_bottom">
                            	<reply-file data-id="{{answer.id}}"></reply-file>
                            </div>
                            <div class="center info_detail_btn">
                                <button type="button" class="btn blue btn-outline" ng-click="addReply(answer.groupId, answer.id, answer.answerGroupId)"><spring:message code='cts.lbl.036'/></button>
                            </div>
                        </div>
                        <!-- //추가질문 -->
                        <!-- 추가답변 -->
                        <div class="add_A" ng-if="answer.position > 1 && answer.position % 2 == 1">
                            <div class="info_top i_a">
                                <div class="info_tbox">
                                    <strong class="info_tit"><spring:message code='cts.lbl.036'/></strong>
                                    <ul class="info_etc">
                                        <li><span class="name black">{{answer.registerUser.displayName}}</span></li>
                                        <li><span class="ie_date">{{answer.insertDate | Adate }}</span></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="info_body" ng-bind-html="answer.content"></div>
                            <div class="info_bottom">
                            	<reply-file data-id="{{answer.id}}"></reply-file>
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
								<button type="button" class="btn btn-primary" ng-click="answerSubmit()" ng-disabled="mForm.$invalid"><spring:message code='cts.lbl.038'/></button>
								<button type="button" class="btn btn-default" ng-click="answerCancel()"><spring:message code='cmm.btn.005'/></button>
							</div>
						</form:form>
                        </div>
                        <!-- //추가 입력 창 -->
                    </div>
                    <div class="btnArea btn_show">
				        <button type="button" ng-click="historyBack()" class="btn btn-default"><spring:message code='cmm.btn.002'/></button>
				    </div>
                </div>