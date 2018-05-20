<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<div class="sub_section">
	<h3 class="sub_tit"><spring:message code='cts.lbl.028'/></h3>
	<div class="myPage">
		<!-- question check -->
		<div class="answer_box">
			<p class="top red"><spring:message code='cts.msg.010'/></p>
			<p class="body"><spring:message code='cts.msg.011'/></p>
            <div class="bottom">
            	<div class="checks">
                    <input type="checkbox" id="registCheck" ng-model="registCheck">
                    <label for="registCheck"><spring:message code='cts.msg.004'/></label>
                </div>
            </div>
		</div>
		<!-- //question check -->
		<!-- question input -->
		<form:form name="contestWriteForm" method="post" novalidate="true" 
   	 	 enctype="multipart/form-data">
   	 	 	<input type="hidden" name="chooseCount" value="{{item.chooseCount}}"/>
<!--    	 	 	<input type="hidden" name="shareType"/> -->
   	 	 	<input type="hidden" name="pointRatio" value="{{item.pointRatio}}"/>
   	 		<div class="required_item">
   	 			<ul class="ri_list">
   	 				<li>
                        <label class="col-sm-3"><spring:message code='cmm.lbl.002'/></label>
                        <div class="col-sm-9">
                            <aon-input-text ng-model="item.title" 
					           field-name="title"  label="Title" 
					           placeholder="<spring:message code='cmm.msg.002'/>" ng-required="true"
					           alert-message="<spring:message code='cts.err.001'/>"></aon-input-text>
                        </div>
                    </li>
                    <li>
                        <label class="col-sm-3"><spring:message code='cts.lbl.029'/></label>
                        <div class="col-sm-9">
                            <select class="form-control wAuto" id="depth1" ng-change="categoryChange()" ng-model="depth1" data-toggle="tooltip" title="<spring:message code='cat.msg.002'/>" >
                                <option value="0" ><spring:message code='cat.msg.002'/></option>
                                <option ng-repeat="category in categoryList" value="{{category.id}}" >{{category.name | ctgrLang}}</option>
                            </select>
                            <select class="form-control wAuto" id="depth2" ng-change="subChange()" ng-model="depth2" ng-show="depthShow" data-toggle="tooltip" title="<spring:message code='cat.msg.002'/>" >
                            	<option value="0" ><spring:message code='cat.msg.002'/></option>
                            	<option ng-repeat="category in subCategoryList" value="{{category.id}}" >{{category.name | ctgrLang}}</option>
                            </select>
                            <input type="text" name="categories[0].tag" id="tag" ng-model="tag" ng-show="tagShow" placeholder="<spring:message code='cat.msg.001'/>" title="<spring:message code='cat.msg.001'/>" class="form-control wAuto"/>
                            <input type="hidden" name="categories[0].categoryId" ng-model="depth" value="{{depth}}" />
                        </div>
                    </li>
                    <li>
                        <label class="col-sm-3"><spring:message code='cts.lbl.008'/></label>
                        <div class="col-sm-9">
                        	<aon-input-point ng-model="item.point" field-name="point" ng-required="true" minPoint="100" termPoint="1" ratio="100" readonly-true="true" is-not-disp="true" />
                        </div>
                    </li>
                    <li>
	                    <label class="col-sm-3"><spring:message code='cts.lbl.030'/></label>
	                    <div class="col-sm-9">
	                    	<aon-date-picker ng-model="item.expireDate"  
					           field-name="expireDate"  label="expireDate" 
					           ng-required="true" date="{{item.expireDate}}"></aon-date-picker>
	                    </div>
	                </li>
	                <li>
                        <label class="col-sm-3"><spring:message code='cmm.lbl.003'/></label>
                        <div class="col-sm-9">
                            <aon-editor ng-model="item.content" 
					           field-name="content" label="Content" 
					           placeholder="<spring:message code='cmm.msg.003'/>" ng-required="true" 
					           alert-message="<spring:message code='cts.err.002'/>"></aon-editor>
                            <p class="txt_etc"><spring:message code='cmm.msg.004'/></p>
                        </div>
                    </li>
                    <li>
                        <label class="col-sm-3"><spring:message code='cmm.lbl.007'/></label>
                        <div class="col-sm-9 upload_file">
                            <aon-files ng-model="item.attachments"
					            field-name="attachments" label="FILES"
					            insert-button-label="<spring:message code='cmm.btn.022'/>" delete-button-label="<spring:message code='cmm.btn.023'/>">
					           </aon-files>
                            <p class="txt_etc"><spring:message code='cmm.msg.005'/></p>
                        </div>
                    </li>
   	 			</ul>
   	 		</div>
   	 	</form:form>
		<!-- //question input -->
		<div class="btnArea">
            <button type="button" class="btn btn-primary" id="contestWrite" ng-click="submit()" ng-disabled="contestWriteForm.$invalid"><spring:message code='cmm.btn.004'/></button>
            <a href='<c:url value="#/list"/>' class="btn btn-default"><spring:message code='cmm.btn.005'/></a>
        </div>
        <!-- point modal -->
        <div class="modal fade noPoint" id="noPoint" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title"><spring:message code='cts.lbl.026'/></h4>
                    </div>
                    <div class="modal-body center">
                        <p><strong><spring:message code='cts.msg.006'/></strong></p>
        				<p class="modalTxt2"><spring:message code='cts.msg.007'/> <strong class="emerald">{{point | Apoint}} <spring:message code='cmm.lbl.011'/></strong><spring:message code='cts.msg.008'/></p>
                    </div>
                    <div class="modal-footer">
                        <a href='<c:url value="/myPage/myPoint/index.aon#/deposit"/>' class="btn green"><spring:message code='cmm.btn.024'/></a>
                        <button type="button" class="btn dark btn-outline" data-dismiss="modal" ng-show="!zeroPoint"><spring:message code='cmm.btn.002'/></button>
                    </div>
                </div>
            </div>
        </div>
        <!-- //point modal -->
        <!-- writeSimple modal -->
        <div class="modal fade writeSimple" id="writeSimple" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title"><spring:message code='cts.lbl.051'/></h4>
                    </div>
                    <div class="modal-body">
                    
	                    <div class="mpb_body mpb_pc">				
							<div class="mpb_center">
								<div class="mpb_info">
									<div class="mpb_question">
										<input type="text" class="form-control" ng-model="item.title" id="title" placeholder="<spring:message code='cts.msg.023'/>">
									</div>													
								</div>
								<div class="mpb_form">
									<form class="form-inline">
										<div class="form-group">
											<input type="text" class="form-control" id="point" num-chk ng-model="tmpVal" placeholder="<spring:message code='cts.msg.024'/>">
										</div>
										<div class="form-group" id="memberArea" style="display:none;">
											<input type="text" class="form-control mini" id="member" num-chk ng-model="tmpVal"> <spring:message code='cts.lbl.057'/>
										</div>
										<!-- <button class="btn btn-success" onclick="angular.element(this).scope().distribution()">적용</button><br> -->
										<!-- <button type="button" class="btn btn-success" onclick="angular.element(this).scope().distribution()" ng-click="distribution()"><spring:message code='cmm.btn.050'/></button><br> -->
									</form>
								</div>						
								<div class="mpb_slider" style="display:none;">
									<p class="mpb_message" style="display:none;">
										<span><spring:message code='cts.lbl.058'/></span>
										<!--<sapn>1등의 지급 포인트는 XXXXXX포인트 입니다.</sapn>-->
									</p>
									<div class="panel panel-success" id="slider-area" style="display:none">				
										<slider model="otherProbs" init_flg="initFlg" point_data="pointData" apply-callback="distribution()" receive-callback="receive(data, correction, returnPoint, title, pointSimple, chooseCount, equal)"></slider>
									</div>
									<input type="hidden" name="pointRatio" id="pointRatio" ng-model="pointRatio" />
								</div>
								<!-- <div class="panel panel-success" id="slider-area" style="display:none">				
									<slider model="otherProbs" init_flg="initFlg" point_data="pointData" apply-callback="distribution()" receive-callback="receive(data, correction, returnPoint, pointSimple, chooseCount, equal)"></slider>
								</div>
								<input type="hidden" name="pointRatio" id="pointRatio" /> -->
							</div>					
						</div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn green" id="btnRegist" ng-disabled="!(otherProbs.length && item.title)">확인</button>
                        <button type="button" class="btn dark btn-outline" data-dismiss="modal">이전</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- //writeSimple modal -->
	</div>
</div>