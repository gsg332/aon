<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp"%>
<h2 class="page_tit"><spring:message code="cts.lbl.053" /></h2>
<div class="admin_search">
	<form:form name="reportSearchForm" method="post">
		<div class="i_block">
			<span class="ads_date">Date</span>
			<aon-dateterm-picker start-field-name="startDate" start-ng-model="searchItem.startDate" end-field-name="endDate" end-ng-model="searchItem.endDate" ></aon-dateterm-picker>
		</div>
		<select class="form-control" name="searchKey" ng-model="searchItem.searchKey">
			<option value="reportUser"><spring:message code="cts.lbl.046" /></option>
			<option value="adminUser"><spring:message code="cts.lbl.047" /></option>
		</select>
		<input type="text" name="searchText" ng-keypress="checkEnter($event)"  ng-model="searchItem.searchText" class="form-control fm_type200" placeholder="<spring:message code='cmm.msg.001'/>">
		<button type="button" ng-click="searchList()" ng-keypress="checkEnter($event)" class="btn btn btn-primary"> <i class="glyphicon glyphicon-search"></i> <spring:message code='cmm.btn.001' /> </button>
		<button type="button" ng-click="searchReset()" class="btn dark"> <spring:message code='cmm.btn.005' /> </button>
	</form:form>
</div>
<table class="adminTable">
	<colgroup>
		<col style="width: 10%;">
		<col style="width: 15%;">
		<col style="width: 10%;">
		<col style="width: auto;">
		<col style="width: 10%;">
		<col style="width: 10%;">
		<col style="width: 15%;">
	</colgroup>
	<thead>
		<tr>
			<th scope="col"><spring:message code="cts.lbl.043" /></th>
			<th scope="col"><spring:message code="cts.lbl.046" /></th>
			<th scope="col"><spring:message code="cts.lbl.002" /></th>
			<th scope="col"><spring:message code="cts.lbl.044" /></th>
			<th scope="col"><spring:message code="cts.lbl.045" /></th>
			<th scope="col"><spring:message code="cts.lbl.047" /></th>
			<th scope="col"><spring:message code="cts.lbl.048" /></th>
		</tr>
	</thead>
	<tbody>
		<tr class="data_none" ng-show="totalItems == 0">
			<td colspan="7"><spring:message code='cmm.msg.012' /></td>
		</tr>
		<tr ng-repeat="item in list">
			<td>{{item.insertDate | Adate}}</td>
			<td>{{item.reportUser.displayName}}</td>
			<td>{{item.qaId}}</td>
			<td class="left"><a href="#/view/{{item.qaId}}"
				class="text_over" data-toggle="modal">{{item.content}}</a></td>
			<td ng-show="item.confirm">{{item.confirmDate | Adate}}</td>
			<td ng-show="!item.confirm">-</td>
			<td ng-show="item.confirm">{{item.adminUser.displayName}}</td>
			<td ng-show="!item.confirm"><button type="button"
					ng-click="openSingleConfirm(item.id)"
					class="btn blue btn-outline btn-sm" data-toggle="modal">
					<spring:message code="cmm.btn.016" />
				</button></td>
			<td class="left text_over">{{item.adminComment}}</td>
		</tr>
	</tbody>
</table>
<div class="page_box" ng-show="totalItems > 0">
	<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
		ng-model="currentPage" ng-change="pageChanged()" class="pagination"
		previous-text="&lsaquo;" next-text="&rsaquo;" first-text="&laquo;"
		last-text="&raquo;" items-per-page="10"> </uib-pagination>
</div>
<div class="modal fade confirmL" id="confirmL" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">Report</h4>
            </div>
            <form:form name="confirmForm" method="post" >
			<div class="modal-body">
				<table class="adminTable">
					<tbody>
						<tr>
							<input type="hidden" name="id" value="{{items.id}}" ng-model="items.id" />
							<input type="hidden" name="qaId" value="{{items.qaId}}" ng-model="items.qaId" />
							<td style="width: 15%" class="head"><spring:message code="cts.lbl.043" /></td>
							<td style="width: 85%" class="txtL" name="insertDate">{{items.insertDate | Adate}}</td>
						</tr>
						<tr>
							<td class="head"><spring:message code="cts.lbl.046" /></td>
							<td class="txtL" name="userName">{{items.reportUser.displayName}}</td>
						</tr>
						<tr>
							<td class="head"><spring:message code="cts.lbl.044" /></td>
							<td class="txtL" name="content">{{items.content}}</td>
						</tr>
						<tr>
							<td class="head"><spring:message code="cts.lbl.048" /></td>
							<td class="txtL" name="notes">
								<aon-textarea  ng-model="adminComment" field-name="adminComment" placeholder="<spring:message code='cmm.msg.003'/>" ng-required="true" alert-message="<spring:message code='cts.err.002'/>"></aon-textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form:form>
            <div class="modal-footer">
                <button type="button" class="btn green" ng-disabled="!adminComment" ng-click="confirm()"><spring:message code='cmm.btn.016'/></button>
                <button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code='cmm.btn.015'/></button>
            </div>
        </div>
    </div>
</div>
