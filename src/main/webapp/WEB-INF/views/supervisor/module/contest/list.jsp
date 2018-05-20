<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp"%>
<h2 class="page_tit">
	<spring:message code="cts.lbl.051" />
</h2>
<div class="admin_search">
	<form:form name="contestListForm" id="contestListForm" method="post">
		<div class="i_block">
			<span class="ads_date">Date</span>
			<aon-dateterm-picker start-field-name="startDate" start-ng-model="searchItem.startDate" end-field-name="endDate" end-ng-model="searchItem.endDate" ></aon-dateterm-picker>
		</div>
		<div class="i_block">
            <span class="ads_date asd_l"><spring:message code="cts.lbl.008"/></span>
            <input type="text"  class="form-control w_auto i_block" name="searchPoint" ng-keypress="checkEnter($event)"  ng-model="searchItem.searchPoint"  numbers-only>
        </div>
		<br />
		<select class="form-control" name="searchChoose" ng-model="searchItem.searchChoose">
			<option value="-1"><spring:message code="cts.lbl.009" /></option>
			<option value="1"><spring:message code='cts.lbl.004' /></option>
			<option value="0"><spring:message code='cts.lbl.005' /></option>
		</select>
		<select class="form-control" name="searchStatus" ng-model="searchItem.searchStatus">
			<option value="-1"><spring:message code="cmm.lbl.009" /></option>
			<option value="4000"><spring:message code='cts.lbl.023' /></option>
			<option value="4100"><spring:message code='cts.lbl.024' /></option>
			<option value="2000"><spring:message code='cts.lbl.020' /></option>
			<option value="1000"><spring:message code='cts.lbl.021' /></option>
			<option value="3000"><spring:message code='cts.lbl.022' /></option>
			<option value="4200"><spring:message code='cts.lbl.054' /></option>
		</select>
		<select class="form-control" name="categoryId" ng-change="categoryChange()" ng-model="searchItem.categoryId">
			<option value=-1><spring:message code="cts.lbl.011" /></option>
			<option ng-repeat="catlist in catlist" value="{{catlist.id}}">{{catlist.name | ctgrLang}}</option>
		</select>
		<select class="form-control" name="categorySub" ng-model="searchItem.categorySub" ng-show="depthShow">
        	<option value=-1><spring:message code="cts.lbl.011" /></option>
        	<option ng-repeat="category in subCategoryList" value="{{category.id}}" >{{category.name | ctgrLang}}</option>
        </select>
        <br />
		<select class="form-control" name="searchKey" ng-model="searchItem.searchKey">
			<option value="title"><spring:message code='cmm.lbl.002' /></option>
			<option value="nickname"><spring:message code='cts.lbl.003' /></option>
			<option value="id"><spring:message code='cts.lbl.002' /></option>
		</select>
		<input type="text" name="searchText" ng-model="searchItem.searchText"
			ng-keypress="checkEnter($event)" class="form-control fm_type200"
			placeholder="<spring:message code="cmm.msg.001"/>">
		<a href="javascript:;" ng-click="searchList()"
			class="btn btn btn-primary"><i class="glyphicon glyphicon-search"></i>
			<spring:message code="cmm.btn.001" /> </a>
		<button type="button" class="btn dark" ng-click="searchReset()">
			<spring:message code="cmm.btn.005" />
		</button>
	</form:form>
</div>
<ul class="info_eList">
	<li class="data_none" ng-show="totalItems == 0">
		<spring:message code="cts.msg.001" />
	</li>
	<li ng-repeat="item in list"><a href="#/view/{{item[0]}}"> <strong ng-bind-html="item[1]"></strong>
			<p class="el_txt" ng-bind-html="item[3]" list-contest></p>
	</a>
		<ul class="info_etc info_etc_b">
			<li ng-if="item[9] != null"><span>{{item[9] | ctgrLang}}</span></li>
			<li><span>{{item[10] | ctgrLang}}</span></li>
			<li ng-if="item[11] != ''"><span>{{item[11] | ctgrLang}}</span></li>
		</ul>
		<ul class="info_etc">
			<li><span>{{item[8] | Apoint}}</span></li>
			<li><i class="glyphicon glyphicon-time"></i> <span
				class="ie_date">{{item[6] | Adate}}</span></li>
			<li><span class="status adopt" ng-show="{{item[7]}}"> <spring:message
						code="cts.lbl.004" /></span> <span class="status noadopt"
				ng-show="!{{item[7]}}"> <spring:message code="cts.lbl.005" /></span></li>
		</ul></li>
</ul>
<!--//페이지번호-->
<div class="page_box" ng-show="totalItems > 0">
	<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
		ng-model="currentPage" ng-change="pageChanged()" class="pagination"
		previous-text="&lsaquo;" next-text="&rsaquo;" first-text="&laquo;"
		last-text="&raquo;" items-per-page="10"> </uib-pagination>
</div>
<!--페이지번호//-->