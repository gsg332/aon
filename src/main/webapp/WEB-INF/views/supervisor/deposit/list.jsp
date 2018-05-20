<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ include file="/WEB-INF/views/myPage/myPoint/pointConfig.jsp" %>
                <h2 class="page_tit"><spring:message code="pnt.lbl.025"/></h2>
                <!-- admin search list -->
                <form:form name="depositSearchForm" method="post">
                <div class="admin_search">
                	<select class="form-control" name="dateSearchKey" ng-model="searchItem.dateSearchKey">
                        <option value="insertDate"><spring:message code="pnt.lbl.026"/></option>
                    </select>
                    <div class="i_block">
                    	<aon-dateterm-picker start-field-name="startDate" start-ng-model="searchItem.startDate"
                    	end-field-name="endDate" end-ng-model="searchItem.endDate" />
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
                    	<col style="width:6%;">
                        <col style="width:9%;">
                        <col style="width:6%;">
                        <col style="width:10%;">
                        <col style="width:10%;">
                        <col style="width:6%">
                        <col style="width:6%">
                        <col style="width:6%">
                        <col style="width:12%;">
                        <col style="width:5%;">
                        <col style="width:6%;">
                        <col style="width:6%;">
                        <col style="width:8%;">
                        <col style="width:auto;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"><spring:message code="pnt.lbl.026"/></th>
                            <th scope="col"><spring:message code="mem.lbl.011"/>(<spring:message code="mem.lbl.008"/>)</th>
                            <th scope="col"><spring:message code="pnt.lbl.039"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.054"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.055"/><br>(<spring:message code="pnt.lbl.056"/>)</th>
                            <th scope="col"><spring:message code="pnt.lbl.057"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.058"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.059"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.060"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.031"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.044"/></th>
                            <th scope="col"><spring:message code="pnt.lbl.053"/></th>
                            <th scope="col"><spring:message code="cmm.lbl.021"/></th>
                            <th scope="col"><spring:message code="cmm.lbl.022"/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- data가 없을 경우 현재 display: none 처리-->
                        <tr class="data_none" ng-show="totalItems == 0">
                            <td colspan="14"><spring:message code="cmm.msg.012"/></td>
                        </tr>
                        <!-- // data가 없을 경우 -->
                        <tr ng-repeat="deposit in list">
                            <td>{{deposit.deposit.insertDate | Adate}}</td>
                            <td>{{deposit.member.firstName}} {{deposit.member.lastName}}({{deposit.member.nickname}})</td>
                            <td class="right">{{deposit.deposit.requestPoint | Apoint}}</td>
                            <td>{{deposit.deposit.payerEmail}}</td>
                            <td>
                            	<span ng-if="deposit.deposit.paymentStatus == 1000"><spring:message code="pnt.lbl.061"/></span>
                            	<span ng-if="deposit.deposit.paymentStatus == 2000"><spring:message code="pnt.lbl.062"/></span>
                            	<span ng-if="deposit.deposit.paymentStatus == 9999"><spring:message code="pnt.lbl.063"/></span>
                            	<br><span ng-if="deposit.deposit.paymentStatus > 1000 && deposit.deposit.paymentStatus != null">({{deposit.deposit.paymentId}})</span>
                            </td>
                            <td class="right">{{deposit.deposit.amount | currency}}</td>
                            <td class="right">{{deposit.deposit.paymentFee | currency}}</td>
                            <td class="right">
                            	<span ng-if="deposit.deposit.amount != null">{{deposit.deposit.amount-deposit.deposit.paymentFee | currency}}</span>
                            </td>
                            <td>{{deposit.deposit.paymentDate}}</td>
                            <td>
                            	<span ng-if="deposit.deposit.status == 1000 && deposit.deposit.paymentStatus == 2000">
                            		<button type="button" class="btn blue btn-outline btn-sm" ng-click="register(deposit.deposit.id)"><spring:message code="cmm.btn.004"/></a>
                            	</span>
                            	<span ng-if="deposit.deposit.status != 1000">
                            		<spring:message code="cmm.lbl.023"/>
                            	</span>
                            </td>
                            <td class="right">{{deposit.deposit.confirmPoint | Apoint}}</td>
                            <td>{{deposit.deposit.confirmDate | Adate}}</td>
                            <td>{{deposit.admin.loginId}}</td>
                            <td>{{deposit.deposit.adminComment}}</td>
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
                <form:form name="depositAdminForm" method="post">
                <input type="hidden" name="id" value="{{item.deposit.id}}"/>
                <input type="hidden" name="confirmPoint" value="{{item.deposit.requestPoint}}"/>
                <div class="modal fade" id="PoinDraw1" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                <h4 class="modal-title"><spring:message code="pnt.lbl.034"/></h4>
                            </div>
                            <div class="modal-body">
                                <div class="modal-body">
                                    <table class="adminTable">
                                        <colgroup>
                                            <col style="width:16%;">
                                            <col style="width:auto;">
                                            <col style="width:15%;">
                                            <col style="width:auto;">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row">Name</th>
                                                <td>{{item.member.firstName}} {{item.member.lastName}}</td>
                                                <th scope="row">Email</th>
                                                <td>{{item.member.loginId}}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">Cellphone</th>
                                                <td>{{item.member.cellPhoneNumber}}</td>
                                                <th scope="row"><spring:message code="pnt.lbl.039"/></th>
                                                <td>{{item.deposit.requestPoint | Apoint}}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <table class="adminTable" style="margin-top:10px">
                                        <colgroup>
                                            <col style="width:16%;">
                                            <col style="width:auto;">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row"><spring:message code="pnt.lbl.035"/></th>
                                                <td class="left">
                                                	{{item.deposit.requestPoint | Apoint}}
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row"><spring:message code="cmm.lbl.022"/></th>
                                                <td class="left">
                                                    <aon-input-text ng-model="item.deposit.adminComment" field-name="adminComment" label="" placeholder=""></aon-input-text>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn green" ng-disabled="depositAdminForm.$invalid" ng-click="submit()"><spring:message code="cmm.btn.004"/></button>
                                <button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code="cmm.btn.005"/></button>
                            </div>
                        </div>
                    </div>
				</div>
				</form:form>
                <!-- //modal layer -->