<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp"%>
<div class="container">
	<div class="page-header">
		<h3>
			<spring:message code="cts.lbl.053" />
		</h3>
	</div>
	<div class="info_box">
		<div class="info_view">
			<div class="info_top i_q">
				<div class="info_tbox">
					<strong class="info_tit">
						<span class="qNo">No.{{item.id}}</span> <span ng-bind-html="item.title"></span>
					</strong>
					<ul class="info_etc info_etc_b block">
						<li ng-repeat="categ in item.categories[0].path" ng-if="!$first && categ != ''"><span>{{categ | ctgrLang}}</span></li>
						<li ng-if="item.categories[0].tag != ''"><span>{{item.categories[0].tag | ctgrLang}}</span></li>
					</ul>
					<ul class="info_etc">
						<li><span class="name black">{{item.registerUser.displayName}}</span></li>
						<li><span>{{item.point | Apoint}}</span></li>
						<li><span class="ie_date">{{item.expireDate | Adate }}</span></li>
						<li><span class="status adopt" ng-if="item.choose"><spring:message
									code='cts.lbl.004' /></span> <span class="status noadopt"
							ng-if="!item.choose"><spring:message code='cts.lbl.005' /></span>
						</li>
						<li ng-if="item.status == 2000"><span class="status done"><spring:message
									code='cts.lbl.020' /></span></li>
						<li ng-if="item.status == 1000"><span class="status done"><spring:message
									code='cts.lbl.021' /></span></li>
						<li ng-if="item.status == 3000"><span class="status done"><spring:message
									code='cts.lbl.022' /></span></li>
						<li ng-if="item.status == 4000"><span class="status done"><spring:message
									code='cts.lbl.023' /></span></li>
						<li ng-if="item.status == 4100"><span class="status done"><spring:message
									code='cts.lbl.024' /></span></li>
						<li ng-if="item.status == 4200"><span class="status done"><spring:message code='cts.lbl.054'/></span></li>
					</ul>
				</div>
			</div>
			<div class="info_body" ng-bind-html="item.content"></div>
			<div class="info_bottom">
				<div class="info_file" ng-show="item.attachments.length > 0">
					<strong class="if_tit"><spring:message code="cmm.lbl.007" /></strong>
					<ul class="if_list" ng-repeat="attach in item.attachments">
						<li>
							<p>
								<a
									href="<c:url value="/supervisor/module/contest/download.aon?id="/>{{attach.id}}">{{attach.filename}}</a>
								(${(attach.size/1024)+(1-((attach.size/1024)%1)%1)} KB)
							</p>
						</li>
					</ul>
				</div>
<!-- 				<div class="shareSNS"> -->
<%-- 					<span class="ss_tit"><spring:message code='cmm.lbl.008' /></span> --%>
<%-- 					<a href="#" class="ss_fb ss_icon">facebook <spring:message --%>
<%-- 							code='cmm.btn.021' /></a> <a href="#" class="ss_tw ss_icon">twitter --%>
<%-- 						<spring:message code='cmm.btn.021' /> --%>
<!-- 					</a> -->
<!-- 				</div> -->
			</div>
		</div>
		<div class="row">
			<div ng-show="{{item.status }} == 1000">
				<div class="warnBox">
					<span id="warnContent"> <spring:message code="cts.msg.021" />
					</span>
				</div>
				<div class="btnArea">
					<button ng-click="goList()" type="button" class="btn btn-primary">
						<spring:message code="cmm.btn.012" />
					</button>
				</div>
			</div>
			<div ng-show="warnnig">
				<div class="warnBox">
					<span id="warnContent"> <spring:message code="cts.msg.021" />
					</span>
				</div>
				<div class="btnArea">
					<button ng-click="block()" type="button" class="btn btn-primary">
						<spring:message code="cmm.btn.014" />
					</button>
					<button ng-click="warnnig=false; contestBtn=true" type="button"
						class="btn btn-primary">
						<spring:message code="cmm.btn.015" />
					</button>
				</div>
			</div>
			<div
				ng-show="contestBtn && {{item.status }} != 1000 && {{item.status }} != 4000"
				class="btnArea mg0">
				<button ng-click="goList()" type="button" class="btn btn-primary">
					<spring:message code="cmm.btn.012" />
				</button>
				<button type="button" ng-click="warnnig = true; contestBtn=false"
					class="btn btn-primary">
					<spring:message code="cmm.btn.013" />
				</button>
				<button type="button" ng-click="reasonView=true; contestBtn=false"
					ng-show="{{item.status}} == 4100" class="btn btn-primary">
					<spring:message code="cts.lbl.042" />
				</button>
			</div>
			<div ng-show="{{item.status}} == 4000">
				<div class="warnBox">
					<span ng-bind-html="item.cancelReason | nl2br"></span>
				</div>
				<div class="btnArea">
					<button ng-click="goList()" type="button" class="btn btn-primary">
						<spring:message code="cmm.btn.012" />
					</button>
				</div>
			</div>
			<div ng-show="reasonView">
				<div class="warnBox">
					<span ng-bind-html="item.cancelReason | nl2br"></span>
				</div>
				<div class="btnArea">
					<button ng-click="permit()" type="button" class="btn btn-primary">
						<spring:message code="cmm.btn.016" />
					</button>
					<button ng-click="reasonView=false; contestBtn=true" type="button"
						class="btn btn-primary">
						<spring:message code="cmm.btn.015" />
					</button>
				</div>
			</div>
		</div>
	</div>
	<div class="page-header">
		<h3>Report</h3>
	</div>
	<div ng-repeat="report in reportList">
		<form:form method="post" name="confirmForm{{report.id}}">
			<table class="adminTable">
				<tbody>
					<tr>
						<input type="hidden" name="id" value="{{report.id}}"
							ng-model="items.id" />
						<input type="hidden" name="qaId" value="{{report.qaId}}"
							ng-model="items.qaId" />
						<td style="width: 15%" class="head"><spring:message code="cts.lbl.043"/></td>
						<td style="width: 85%" class="txtL left" name="insertDate">{{report.insertDate
							| Adate}}</td>
					</tr>
					<tr>
						<td class="head"><spring:message code="cts.lbl.046" /></td>
						<td class="txtL left" name="userName">{{report.reportUser.displayName}}</td>
					</tr>
					<tr>
						<td class="head"><spring:message code="cts.lbl.044"/></td>
						<td class="txtL left" name="content"><span
							ng-bind-html="report.content | nl2br"></span></td>
					</tr>
					<tr ng-if="report.confirm">
						<td class="head"><spring:message code="cts.lbl.047" /></td>
						<td class="txtL left" name="adminUser">{{report.adminUser.displayName}}</td>
					</tr>
					<tr ng-if="report.confirm">
						<td class="head"><spring:message code="cts.lbl.048" /></td>
						<td class="txtL" ng-if="report.adminComment == null"
							name="noComment">-</td>
						<td class="txtL left" ng-if="report.adminComment != null"
							name="adminComment"><span
							ng-bind-html="report.adminComment | nl2br"></span></td>
					</tr>
					<tr ng-if="!report.confirm">
						<td class="head"><spring:message code="cts.lbl.048" /></td>
						<td class="txtL left" name="notes">
							<aon-textarea  ng-model="adminComment" field-name="adminComment" placeholder="<spring:message code='cmm.msg.003'/>" ng-required="true" alert-message="<spring:message code='cts.err.002'/>"></aon-textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</form:form>
		<div class="btnArea">
			<button type="button" class="btn btn-primary"
				ng-click="confirm(report.id)" ng-disabled="confirmForm{{report.id}}.$invalid" ng-if="!report.confirm">
				<spring:message code='cmm.btn.016' />
			</button>
		</div>
	</div>
</div>
