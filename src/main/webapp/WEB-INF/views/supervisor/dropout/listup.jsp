<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
				<h2 class="page_tit"><spring:message code='mem.adm.lbl.001'/></h2>
					<!-- admin search -->
	               	<div class="admin_search">
	               		<form:form name="mForm" method="post">
		                    <div class="i_block">
			                    <span class="ads_date"><spring:message code='mem.adm.lbl.001'/></span>
	                            <aon-dateterm-picker start-field-name="startDate" start-ng-model="searchItem.startDate"  end-field-name="endDate" end-ng-model="searchItem.endDate"/>
		                    </div>
		                    <br>
		                    <select class="form-control" name="inputSearchKey" ng-model="searchItem.inputSearchKey">
		                        <option value="all" selected><spring:message code='cmm.menu.009'/></option>
		                        <option value="firstName" ><spring:message code='mem.lbl.043'/></option>
		                        <option value="nickname"><spring:message code='mem.lbl.008'/></option>
		                    </select>
		                    <input type="text" class="form-control fm_type200" placeholder="<spring:message code='cmm.msg.001'/>" name="inputSearchValue" ng-model="searchItem.inputSearchValue" ng-keypress="enterSearch($event)">
		                    <!--
		                    <aon-input-text field-name="inputSearchValue" placeholder="<spring:message code='cmm.msg.001'/>" ng-model="inputSearchValue" ng-keypress="enterSearch($event)"></aon-input-text>
		                    -->
		                    <div class="btn btn btn-primary" ng-click="search()"><i class="glyphicon glyphicon-search"></i> <spring:message code='cmm.btn.001'/></div>
		                    <button type="button" class="btn dark" ng-click="searchCancel()"><spring:message code='cmm.btn.005'/></button>
						</form:form>
	                </div>
			        <!-- //admin search -->
			        <table class="adminTable">
                    <caption><spring:message code='mem.adm.lbl.003'/></caption>
                    <colgroup>
                        <col style="width:20%;">
                        <col style="width:25%;">
                        <col style="width:20%;">
                        <col style="width:auto;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"><spring:message code='mem.adm.lbl.004'/></th>
                            <th scope="col"><spring:message code='mem.lbl.043'/>(<spring:message code='mem.lbl.008'/>)</th>
                            <th scope="col"><spring:message code='pnt.lbl.001'/></th>
                            <th scope="col"><spring:message code='mem.adm.lbl.005'/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- data가 없을 경우 현재 display: none 처리-->
                        <tr class="data_none" ng-show="totalItems == 0">
                            <td colspan="4"><spring:message code='cmm.msg.012'/></td>
                        </tr>
                        <!-- // data가 없을 경우 -->
                        <tr ng-repeat="member in list" ng-click="view($index)" data-toggle="modal" class="over">
                        	<td class="left">{{member.dropoutDate | date : Adate}}</td>
							<td class="left">{{member.firstName}} {{member.lastName}}({{member.nickname}})</td>
							<td class="right">{{member.cyberAccount.balance | Apoint}}</td>
							<td class="left">{{member.dropoutReason}}</td>
						</tr>
					</tbody>
                </table>
                <!-- //list -->
                <!-- pagination -->
                <div class="page_box" ng-show="totalItems > 0">
					<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
						ng-model="currentPage" ng-change="pageChanged()" class="pagination" previous-text="&lsaquo;"
						next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page ="10">
					</uib-pagination>
				</div>
                <!-- //pagination -->
                <!-- cancle detail modal -->
                <div class="modal fade" id="WithdrawalReason" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                <h4 class="modal-title"><spring:message code='mem.adm.lbl.005'/></h4>
                            </div>
                            <div class="modal-body">
                                <table class="adminTable">
                                    <caption><spring:message code='mem.adm.lbl.020'/></caption>
                                    <colgroup>
                                        <col style="width:16%;">
                                        <col style="width:auto;">
                                        <col style="width:15%;">
                                        <col style="width:18%;">
                                        <col style="width:15%;">
                                        <col style="width:18%;">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th scope="row"><spring:message code='mem.lbl.043'/></th>
                                            <td>{{member.firstName}} {{member.lastName}}</td>
                                            <th scope="row"><spring:message code='mem.lbl.007'/></th>
                                            <td>{{member.loginId}}</td>
                                            <th scope="row"><spring:message code='mem.lbl.008'/></th>
                                            <td>{{member.nickname}}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><spring:message code='pnt.lbl.003'/></th>
                                            <td class="right"><span class="blue">{{member.cyberAccount.depositSum | Apoint}}</span></td>
                                            <th scope="row"><spring:message code='pnt.lbl.002'/></th>
                                            <td class="right"><span class="red">{{member.cyberAccount.withdrawSum | Apoint}}</span></td>
                                            <th scope="row"><spring:message code='pnt.lbl.001'/></th>
                                            <td class="right">{{member.cyberAccount.balance | Apoint}}</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="adminTable" style="margin-top:10px">
                                    <caption><spring:message code='mem.adm.lbl.006'/></caption>
                                    <colgroup>
                                        <col style="width:16%;">
                                        <col style="width:auto;">
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th scope="row"><spring:message code='mem.adm.lbl.007'/></th>
                                            <td class="left">{{member.dropoutDate | date : Adate}}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><spring:message code='mem.adm.lbl.008'/></th>
                                            <td class="left">{{member.dropoutReason}}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn green" data-dismiss="modal" aria-hidden="true"><spring:message code='cmm.btn.016'/></button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //cancle detail modal -->
	