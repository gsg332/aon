<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<div class="sub_section">
	<h3 class="sub_tit"><spring:message code='cts.lbl.001'/></h3>
    <div class="searchList">
    	<select name="searchKey" class="form-control fm_type140" ng-model="searchKey">
        	<option value="title" selected><spring:message code='cmm.lbl.002'/></option>
            <option value="nickname"><spring:message code='cts.lbl.003'/></option>
            <option value="qaId"><spring:message code='cts.lbl.002'/></option>
        </select>
        <div class="sl_box">
        	<input type="text" class="form-control" placeholder="<spring:message code='cmm.msg.001'/>" name="searchValue" ng-model="searchValue" ng-keypress="enterSearch($event)">
        	<button class="btn btn-primary btn_search" ng-click="search()"><span><spring:message code='cmm.btn.001'/></span></button>
        </div>
    </div>
    <div class="info_box">
    	<ul class="info_eList">
    		<li ng-repeat="item in list">
    			<a href="#/view/{{item[0]}}">
    				<strong ng-bind-html="item[1]"></strong>
    				<p class="el_txt" ng-bind-html="item[2]" list-contest></p>
                </a>
                <ul class="info_etc info_etc_b">
                	<li ng-if="item[6] != null"><span><a href='<c:url value="#/list/{{item[10]}}"/>'>{{item[6] | ctgrLang}}</a></span></li>
					<li ng-if="item[6] != null"><span>{{item[7] | ctgrLang}}</span></li>
					<li ng-if="item[6] == null"><span><a href='<c:url value="#/list/{{item[11]}}"/>'>{{item[7] | ctgrLang}}</a></span></li>
					<li ng-if="item[8] != ''"><span>{{item[8] | ctgrLang}}</span></li>
                </ul>
                <ul class="info_etc">
					<li><span>{{item[4] | Apoint}}</span></li>
					<li>
						<span class="ie_date">{{item[5] | Adate}}</span>
					</li>
					<li>
						<span class="status adopt" ng-if="item[3]"><spring:message code='cts.lbl.004'/></span>
						<span class="status noadopt" ng-if="!item[3]"><spring:message code='cts.lbl.005'/></span>
					</li>
                </ul>
            </li>
            <!-- 데이터가 없을 경우 현재 display:none 처리 -->
        	<li class="data_none" ng-show="totalItems == 0">
				<spring:message code='cts.msg.001'/>
        	</li>
        </ul>
        <%-- 
    	<div class="btnArea">
        	<a href='#/write' class="btn btn-primary"><spring:message code='cmm.btn.004'/></a>
        </div>
         --%>
    </div>
	<!--//페이지번호-->
	<div class="page_box" ng-show="totalItems > 0">
		<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
			ng-model="currentPage" ng-change="pageChanged()" class="pagination" previous-text="&lsaquo;"
			next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page ="10">
		</uib-pagination>
	</div>
	<!--페이지번호//-->
</div>