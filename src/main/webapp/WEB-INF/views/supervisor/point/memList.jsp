<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
                <h2 class="page_tit"><spring:message code='mem.adm.lbl.009'/></h2>
                <!-- admin search -->
               	<div class="admin_search">
               		<form:form name="mForm" method="post">
	                    <select class="form-control" name="dateSearchKey" ng-model="dateSearchKey">
	                        <option value="insertDate"><spring:message code='mem.adm.lbl.010'/></option>
	                        <option value="dropoutDate"><spring:message code='mem.adm.lbl.001'/></option>
	                    </select>
	                    <div class="i_block">
                            <aon-dateterm-picker start-field-name="startDate" end-field-name="endDate"></aon-dateterm-picker>
	                    </div>
	                    <br>
	                    <select class="form-control" name="statusSearchKey" ng-model="statusSearchKey">
	                        <option value="activeMember" selected><spring:message code='mem.adm.lbl.011'/></option>
	                        <option value="dropoutMember"><spring:message code='mem.adm.lbl.012'/></option>
	                    </select>
	                    <select class="form-control" name="inputSearchKey" ng-model="inputSearchKey">
	                        <option value="loginId" selected><spring:message code='mem.lbl.007'/></option>
	                        <option value="firstName" ><spring:message code='mem.lbl.011'/></option>
	                        <option value="nickname"><spring:message code='mem.lbl.008'/></option>
	                    </select>
	                    <input type="text" class="form-control fm_type200" placeholder="<spring:message code='cmm.msg.001'/>" name="inputSearchValue" ng-model="inputSearchValue" ng-keypress="enterSearch($event)">
	                    <div class="btn btn btn-primary" ng-click="search()"><i class="glyphicon glyphicon-search"></i> <spring:message code='cmm.btn.001'/></div>
	                    <button type="button" class="btn dark" ng-click="reset()"><spring:message code='cmm.btn.005'/></button>
					</form:form>
                </div>
		        <!-- //admin search -->
                <!-- list -->
                <table class="adminTable">
                    <caption><spring:message code='mem.adm.lbl.003'/></caption>
                    <colgroup>
                        <col style="width:17%;">
                        <col style="width:17%;">
                        <col style="width:16;">
                        <col style="width:auto;">
                        <col style="width:13%;">
                        <col style="width:10%;">
                        <col style="width:10%;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"><spring:message code='mem.lbl.007'/></th>
                            <th scope="col"><spring:message code='mem.lbl.043'/></th>
                            <th scope="col"><spring:message code='mem.lbl.008'/></th>
                            <th scope="col"><spring:message code='cmm.lbl.014'/></th>
                            <th scope="col"><spring:message code='mem.adm.lbl.013'/></th>
                            <th scope="col"><spring:message code='mem.adm.lbl.014'/></th>
                            <th scope="col"><spring:message code='mem.adm.lbl.015'/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- data가 없을 경우 현재 display: none 처리-->
                        <tr class="data_none" ng-show="totalItems == 0">
                            <td colspan="7"><spring:message code='cmm.msg.012'/></td>
                        </tr>
                        <!-- // data가 없을 경우 -->
                        <tr ng-repeat="member in list" class="over">
	                        <td class="left">{{member.loginId}}</td>
                            <td class="left">{{member.lastName}} {{member.firstName}}</td>
                            <td class="left">{{member.nickname}}</td>
                            <td class="right">
                            	<a href="#/point/{{member.id}}">{{member.cyberAccount.balance | Apoint}}</a>
                            </td>
                            <td>{{member.lastAccessDate | date : Adate}}</td>
                            <td>{{member.questionCnt}}</td>
                            <td>{{member.answerCnt}}</td>
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
