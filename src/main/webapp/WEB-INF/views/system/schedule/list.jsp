<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<h2 class="page_tit"><spring:message code='sys.lbl.001'/></h2>
                <!-- admin search list -->
                <div class="admin_search">
                    <input type="text" class="form-control fm_type300" placeholder="<spring:message code='cmm.msg.001'/>" name="searchValue" ng-model="searchValue" ng-keypress="enterSearch($event)">
                    <button class="btn btn btn-primary" ng-click="search()"><i class="glyphicon glyphicon-search"></i> <spring:message code='cmm.btn.001'/> </button>
                    <button type="button" class="btn dark" ng-click="cancel()"><spring:message code='cmm.btn.005'/></button>
                </div>
                <!-- //admin search list -->
                <!-- list -->
                <table class="adminTable">
                    <caption><spring:message code='sys.lbl.002'/></caption>
                    <colgroup>
                        <col style="width:75px;">
                        <col style="width:auto;">
                        <col style="width:8%;">
                        <col style="width:8%;">
                        <col style="width:8%;">
                        <col style="width:14%;">
                        <col style="width:14%;">
                        <col style="width:8%;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.005'/></th>
                            <th scope="col"><spring:message code='sys.lbl.006'/></th>
                            <th scope="col"><spring:message code='sys.lbl.007'/></th>
                            <th scope="col"><spring:message code='sys.lbl.008'/></th>
                            <th scope="col"><spring:message code='sys.lbl.009'/></th>
                            <th scope="col"><spring:message code='sys.lbl.010'/></th>
                            <th scope="col"><spring:message code='sys.lbl.011'/></th>
                            <th scope="col"><spring:message code='sys.lbl.012'/></th>
                        </tr>
                    </thead>
                    <tbody>
                    	<!-- data가 없을 경우 현재 display: none 처리-->
                        <tr class="data_none" ng-show="totalItems == 0">
                            <td colspan="8"><spring:message code='sys.msg.001'/></td>
                        </tr>
                        <!-- // data가 없을 경우 -->
                        <tr ng-repeat="schedule in list">
                            <td>{{schedule.id}}</td>
                            <td class="left long">
                                <a href='<c:url value="#/edit/{{schedule.id}}"/>'>{{schedule.className}}</a>
                            </td>
                            <td>
                            	<span ng-if="schedule.result == 0"><spring:message code='sys.lbl.013'/></span>
								<span ng-if="schedule.result == 1000"><spring:message code='sys.lbl.014'/></span>
                                <span ng-if="schedule.result == 2000"><spring:message code='sys.lbl.015'/></span>
                                <span ng-if="schedule.result == 3000"><spring:message code='sys.lbl.016'/></span>
                            </td>
                            <td>
                            	<span ng-if="schedule.paused"><spring:message code='sys.lbl.017'/></span>
                            </td>
                            <td>{{schedule.param}}</td>
                            <td>{{schedule.runDate | AdateTime }}</td>
                            <td>{{schedule.cron}}</td>
                            <td>{{schedule.interval}}</td>
                        </tr>
	                        
                    </tbody>
                </table>
                <!-- //list -->
                <div class="fr_box">
                    <a href='<c:url value="#/write"/>' id="btnSchedule" type="button" class="btn btn-primary"><spring:message code='cmm.btn.047'/></a>
                </div>
                <!-- pagination -->
                <div class="page_box" ng-show="totalItems > 0">
					<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
						ng-model="currentPage" ng-change="pageChanged()" class="pagination" previous-text="&lsaquo;"
						next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page="10">
					</uib-pagination>
				</div>
                <!-- //pagination -->
