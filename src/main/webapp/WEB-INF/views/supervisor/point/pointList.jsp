<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ include file="/WEB-INF/views/myPage/myPoint/pointConfig.jsp" %>
                <h2 class="page_tit"><spring:message code="pnt.lbl.047" /></h2>
                <!-- point top box -->
                <table class="adminTable">
                    <colgroup>
                        <col style="width:11%;">
                        <col style="width:22%;">
                        <col style="width:11%;">
                        <col style="width:22%;">
                        <col style="width:11%;">
                        <col style="width:auto;">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="row"><spring:message code="mem.lbl.011"/></th>
                            <td>{{member.firstName}} {{member.lastName}}</td>
                            <th scope="row"><spring:message code="mem.lbl.007"/></th>
                            <td>{{member.loginId}}</td>
                            <th scope="row"><spring:message code="mem.lbl.008"/></th>
                            <td>{{member.nickname}}</td>
                        </tr>
                        <tr>
                            <th scope="row"><spring:message code="pnt.lbl.003"/></th>
                            <td class="right t_blue">{{cyberAccount.depositSum | Apoint}}</td>
                            <th scope="row"><spring:message code="pnt.lbl.002"/></th>
                            <td class="right t_red">{{cyberAccount.withdrawSum | Apoint}}</td>
                            <th scope="row"><spring:message code="pnt.lbl.001"/></th>
                            <td class="right">{{cyberAccount.balance | Apoint}}</td>
                        </tr>
                    </tbody>
                </table>
                <!-- //point top box -->
                <div class="btnArea">
                    <button type="button" class="btn btn-primary" ng-click="deposit()"><spring:message code="cmm.btn.024"/></button>
                    <button type="button" class="btn btn-primary" ng-click="withdraw()" ><spring:message code="cmm.btn.038"/></button>
                </div>
                
                <!-- list -->
                <table class="adminTable">
                    <colgroup>
                        <col style="width:9%;">
                        <col style="width:9%;">
                        <col style="width:10%;">
                        <col style="width:10%;">
                        <col style="width:auto;">
                        <col style="width:9%;">
                        <col style="width:8%;">
                        <col style="width:8%;">
                        <col style="width:8%;">
                        <col style="width:18%;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"><spring:message code="pnt.lbl.026"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.048"/></th>
                            <th scope="col"><spring:message code="cmm.lbl.003"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.039"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.049"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.046"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.050"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.041"/></th>
                            <th scope="col"><spring:message code="cmm.lbl.021"/></th>
                            <th scope="col"><spring:message code="cmm.lbl.022"/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- data가 없을 경우 현재 display: none 처리-->
                        <tr class="data_none" ng-show="totalItems == 0">
                            <td colspan="11"><spring:message code="cmm.msg.012"/></td>
                        </tr>
                        <!-- // data가 없을 경우 -->
                        <!-- 0:point_id -->
                        <!-- 1:request_date -->
                        <!-- 2:confirm_date -->
                        <!-- 3:type -->
                        <!-- 4:request_point -->
                        <!-- 5:confirm_point -->
                        <!-- 6:amount -->
                        <!-- 7:confirm_account_name -->
                        <!-- 8:confirm_bank_code -->
                        <!-- 9:confirm_account_number -->
                        <!-- 10:source_id -->
                        <!-- 11:admin_id(member_id) -->
                        <!-- 12:loginid(admin loginid) -->
                        <!-- 13:admin_comment -->
                        <tr ng-repeat="point in pointList">
                            <td>{{point[1] | Adate}}</td>
                            <td>{{point[2] | Adate}}</td>
                            <td>
                            	<span ng-if="point[3] == 1000"><spring:message code="pnt.type.1000"/> (<spring:message code="cmm.lbl.017"/> : {{point[9]}})</span>
                               	<span ng-if="point[3] == 1010"><spring:message code="pnt.type.1010"/> (<spring:message code="cmm.lbl.017"/> : {{point[9]}})</span>
                               	<span ng-if="point[3] == 1020"><spring:message code="pnt.type.1020"/></span>
                               	<span ng-if="point[3] == 1030"><spring:message code="pnt.type.1030"/> (<spring:message code="cmm.lbl.017"/> : {{point[9]}})</span>
                               	<span ng-if="point[3] == 1090"><spring:message code="pnt.type.1090"/></span>
                               	<span ng-if="point[3] == -1000"><spring:message code="pnt.type.-1000"/> (<spring:message code="cmm.lbl.017"/> : {{point[9]}})</span>
                               	<span ng-if="point[3] == -1020"><spring:message code="pnt.type.-1020"/></span>
                               	<span ng-if="point[3] == -1090"><spring:message code="pnt.type.-1090"/></span>
                            </td>
                            <td class="right">{{point[4] | Apoint}}</td>
                            <td class="right"><span ng-class="point[3] < 0 ?  'red' : ''">{{point[5] | Apoint}}</span></td>
                            <td>{{point[7]}}</td>
                            <td>{{point[8]}}</td>
                            <td>{{point[9]}}</td>
                            <td>{{point[12]}}</td>
                            <td class="left">{{point[13]}}</td>
                        </tr>
                    </tbody>
                </table>
                <!-- //list -->
                <!-- pagination -->
                <div class="page_box" ng-show="totalItems > 0">
                	<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" ng-model="currentPage" ng-change="pageChanged()" class="pagination" previous-text="&lsaquo;"
                   	next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page="itemsPerPage">
					</uib-pagination>
				</div>
                <!-- //pagination -->
                
                <!-- deposit modal -->
                <form:form name="depositAdminForm" method="post">
                <input type="hidden" name="cyberAccId" value="{{cyberAccountItem.id}}"/>
                <div class="modal fade" id="PointDeposit" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                <h4 class="modal-title"><spring:message code="pnt.lbl.051"/></h4>
                            </div>
                            <div class="modal-body">
                                <div class="modal-body">
                                    <table class="adminTable">
                                        <colgroup>
                                            <col style="width:20%;">
                                            <col style="width:30%;">
                                            <col style="width:20%;">
                                            <col style="width:auto;">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row"><spring:message code="mem.lbl.011"/></th>
                                                <td>{{memberItem.firstName}} {{memberItem.lastName}}</td>
                                                <th scope="row"><spring:message code="mem.lbl.007"/></th>
                                                <td>{{memberItem.loginId}}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><spring:message code="mem.lbl.008"/></th>
                                                <td>{{memberItem.nickname}}</td>
                                                <th scope="row"><spring:message code="pnt.lbl.003"/></th>
                                                <td class="right t_blue">{{cyberAccountItem.depositSum | Apoint}}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><spring:message code="pnt.lbl.002"/></th>
                                                <td class="right t_red">{{cyberAccountItem.withdrawSum | Apoint}}</td>
                                                <th scope="row"><spring:message code="pnt.lbl.001"/></th>
                                                <td class="right">{{cyberAccountItem.balance | Apoint}}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <table class="adminTable" style="margin-top:10px">
                                        <colgroup>
                                            <col style="width:20%;">
                                            <col style="width:auto;">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row"><spring:message code="pnt.lbl.032"/></th>
                                                <td class="left">
                                                	<aon-input-point ng-model="depositItem.confirmPoint" field-name="confirmPoint" ng-required="true" minPoint="1" termPoint="1" ratio="<%=getRatioDollarToPoint()%>" />
                                                	<!--
                                                    <aon-input-text ng-model="depositItem.confirmPoint" field-name="confirmPoint" label="" placeholder="" ng-required="true" alert-message="<spring:message code="pnt.msg.015"/>"></aon-input-text>
                                                    -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><spring:message code="cmm.lbl.022"/></th>
                                                <td class="left">
                                                    <aon-input-text ng-model="depositItem.adminComment" field-name="adminComment" label="" placeholder=""></aon-input-text>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn green" ng-disabled="depositAdminForm.$invalid" ng-click="depositSubmit()"><spring:message code="cmm.btn.004"/></button>
                                <button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code="cmm.btn.005"/></button>
                            </div>
                        </div>
                    </div>
                </div>
                </form:form>
                <!-- //deposit modal -->
                <!-- Withdraw modal -->
                <form:form name="withdrawAdminForm" method="post">
                <input type="hidden" name="cyberAccId" value="{{cyberAccountItem.id}}"/>
                <div class="modal fade" id="PointWithdraw" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                <h4 class="modal-title"><spring:message code="pnt.lbl.022"/></h4>
                            </div>
                            <div class="modal-body">
                                <div class="modal-body">
                                    <table class="adminTable">
                                        <colgroup>
                                            <col style="width:20%;">
                                            <col style="width:30%;">
                                            <col style="width:20%;">
                                            <col style="width:auto;">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row"><spring:message code="mem.lbl.011"/></th>
                                                <td>{{memberItem.firstName}} {{memberItem.lastName}}</td>
                                                <th scope="row"><spring:message code="mem.lbl.007"/></th>
                                                <td>{{memberItem.loginId}}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><spring:message code="mem.lbl.008"/></th>
                                                <td>{{memberItem.nickname}}</td>
                                                <th scope="row"><spring:message code="pnt.lbl.003"/></th>
                                                <td class="right t_blue">{{cyberAccountItem.depositSum | Apoint}}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><spring:message code="pnt.lbl.002"/></th>
                                                <td class="right t_red">{{cyberAccountItem.withdrawSum | Apoint}}</td>
                                                <th scope="row"><spring:message code="pnt.lbl.001"/></th>
                                                <td class="right">{{cyberAccountItem.balance | Apoint}}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <table class="adminTable" style="margin-top:10px">
                                        <colgroup>
                                            <col style="width:20%;">
                                            <col style="width:auto;">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row"><spring:message code="pnt.lbl.042"/></th>
                                                <td class="left">
                                                	<aon-input-point ng-model="withdrawItem.confirmPoint" field-name="confirmPoint" ng-required="true" minPoint="1" termPoint="1" ratio="<%=getRatioDollarToPoint()%>" />
                                                    <!--
                                                    <aon-input-text ng-model="withdrawItem.confirmPoint" field-name="confirmPoint" label="" placeholder="" ng-required="true" alert-message="<spring:message code="pnt.msg.015"/>"></aon-input-text>
                                                    -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><spring:message code="cmm.lbl.022"/></th>
                                                <td class="left">
                                                    <aon-input-text ng-model="withdrawItem.adminComment" field-name="adminComment" label="" placeholder=""></aon-input-text>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn green" ng-disabled="withdrawAdminForm.$invalid" ng-click="withdrawSubmit()"><spring:message code="cmm.btn.004"/></button>
                                <button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code="cmm.btn.005"/></button>
                            </div>
                        </div>
                    </div>
                </div>
                </form:form>
                <!-- //Withdraw modal -->