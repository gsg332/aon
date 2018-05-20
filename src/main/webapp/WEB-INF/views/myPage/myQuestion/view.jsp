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
                                    <ul class="info_etc info_etc_b block">
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
                                            	<aon-textarea ng-model="cancelReason" field-name="cancelReason" placeholder="<spring:message code='cmm.msg.003'/>" ng-required="true" alert-message="<spring:message code='cmm.msg.003'/>"></aon-textarea>
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
                    </div>
                    <!-- warning -->
                    <div class="warnBox" ng-if="item.status == 1000">
                        <span id="warnContent">
                            <i class="glyphicon glyphicon-alert" style="padding-right:7px"></i><spring:message code='cts.msg.021'/>
                        </span>
                    </div>
	                <!-- //warning -->
                    <!-- 답변목록 리스트 -->
                    <div class="answer_list">
                        <h4 class="blue"><spring:message code='cts.lbl.038'/></h4>
                        <div class="basic_table">
                            <ul class="bt_top">
                                <li class="bt_favorite"><spring:message code='cts.lbl.039'/></li>
                                <li class="bt_id"><spring:message code='cts.lbl.015'/></li>
                                <li class="bt_title"><spring:message code='cts.lbl.006'/></li>
                                <li class="bt_score"><spring:message code='cts.lbl.033'/></li>
                                <li class="bt_answer"><spring:message code='cts.lbl.036'/></li>
                                <li class="bt_date"><spring:message code='cts.lbl.040'/></li>
                            </ul>
                            <ul class="bt_con">
                                <!-- data가 없을 경우 현재 display:none 처리 -->
                                <li class="data_none" ng-show="totalItems == 0"><spring:message code='cts.msg.022'/></li>
                                <!-- //data가 없을 경우 -->
                                <li ng-repeat="question in replyList" ng-class="question[8] ? 'active' : ''">
                                    <div class="bt_favorite"><span ng-class="question[9] ? 'on' : ''"><spring:message code='cts.lbl.041'/></span></div>
                                    <div class="bt_id left">{{question[11].displayName}}</div>
                                    <div class="bt_title left">
                                        <a href='<c:url value="#/allView/{{question[1]}}/{{question[0]}}"/>' ng-bind-html="question[5]"></a>
                                    </div>
                                    <div class="bt_score">{{question[10]}}</div>
                                    <div class="bt_answer"><span class="blue">{{question[13]}}</span></div>
                                    <div class="bt_date" ng-if="question[8]"><span class="status adopt"><spring:message code='cts.lbl.004'/></span></div>
                                    <div class="bt_date" ng-if="!question[8]">{{question[12] | Adate }}</div>
                                </li>
                            </ul>
                        </div>
                        <!-- pagination -->
                        <div class="page_box" ng-show="totalItems > 0">
							<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
								ng-model="currentPage" ng-change="pageChanged()" class="pagination" previous-text="&lsaquo;"
								next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page ="10">
							</uib-pagination>
						</div>
                        <!-- //pagination -->
                    </div>
                    <!-- //답변목록 리스트 -->
                    <div class="btnArea btn_show">
				        <button type="button" ng-click="historyBack()" class="btn btn-default"><spring:message code='cmm.btn.002'/></button>
				        <button type="button" ng-if="choosedCount > 0 && item.status != 3000" ng-click="distribute()" class="btn btn-primary" data-toggle="modal" data-target="#appraisal">
							<span><spring:message code='cmm.btn.048'/></span>
						</button>
						<!-- 포인트 분배 Modal -->
						<div class="modal fade modal_long" id="appraisal" tabindex="-1" aria-hidden="true">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
										<h4 class="modal-title"><spring:message code='cts.lbl.012'/></h4>
									</div>
									<div class="modal-body">
										<div class="appl">
											<!-- 답변자 목록 -->
											<div class="appl_left">
												<select class="form-control appl_m_select">
													<option ng-repeat="answer in choosedAnswerList" value="{{answer.registerUser.memberId}}" >{{answer.registerUser.displayName}}({{answer.gradePoint}}<spring:message code='cmm.lbl.011'/>)</option>
												</select>
												<ul class="appl_select">
													<li class="active" ng-repeat="answer in choosedAnswerList | orderBy:'-gradePoint'">
														<a ng-click="showAnswer(answer); selected.answer = answer">{{answer.registerUser.displayName}}</a>
														<span class="score">{{answer.gradePoint}}<spring:message code='cmm.lbl.011'/></span>
													</li>
												</ul>
											</div>
											<!-- //답변자 목록 -->
											<div class="appl_right" ng-show="rightShow">
												<div ng-repeat="question in allBychoosedAnswer">
													<!-- 답변 내용 -->
													<div class="info_view info_view_A" ng-if="question.position == 1">
<%-- 							                            <span class="iv_check" ng-class="favorite ? 'on' : ''"><spring:message code='cts.lbl.032'/></span> --%>
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
							                        </div>
							                        <!-- //답변 내용 -->
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
							                        </div>
							                        <!-- //추가답변 -->
												</div>
											</div>
										</div>										
									</div>
									<div class="modal-footer">
										<button type="button" class="btn green" ng-click="completeChoose()"><spring:message code='cmm.btn.049'/></button>
										<button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code='cmm.btn.005'/></button>
									</div>
								</div>
							</div>
						</div>
						<!-- //포인트 분배 modal -->
				    </div>
                </div>
                