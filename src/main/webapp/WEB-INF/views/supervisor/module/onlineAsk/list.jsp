<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<div class="sub_section">
	<h3 class="page_tit"><spring:message code="ask.lbl.001"/></h3>
	<table class="adminTable mgT20">
		<colgroup>
			<col style="width: 10%;">
			<col style="width: 10%;">
			<col style="width: 10%;">
			<col style="width: auto;">
			<col style="width: 10%;">
			<col style="width: 9%;">
			<col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><spring:message code="ask.lbl.002"/></th>
				<th scope="col"><spring:message code="ask.lbl.003"/></th>
				<th scope="col"><spring:message code="ask.lbl.004"/></th>
				<th scope="col"><spring:message code="ask.lbl.005"/></th>
				<th scope="col"><spring:message code="ask.lbl.007"/></th>
				<th scope="col"><spring:message code="ask.lbl.008"/></th>
				<th scope="col"><spring:message code="ask.lbl.009"/></th>
			</tr>
		</thead>
		<tbody>
			<tr ng-repeat="item in list">
				<td>{{item.insertDate | Adate }}</td>
				<td>{{item.userName}}</td>
				<td class="left"><a style="cursor:pointer;" ng-click="modalOpen(item.id)" >{{item.loginid}}</a></td>
				<td class="left"><a style="cursor:pointer;" ng-click="modalOpen(item.id)" >{{item.content}}</a></td>
				<td>{{item.updateDate | Adate}}</td>
				<td ng-show="item.status == 2000">
						{{item.adminNickname}}
				</td>
				<td ng-show="item.status == 1000">
						<button type="button" class="btn blue btn-outline btn-sm" ng-click="modalOpen(item.id)" data-toggle="modal" data-index="${var.index}"><spring:message code="cmm.btn.016"/></button>
				</td>
				<td class="left">{{item.adminComment}}</td>
			</tr>
			<tr class="data_none" ng-show="totalItems == 0">
                <td colspan="7"><spring:message code='ntc.msg.001'/></td>
            </tr>
		</tbody>
	</table>
	<div class="page_box" ng-show="totalItems > 0">
		<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
			ng-model="currentPage" ng-change="pageChanged()" class="pagination" previous-text="&lsaquo;"
			next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page ="10">
		</uib-pagination>
	</div>
	<div class="modal fade confirmL" id="confirmL" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	                <h4 class="modal-title"><spring:message code="ask.lbl.001" /></h4>
	            </div>
	            <form:form name="mForm" method="post" novalidate="true">
	            <div class="modal-body">
					<table class="adminTable">
						<tbody>
							<tr>
								<input type="hidden" name="id" value="{{items.id}}" ng-model="items.id" />
								<td style="width: 15%" class="head"><spring:message code="ask.lbl.002" /></td>
								<td style="width: 85%" class="txtL" name="insertDate">{{items.insertDate | Adate}}</td>
							</tr>
							<tr>
								<td class="head"><spring:message code="ask.lbl.003" /></td>
								<td class="txtL" name="userName">{{items.userName}}</td>
							</tr>
							<tr>
								<td class="head"><spring:message code="ask.lbl.004" /></td>
								<td class="txtL" name="loginid">{{items.loginid}}</td>
							</tr>
							<tr>
								<td class="head"><spring:message code="ask.lbl.005" /></td>
								<td class="txtL" name="content"><span
									ng-bind-html="items.content|nl2br"></span></td>
							</tr>
							<tr>
								<td class="head"><spring:message code="ask.lbl.009" /></td>
								<td class="txtL" name="notes" ng-if="items.status==2000">
								{{items.adminComment}}
								</td>
								<td class="txtL" name="notes" ng-if="items.status!=2000">
									<aon-input-text ng-model="items.adminComment" field-name="adminComment" placeholder="<spring:message code='cmm.msg.003'/>" ng-required="true" alert-message="<spring:message code='cmm.msg.003'/>"></aon-input-text>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				</form:form>
	            <div class="modal-footer">
	                <button type="button" class="btn green" ng-show="items.status==1000" ng-disabled="items.status==2000 || !items.adminComment" ng-click="submit()"><spring:message code='cmm.btn.016'/></button>
	                <button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code='cmm.btn.015'/></button>
	            </div>
	        </div>
	    </div>
	</div>
</div>