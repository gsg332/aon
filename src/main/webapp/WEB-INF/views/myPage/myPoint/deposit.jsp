<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ include file="/WEB-INF/views/myPage/myPoint/pointConfig.jsp" %>
				<form:form  name="depositForm" method="post" novalidate="true">
				<div class="sub_section">
                    <h3 class="sub_tit"><spring:message code="pnt.lbl.017"/></h3>
                    <div class="myPage">
                        <!-- question check -->
                        <!--
                        <div class="point_m_box">
                            <p class="body">지금 결제를 하셔도 최종 채택까지 정보제공자에게는 절달되지는 않습니다.<br>
                                최종 채택을 하신 후에 정보제공자에게 상금이 전달됩니다.<br>
                                채택 이전에 취소 하게 되면 나의포인트로 적립이 되고, 언제든 계좌이체를 통해 환불받으실 수 있습니다.</p>
                        </div>
                        -->
                        <!-- //question check -->
                        <!-- question input -->
                        <div class="required_item">
                            <ul class="ri_list">
                                <li>
                                    <label class="col-sm-2"><spring:message code="pnt.lbl.018"/></label>
                                    <div class="col-sm-10">
										<div>
											<aon-input-point ng-model="item.requestPoint" field-name="requestPoint" ng-required="true" minPoint="100" termPoint="100" ratio="<%=getRatioDollarToPoint()%>" />
											<!--
											<aon-input-price ng-model="item.requestPoint" field-name="requestPoint" ng-required="true"
											placeholder="" alert-message="<spring:message code="pnt.msg.003"/>" format-message="<spring:message code="cmm.msg.006"/>"
					           				min-message="<spring:message code="cmm.msg.007"/>" term-message="<spring:message code="cmm.msg.008"/>" limit-message="<spring:message code="cmm.msg.010"/>" price-check="true"></aon-input-price>
					           				-->
										</div>
										<span class="black small"><spring:message code="pnt.msg.022"/></span>
                                        <!--<span class="txt_etc"><spring:message code="cmm.msg.009"/></span>-->
                                    </div>
                                </li>
                                <li>
                                    <label class="col-sm-2"><spring:message code="pnt.lbl.019"/></label>
                                    <div class="col-sm-10">
                                        <ul class="inset_list">
                                            <li>
                                                <label class="col-sm-2"><spring:message code="pnt.lbl.020"/></label>
                                                <div class="col-sm-10">
                                                    <div class="check_rs fm_type200">
                                                    	<aon-input-text ng-model="item.requestAccountName" field-name="requestAccountName" label="" placeholder="" ng-required="true" alert-message="<spring:message code="pnt.msg.004"/>"></aon-input-text>
                                                    </div>
                                                </div>
                                            </li>
                                            <!--
                                            <li>
                                                <label class="col-sm-2">입금은행</label>
                                                <div class="col-sm-10">
                                                    <input id="requestDepositName" name="requestDepositName" type="text" class="form-control fm_type200" placeholder="">
                                                </div>
                                            </li>
                                            -->
                                            <li><label class="col-sm-2"><spring:message code="pnt.lbl.021"/></label>
                                                <div class="col-sm-10">
                                                	<aon-date-picker ng-model="item.requestDate" field-name="requestDate" date="{{item.requestDate}}" ng-required="true" alert-message="<spring:message code="pnt.msg.005"/>"></aon-date-picker>
                                                </div>
                                            </li>
                                            <li>
                                                <label class="col-sm-2"><spring:message code="cmm.lbl.018"/></label>
                                                <div class="col-sm-10">
                                                    <sec:authentication property="principal.customUser.loginId"/>
                                                </div>
                                            </li>
                                            <li>
                                                <label class="col-sm-2"><spring:message code="cmm.lbl.019"/></label>
                                                <div class="col-sm-10">
                                                    <sec:authentication property="principal.customUser.cellPhoneNumber"/>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </li>
                            </ul>
                            <div class="txt_etc">
                                <spring:message code="pnt.msg.006"/><br>
                                <spring:message code="pnt.msg.007"/><br>
                                <spring:message code="pnt.msg.008"/>
                            </div>
                        </div>
                        <!-- //question input -->
                        <div class="btnArea">
                            <button type="button" class="btn btn-primary" ng-disabled="depositForm.$invalid" ng-click="submit()"><spring:message code="cmm.btn.004"/></button>
                            <button type="button" class="btn btn-default" ng-click="cancel()"><spring:message code="cmm.btn.005"/></button>
                        </div>
                        <!-- point modal -->
                        <!--
                        <div class="modal fade" id="noPoint" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                        <h4 class="modal-title">포인트 부족</h4>
                                    </div>
                                    <div class="modal-body center">
                                        <p><strong>포인트가 부족합니다.</strong></p>
                                        <p class="modalTxt2">현재 포인트가 <strong class="emerald">160,000 점</strong>이 있습니다. <br>포인트를 충전하신 후 이용이 가능합니다.</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn green">Deposit Points</button>
                                        <button type="button" class="btn dark btn-outline" data-dismiss="modal">Back</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        -->
                        <!-- //point modal -->
                    </div>
				</div>
				</form:form>