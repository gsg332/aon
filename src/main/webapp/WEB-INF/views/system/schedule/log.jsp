<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<h2 class="page_tit"><spring:message code='sys.lbl.020'/></h2>
                <!-- admin search list -->
                <div class="admin_search">
               	<form:form>
                	<div class="i_block">
						<span class="ads_date">Date</span>
						<aon-dateterm-picker start-field-name="startDate" start-ng-model="searchItem.startDate" end-field-name="endDate" end-ng-model="searchItem.endDate" ></aon-dateterm-picker>
					</div>
                    <input type="text" class="form-control fm_type300" placeholder="<spring:message code='cmm.msg.001'/>" name="searchValue" ng-model="searchItem.searchValue" ng-keypress="enterSearch($event)">
                    <button type="button" class="btn btn btn-primary" ng-click="search()"><i class="glyphicon glyphicon-search"></i> <spring:message code='cmm.btn.001'/> </button>
                    <button type="button" class="btn dark" ng-click="cancel()"><spring:message code='cmm.btn.005'/></button>
				</form:form>
                </div>
                <!-- //admin search list -->
                <!-- list -->
                <table class="adminTable">
                    <caption><spring:message code='sys.lbl.021'/></caption>
                    <colgroup>
                        <col style="width:75px;">
                        <col style="width:auto;">
                        <col style="width:14%;">
                        <col style="width:8%;">
                        <col style="width:8%;">
                        <col style="width:24%;">
                        <col style="width:14%;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.022'/></th>
                            <th scope="col"><spring:message code='sys.lbl.006'/></th>
                            <th scope="col"><spring:message code='sys.lbl.023'/></th>
                            <th scope="col"><spring:message code='sys.lbl.009'/></th>
                            <th scope="col"><spring:message code='sys.lbl.007'/></th>
                            <th scope="col"><spring:message code='sys.lbl.018'/></th>
                            <th scope="col"><spring:message code='sys.lbl.019'/></th>
                        </tr>
                    </thead>
                    <tbody>
                    	<!-- data가 없을 경우 현재 display: none 처리-->
                        <tr class="data_none" ng-show="totalItems == 0">
                            <td colspan="7"><spring:message code='sys.msg.001'/></td>
                        </tr>
                        <!-- // data가 없을 경우 -->
                        <tr ng-repeat="schedule in list">
                            <td>{{schedule.id}}</td>
                            <td class="left long text_over">
                                {{schedule.name}}
                            </td>
                            <td>{{schedule.insertDate | AdateTime }}</td>
                            <td>{{schedule.param}}</td>
                            <td>
                            	<span ng-if="schedule.result"><spring:message code='sys.lbl.015'/></span>
                            	<span ng-if="!schedule.result"><spring:message code='sys.lbl.016'/></span>
                            </td>
                            <td class="left relative"><p class="hover_over">{{schedule.detail}}</p></td>
                            <td>{{schedule.ipAddress}}</td>
                        </tr>
	                        
                    </tbody>
                </table>
                <!-- //list -->
                <!-- pagination -->
                <div class="page_box" ng-show="totalItems > 0">
					<uib-pagination boundary-links="true" total-items="totalItems" max-size="10"
						ng-model="currentPage" ng-change="pageChanged()" class="pagination" previous-text="&lsaquo;"
						next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page="10">
					</uib-pagination>
				</div>
                <!-- //pagination -->
