<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ include file="/WEB-INF/views/myPage/myPoint/pointConfig.jsp" %>
				<form:form  name="depositForm" method="post" novalidate="true">
				<div class="sub_section">
                    <h3 class="sub_tit"><spring:message code="pnt.lbl.017"/></h3>
                    <div class="myPage">
                        <!-- question input -->
                        <div class="required_item">
                            <ul class="ri_list">
                                <li>
                                    <label class="col-sm-2"><spring:message code="pnt.lbl.018"/></label>
                                    <div class="col-sm-10">
										<div>
											<aon-input-point ng-model="item.requestPoint" field-name="requestPoint" ng-required="true" minPoint="100" termPoint="100" ratio="<%=getRatioDollarToPoint()%>" />
										</div>
										<span class="black small"><spring:message code="pnt.msg.022"/></span>
                                        <!--<span class="txt_etc"><spring:message code="cmm.msg.009"/></span>-->
                                    </div>
                                </li>
                            </ul>
                            <p class="txt_etc"><spring:message code="pnt.msg.030"/></p><br>
                            <p class="txt_etc"><spring:message code="pnt.msg.031"/></p><br>
                            <p class="txt_etc"><spring:message code="pnt.msg.032"/></p>
                        </div>
                        <!-- //question input -->
                        <div class="btnArea">
                            <button type="submit" class="btn btn-primary" ng-disabled="depositForm.$invalid" ng-click="submit()">Checkout Paypal</button>
                            <button type="button" class="btn btn-default" ng-click="cancel()"><spring:message code="cmm.btn.005"/></button>
                        </div>
                    </div>
				</div>
				</form:form>