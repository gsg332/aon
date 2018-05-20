<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp"%>
<h2 class="page_tit"><spring:message code="cts.lbl.052" /></h2>
<div class="admin_search">
	<form:form name="ContestAnswerListForm" id="ContestAnswerListForm" method="post">
		<div class="i_block">
			<span class="ads_date">Date</span>
			<aon-dateterm-picker start-field-name="startDate" start-ng-model="searchItem.startDate" end-field-name="endDate" end-ng-model="searchItem.endDate" ></aon-dateterm-picker>
		</div>
		<select class="form-control" name="searchKey" ng-model="searchItem.searchKey">
			<option value="title" selected="selected"><spring:message code='cmm.lbl.002' /></option>
			<option value="nickname"><spring:message code='cts.lbl.003' /></option>
			<option value="id"><spring:message code='cts.lbl.002' /></option>
		</select>
		<input type="text" name="searchText" ng-model="searchItem.searchText" ng-keypress="checkEnter($event)" class="form-control fm_type200" placeholder="<spring:message code='cmm.msg.001'/>">
		<a href="javascript:;" ng-click="searchList()" class="btn btn btn-primary"><i class="glyphicon glyphicon-search"></i> <spring:message code='cmm.btn.001' /> </a>
		<button type="button" class="btn dark" ng-click="searchReset()"><spring:message code='cmm.btn.005' /></button>
	</form:form>
</div>
<table class="adminTable mgT20">
	<colgroup>
		<col style="width: 20%;">
		<col style="width: 15%;">
		<col style="width: auto;">
		<col style="width: 12%;">
	</colgroup>
	<thead>
		<tr>
			<th scope="col"><spring:message code='cts.lbl.015' /></th>
			<th scope="col"><spring:message code='cts.lbl.003' /></th>
			<th scope="col"><spring:message code='cts.lbl.006' /></th>
			<th scope="col"><spring:message code='cts.lbl.040' /></th>
		</tr>
	</thead>
	<tbody>
		<tr class="data_none" ng-show="totalItems == 0">
			<td colspan="4"><spring:message code='cmm.msg.012' /></td>
		</tr>
		<tr ng-repeat="item in list">
			<td class="left">{{item.loginId}}</td>
			<td class="left">{{item.nickName}}</td>
			<td class="left"><a class="text_over"
				href="#/qaview/{{item.parentId}}" ng-bind-html="item.title"></a></td>
			<td>{{item.insertDate | Adate}}</td>
		</tr>
	</tbody>
</table>
<!--//페이지번호-->
<div class="page_box" ng-show="totalItems > 0">
	<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
		ng-model="currentPage" ng-change="pageChanged()" class="pagination"
		previous-text="&lsaquo;" next-text="&rsaquo;" first-text="&laquo;"
		last-text="&raquo;" items-per-page="10"> </uib-pagination>
</div>
<!--페이지번호//-->