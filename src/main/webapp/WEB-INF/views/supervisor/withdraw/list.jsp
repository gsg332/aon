<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ include file="/WEB-INF/views/myPage/myPoint/pointConfig.jsp" %>
                <h2 class="page_tit"><spring:message code="pnt.lbl.036"/></h2>
                <!-- admin search list -->
                <form:form name="withdrawSearchForm" method="post">
                <div class="admin_search">
                    <div class="i_block">
                        <select class="form-control" name="dateSearchKey" ng-model="searchItem.dateSearchKey">
	                        <option value="insertDate"><spring:message code="pnt.lbl.026"/></option>
	                        <option value="confirmDate"><spring:message code="pnt.lbl.037"/></option>
	                    </select>
                        <div class="ads_ib">
                            <aon-dateterm-picker start-field-name="startDate" start-ng-model="searchItem.startDate" end-field-name="endDate" end-ng-model="searchItem.endDate" />
                        </div>
                    </div>
                    <div class="i_block">
                        <span class="ads_date asd_l"><spring:message code="pnt.lbl.028"/></span>
                        <input type="text" class="form-control w_auto i_block" name="searchPoint" ng-model="searchItem.searchPoint">
                        <!--<span><spring:message code="cmm.lbl.010"/></span>-->
                    </div>
                    <br>                    
                    <select class="form-control" name="memberSearchKey" ng-model="searchItem.memberSearchKey">
                    	<option value="loginId"><spring:message code="mem.lbl.007"/></option>
                        <option value="nickname"><spring:message code="mem.lbl.008"/></option>
                        <option value="firstName"><spring:message code="mem.lbl.011"/></option>
                    </select>
                    <input type="text" class="form-control fm_type200" name="memberSearchValue" ng-model="searchItem.memberSearchValue">
                    <button type="button" class="btn btn btn-primary" ng-click="search()"><i class="glyphicon glyphicon-search"></i> <spring:message code="cmm.btn.001"/> </button>
                    <button type="button" class="btn dark" ng-click="searchCancel()"><spring:message code="cmm.btn.005"/></button>
                </div>
                </form:form>
                <!-- //admin search list -->
                <!-- list -->
                <table class="adminTable">
                    <colgroup>
                        <col style="width:7%;">
                        <col style="width:10%;">
                        <col style="width:8%;">
                        <col style="width:14%;">
                        <col style="width:10%;">
                        <col style="width:7%;">
                        <col style="width:8%;">
                        <col style="width:8%;">
                        <col style="width:8%;">
                        <col style="width:auto;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"><spring:message code="pnt.lbl.026"/></th>
                            <th scope="col"><spring:message code="mem.lbl.011"/>(<spring:message code="mem.lbl.008"/>)</th>
                            <th scope="col"><spring:message code="pnt.lbl.039"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.054"/></th>
                            <th scope="col"><spring:message code="cmm.lbl.021"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.037"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.042"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.052"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.058"/></th>
                            <th scope="col"><spring:message code="cmm.lbl.022"/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- data가 없을 경우 현재 display: none 처리-->
                        <tr class="data_none" ng-show="totalItems == 0">
                            <td colspan="10"><spring:message code="cmm.msg.012"/></td>
                        </tr>
                        <!-- // data가 없을 경우 -->
                        <tr ng-repeat="withdraw in list">
                            <td>{{withdraw.withdraw.insertDate | Adate}}</td>
                            <td>{{withdraw.member.firstName}} {{withdraw.member.lastName}}({{withdraw.member.nickname}})</td>
                            <td class="right">{{withdraw.withdraw.requestPoint | Apoint}}</td>
                            <td>{{withdraw.withdraw.paypalAccount}}</td>
                            <td ng-if="withdraw.withdraw.status == 1000">
                                <button type="button" class="btn blue btn-outline btn-sm" ng-click="register(withdraw.withdraw.id)"><spring:message code="cmm.btn.004"/></a>
                            </td>
                            <td ng-if="withdraw.withdraw.status != 1000">
                                {{withdraw.admin.loginId}}
                            </td>                          
                            <td>{{withdraw.withdraw.confirmDate | Adate}}</td>
                            <td class="right">{{withdraw.withdraw.confirmPoint | Apoint}}</td>
                            <td class="right">{{withdraw.withdraw.amount | currency}}</td>
                            <td class="right">{{withdraw.withdraw.fee | currency}}</td>
                            <td>{{withdraw.withdraw.adminComment}}</td>
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
                
                <!-- modal layer -->
                <form:form name="withdrawAdminForm" method="post" novalidate="true">
                <input type="hidden" name="id" value="{{item.withdraw.id}}"/>
                <input type="hidden" name="confirmPoint" value="{{item.withdraw.confirmPoint}}"/>
                <div class="modal fade" id="PoinDraw2" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                <h4 class="modal-title"><spring:message code="pnt.lbl.043"/></h4>
                            </div>
                            <div class="modal-body">
                                <div class="modal-body">
                                    <table class="adminTable">
                                        <colgroup>
                                            <col style="width:20%;">
                                            <col style="width:auto;">
                                            <col style="width:20%;">
                                            <col style="width:30%;">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row">Login ID</th>
                                                <td>{{item.member.loginId}}</td>
                                                <th scope="row"><spring:message code="mem.lbl.011"/>(<spring:message code="mem.lbl.008"/>)</th>
                                                <td>{{item.member.firstName}}{{item.member.lastName}}({{item.member.nickname}})</td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><spring:message code="pnt.lbl.054"/></th>
                                                <td>{{item.withdraw.paypalAccount}}</td>
                                                <th scope="row"><spring:message code="cmm.lbl.019"/></th>
                                                <td>{{item.member.cellPhoneNumber}}</td>
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
                                                	{{item.withdraw.confirmPoint | Apoint}}
                                                	<!--<aon-input-point ng-model="item.withdraw.confirmPoint" field-name="confirmPoint" ng-required="true" minPoint="1" termPoint="1" ratio="<%=getRatioDollarToPoint()%>" />-->
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><spring:message code="pnt.lbl.052"/></th>
                                                <td class="left" id="give">
                                                	{{(item.withdraw.requestPoint / <%=getRatioDollarToPoint()%>) | currency}} -
                                                	{{(item.withdraw.requestPoint / <%=getRatioDollarToPoint()%>)*<%=getFees()%> | currency}} =
                                                	{{(item.withdraw.requestPoint / <%=getRatioDollarToPoint()%>) - ((item.withdraw.requestPoint / <%=getRatioDollarToPoint()%>)*<%=getFees()%>) | currency}}
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><spring:message code="pnt.lbl.037"/></th>
                                                <td class="left">
                                                    <aon-date-picker ng-model="item.withdraw.confirmDate" field-name="confirmDate" date="{{item.withdraw.confirmDate}}" ng-required="true" alert-message="<spring:message code="pnt.msg.021"/>"></aon-date-picker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><spring:message code="cmm.lbl.022"/></th>
                                                <td class="left">
                                                    <aon-input-text ng-model="item.withdraw.adminComment" field-name="adminComment" label="" placeholder=""></aon-input-text>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>				
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn green" ng-disabled="withdrawAdminForm.$invalid" ng-click="submit()"><spring:message code="cmm.btn.004"/></button>
                                <button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code="cmm.btn.005"/></button>
                            </div>
                        </div>
                    </div>
                </div>
                </form:form>
                <!-- //modal layer -->