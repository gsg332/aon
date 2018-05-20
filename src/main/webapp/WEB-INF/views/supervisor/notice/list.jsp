<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<h2 class="page_tit"><spring:message code='cmm.menu.007'/></h2>
                <!-- admin search list -->
                <div class="admin_search">
                	<select class="form-control w_auto" ng-model="searchKey">
                        <option value="title" selected><spring:message code='cmm.lbl.002'/></option>
                        <option value="content"><spring:message code='cmm.lbl.003'/></option>
                        <option value="all"><spring:message code='cmm.lbl.002'/>+<spring:message code='cmm.lbl.003'/></option>
                    </select>
                    <input type="text" class="form-control fm_type300" placeholder="<spring:message code='cmm.msg.001'/>" name="searchValue" ng-model="searchValue" ng-keypress="enterSearch($event)">
                    <button class="btn btn btn-primary" ng-click="search()"><i class="glyphicon glyphicon-search"></i> <spring:message code='cmm.btn.001'/> </button>
                    <button type="button" class="btn dark" ng-click="cancel()"><spring:message code='cmm.btn.005'/></button>
                </div>
                <!-- //admin search list -->
                <!-- list -->
                <table class="adminTable">
                    <caption><spring:message code='ntc.lbl.001'/></caption>
                    <colgroup>
                        <col style="width:70px;">
                        <col style="width:auto;">
                        <col style="width:14%;">
                        <col style="width:8%;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"><spring:message code='cmm.lbl.001'/></th>
                            <th scope="col"><spring:message code='cmm.lbl.002'/></th>
                            <th scope="col"><spring:message code='cmm.lbl.005'/></th>
                            <th scope="col"><spring:message code='cmm.lbl.006'/></th>
                        </tr>
                    </thead>
                    <tbody>
                    	<!-- data가 없을 경우 현재 display: none 처리-->
                        <tr class="data_none" ng-show="totalItems == 0">
                            <td colspan="4"><spring:message code='ntc.msg.001'/></td>
                        </tr>
                        <!-- // data가 없을 경우 -->
                        <tr ng-repeat="notice in list">
                            <td>{{notice.id}}</td>
                            <td class="left long">
                                <a href='<c:url value="#/edit/{{notice.id}}"/>' ng-bind-html="notice.title"></a>
                            </td>
                            <td>{{notice.insertDate | Adate }}</td>
                            <td>{{notice.readCount}}</td>
                        </tr>
	                        
                    </tbody>
                </table>
                <!-- //list -->
                <div class="fr_box">
                    <a href='<c:url value="#/write"/>' id="btnNotice" type="button" class="btn btn-primary"><spring:message code='cmm.btn.047'/></a>
                </div>
                <!-- pagination -->
                <div class="page_box" ng-show="totalItems > 0">
					<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
						ng-model="currentPage" ng-change="pageChanged()" class="pagination" previous-text="&lsaquo;"
						next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page ="10">
					</uib-pagination>
				</div>
                <!-- //pagination -->
