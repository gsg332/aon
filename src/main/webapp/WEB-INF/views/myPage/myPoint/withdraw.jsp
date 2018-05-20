<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ include file="/WEB-INF/views/myPage/myPoint/pointConfig.jsp" %>
				<form:form name="withdrawForm" method="post" novalidate="true">
				<input type="hidden" name="certifyId" ng-model="item.certifyId" value="{{item.certifyId}}" />
				<div class="sub_section">
                    <h3 class="sub_tit"><spring:message code="pnt.lbl.022"/></h3>
                    <div class="myPage">
                        <!-- question input -->
                        <div class="required_item">
                            <ul class="ri_list">
                                <li>
                                    <label class="col-sm-3"><spring:message code="pnt.lbl.023"/></label>
                                    <div class="col-sm-9">
										<!--<div class="check_rs fm_type140">-->
										<div>
											<aon-input-point ng-model="item.requestPoint" field-name="requestPoint" ng-required="true" minPoint="5000" termPoint="100" ratio="<%=getRatioDollarToPoint()%>" />
										</div>
                                        <span class="black small"><spring:message code="pnt.msg.023"/></span>
                                        <!--<span class="txt_etc"><spring:message code="cmm.msg.009"/></span>-->
                                    </div>
                                </li>
                                <li>
                                    <label class="col-sm-3"><spring:message code="pnt.lbl.054"/></label>
                                    <div class="col-sm-9">
                                    	<div class="check_rs fm_type160">
                                    		<aon-input-email ng-model="item.paypalAccount" field-name="paypalAccount"  label="Paypal account" ng-required="true"
                                    			format-message="<spring:message code='pnt.msg.027'/>" formated="true" alert-message="<spring:message code='pnt.msg.026'/>">
                                    	</div>
								</aon-input-email>
                                    </div>
                                </li>
                                <li>
                                    <label class="col-sm-3"><spring:message code="pnt.lbl.005"/></label>
                                    <div class="col-sm-9">
                                        <span class="emerald">{{cyberAccount.balance | Apoint}}</span> <spring:message code="cmm.lbl.014"/>
                                    </div>
                                </li>
                                <li>
                                    <label class="col-sm-3"><spring:message code="cmm.lbl.019"/></label>
                                    <div class="col-sm-9">
                                    	<aon-phonenumber-send phone-num="{{member.cellPhoneCountryCode}} {{member.cellPhoneNumber}}" aon-callback-send="callbackSend()" aon-callback-auth="callbackAuth()"></aon-phonenumber-send>
                                    </div>
                                </li>
                            </ul>
                            <p class="txt_etc"><spring:message code="pnt.msg.028"/></p><br>
                            <p class="txt_etc"><spring:message code="pnt.msg.029"/></p><br>
                            <p class="txt_etc"><spring:message code="pnt.msg.024"/> <%=getFeesPercent()%><spring:message code="pnt.msg.025"/></p>
                        </div>
                        <!-- //question input -->                        
                        <div class="btnArea">
                            <button type="button" class="btn btn-primary" ng-disabled="withdrawForm.$invalid" ng-click="submit()"><spring:message code="cmm.btn.004"/></button>
                            <button type="button" class="btn btn-default" ng-click="cancel()"><spring:message code="cmm.btn.005"/></button>
                        </div>
                    </div>
                    <!-- 은행계좌번호 수정안내 modal 레이어
                    <div class="modal fade adoptA" id="adoptA" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                    <h4 class="modal-title"><spring:message code="cmm.lbl.020"/></h4>
                                </div>
                                <div class="modal-body center">
                                    <p class="modalTxt1"><spring:message code="pnt.msg.013"/></p>
                                    <p class="modalTxt2"><spring:message code="pnt.msg.014"/></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn green" ng-click="goBankAccountUpdate()"><spring:message code="cmm.btn.016"/></button>
                                    <button type="button" class="btn dark btn-outline" data-dismiss="modal" ng-click="cancel()"><spring:message code="cmm.btn.005"/></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    //은행계좌번호 수정안내 modal 레이어 -->
                </div>
                </form:form>