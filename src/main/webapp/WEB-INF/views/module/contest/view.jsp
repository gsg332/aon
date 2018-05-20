<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<!-- sub_con -->
<div class="sub_section">
	<h3 class="sub_tit"><spring:message code='cts.lbl.001'/></h3>
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
                        	<c:choose>
								<c:when test="${item.choose}">
									<span class="status adopt"><spring:message code='cts.lbl.004'/></span>	
								</c:when>
								<c:otherwise>
									<span class="status noadopt"><spring:message code='cts.lbl.005'/></span>						
								</c:otherwise>
							</c:choose>
						</li>
					</ul>
				</div>
			</div>
			<div class="info_body" ng-bind-html="item.content">
			</div>
			<div class="info_bottom">
				<div class="info_file" ng-show="item.attachments.length > 0">
					<strong class="if_tit"><spring:message code='cmm.lbl.007'/></strong>
					<ul class="if_list" ng-repeat="attach in item.attachments">
						<li>
							<p><a href='<c:url value="/module/contest/download.aon?id="/>{{attach.id}}'>{{attach.filename}}</a> (${(attach.size/1024)+(1-((attach.size/1024)%1)%1)} KB)</p>
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
		<div class="qReport">
			<button type="button" class="btn_basic" ng-click="openReport()"><spring:message code='cmm.btn.025'/></button> 
	        <!-- 신고하기 레이어 -->
            <div class="modal fade reportA" id="reportA" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                    <form:form name="reportForm" method="post" novalidate="true">
                    	<input type="hidden" name="qaId" value="{{item.id}}" ng-model="qaId"/>
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                            <h4 class="modal-title"><spring:message code='cts.lbl.027'/></h4>
                        </div>
                        <div class="modal-body">
                            <span class="helpTxt"><spring:message code='cts.msg.009'/></span>
                            <aon-textarea ng-model="reportA" field-name="content" placeholder="<spring:message code='cmm.msg.003'/>" ng-required="true" alert-message="<spring:message code='cts.err.002'/>"></aon-textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn green" ng-disabled="!reportA" ng-click="sendReport()"><spring:message code='cmm.btn.026'/></button>
                            <button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code='cmm.btn.015'/></button>
                        </div>
                    </form:form>
                    </div>
                </div>
            </div>
            <!-- //신고하기 레이어 -->
	    </div>
	    <div class="btnArea btn_show" ng-show="contestBtn">
	    	<div ng-hide="true">
		    	<sec:authorize access="isAnonymous()">
		    		{{ isLogin = false }}
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					{{ isLogin = true }}
				</sec:authorize>
			</div>
			<button type="button" class="btn btn-primary btn_w_modal" ng-click="goAnswer()" ng-disabled="!isLogin" ng-show="answerCompleate"><spring:message code='cmm.btn.007'/></button>
	        <a href='<c:url value="#/list"/>' class="btn btn-default"><spring:message code='cmm.btn.012'/></a>
	    </div>
	</div>
	<div class="q_answer" ng-show="answerView">
		<!-- answer check -->
		<div class="answer_box">
            <p class="top red"><spring:message code='cts.msg.002'/></p>
            <p class="body"><spring:message code='cts.msg.003'/></p>
            <div class="bottom">
                <div class="checks">
                    <input type="checkbox" id="answerCheck" ng-model="answerCheck">
                    <label for="answerCheck"><spring:message code='cts.msg.004'/></label>
                </div>
            </div>
        </div>
		<!-- //answer check -->
		<!-- answer input -->
		<div class="required_item">
			<form:form name="answerWriteForm" method="post" novalidate="true" enctype="multipart/form-data">
				<input type="hidden" name="parentId" value="{{item.id}}">
				<input type="hidden" name="groupId" value="{{item.id}}">
				<input type="hidden" name="step" value="{{item.step}}">
				<input type="hidden" name="position" value="{{item.position}}">
				<input type="hidden" name="categories[0].categoryId" value="{{item.categories[0].categoryId}}">
	            <ul class="ri_list">
	                <li>
	                    <label class="col-sm-3"><spring:message code='cts.lbl.006'/></label>
	                    <div class="col-sm-9">
	                        <aon-input-text ng-model="title" 
					           field-name="title"  label="Title" 
					           placeholder="<spring:message code='cmm.msg.002'/>" ng-required="true"
					           alert-message="<spring:message code='cmm.msg.002'/>"></aon-input-text>
	                    </div>
	                </li>
	                <li>
	                    <label class="col-sm-3"><spring:message code='cts.lbl.007'/></label>
	                    <div class="col-sm-9">
	                        <aon-editor ng-model="content" 
					           field-name="content" label="Content" 
					           placeholder="<spring:message code='cmm.msg.003'/>" ng-required="true" 
					           alert-message="<spring:message code='cmm.msg.003'/>"></aon-editor>
	                        <p class="txt_etc"><spring:message code='cmm.msg.004'/></p>
	                    </div>
	                </li>
	                <li>
	                    <label class="col-sm-3"><spring:message code='cmm.lbl.007'/></label>
	                    <div class="col-sm-9 upload_file">
	                        <aon-files ng-model="attachments"
					            field-name="attachments" label="FILES"
					            insert-button-label="<spring:message code='cmm.btn.022'/>" delete-button-label="<spring:message code='cmm.btn.023'/>">
					           </aon-files>
	                        <p class="txt_etc"><spring:message code='cmm.msg.005'/></p>
	                    </div>
	                </li>
	            </ul>
            </form:form>
        </div>
		<!-- //answer input -->
		<div class="btnArea">
			<button type="button" class="btn btn-primary" ng-click="openAnswerLayer()"><spring:message code='cmm.btn.004'/></button>
            <button type="button" class="btn btn-default" ng-click="cancelAnswerLayer()"><spring:message code='cmm.btn.005'/></button>
		</div>
		<!-- answer modal -->
        <div class="modal fade confirmA" id="confirmA" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                	<div class="modal-header">
				        <h4 class="modal-title"><spring:message code='cts.lbl.025'/></h3>
				    </div>
				    <div class="modal-body center">
				        <p class="m_answer_tit"><spring:message code='cts.msg.005'/></p>
				    </div>
				    <div class="modal-footer">
				        <button type="button" class="btn green" ng-click="answerSubmit()"><spring:message code='cmm.btn.004'/></button>
				        <button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code='cmm.btn.002'/></button>
				    </div>
                </div>
            </div>
        </div>
        <!-- //answer modal -->
	</div>
</div>
<!-- //sub_con -->