<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<h2 class="page_tit"><spring:message code='sys.lbl.024'/></h2>
                <!-- list -->
                <table class="adminTable">
                    <caption><spring:message code='sys.lbl.025'/></caption>
                    <colgroup>
                        <col style="width:70px;">
                        <col style="width:auto;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.027'/></th>
                            <th scope="col"><spring:message code='sys.lbl.028'/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="config in list" ng-if="$index >= ((currentPage - 1) * 10) && $index < (currentPage * 10)">
                            <td>{{totalItems - $index}}</td>
                            <td class="left long">
                                <a href='<c:url value="#/edit/{{config.name}}"/>'>{{config.name}}</a>
                            </td>
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
