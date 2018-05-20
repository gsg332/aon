<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">
(function() {
	"use strict"
	 angular.module('mainApp', [ 'ui.bootstrap' ])
	
})();	
</script>
<div role="main">
	<div class="container" ng-app="mainApp" ng-controller="MemberCtl">
		
		<table class="table table table-hover">
			<colgroup>
				<col width="8%" />
				<col width="*" />
				<col width="15%" />
				<col width="5%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<td><spring:message code='cmm.lbl.017'/></td>
					<td><spring:message code='cmm.lbl.018'/></td>
					<td><spring:message code='mem.lbl.011'/></td>
					<td><spring:message code='mem.lbl.013'/></td>
					<td><spring:message code='cmm.lbl.005'/></td>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="member in list">
					<td>{{member.id}}</td>
					<td><a href='<c:url value="/module/member/view.aon?id={{member.id}}"/>'>{{member.email}}</a></td>
					<td>{{member.firstName}} {{member.lastName}}</td>
					<td>{{member.gender}}</td>
					<td>{{member.insertDate | date : Adate }}</td> <!-- 참고 angularjs date filter -->
				</tr>
			</tbody>
		</table>
		
		<div class="row">
		<div class="col-md-12">
			<spring:message code='cmm.lbl.024'/> : <input type="text" name="keyWord" ng-model="keyWord" /><button type="button" ng-click="search()" class="btn btn-default"><spring:message code='cmm.btn.001'/></button>
		</div>
		</div>
		<div class="row">
			<div class="col-md-12" style="text-align: center;">
				<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
					ng-model="currentPage" ng-change="pageChanged()" class="pagination-lg" previous-text="&lsaquo;"
					next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page ="10">
				</uib-pagination>
			</div>
			
		</div>
	</div>
</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
