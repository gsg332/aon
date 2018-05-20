<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<div class="sub_section">
                    <h3 class="sub_tit"><spring:message code='cmm.menu.007'/></h3>
                    <div class="searchList">
                        <select name="searchKey" class="form-control fm_type140" ng-model="searchKey">
                            <option value="title" selected><spring:message code='cmm.lbl.002'/></option>
                            <option value="content"><spring:message code='cmm.lbl.003'/></option>
                            <option value="all"><spring:message code='cmm.lbl.002'/>+<spring:message code='cmm.lbl.003'/></option>
                        </select>
                        <div class="sl_box">
                            <input type="text" class="form-control" placeholder="<spring:message code='cmm.msg.001'/>" name="searchValue" ng-model="searchValue" ng-keypress="enterSearch($event)">
                            <button class="btn btn-primary btn_search" ng-click="search()"><span><spring:message code='cmm.btn.001'/></span></button>
                        </div>
                    </div>
                    <div class="noticeView" ng-show="noticeView">
                        <div class="TopArea">
                            <p class="subject" ng-bind-html="item.title"></p>
                            <p class="date">{{item.insertDate | Adate }}<span class="admin"><spring:message code='ntc.lbl.004'/></span></p>
                        </div>
                        <div class="BodyArea" ng-bind-html="item.content"></div>
                        <div class="btnArea">
                        	<button type="button" class="btn btn-default" ng-click="load(previous.id)" ng-show="previous.id"><spring:message code='cmm.btn.002'/></button>
							<button type="button" class="btn btn-default" ng-click="load(next.id)" ng-show="next.id"><spring:message code='cmm.btn.003'/></button>
                        </div>
                    </div>
                    <ul class="notice_list" ng-class="noticeView ? 'nView_list' : ''">
                        <!-- 데이터가 없을 경우 현재 display:none 처리 -->
                        <li class="data_none" ng-show="totalItems == 0">
							<spring:message code='ntc.msg.001'/>
                        </li>
                        <!-- 데이터가 없을 경우 -->
                        <li ng-repeat="notice in list" ng-click="load(notice.id)" ng-class="item.id == notice.id ? 'bold' : ''">
                            <div class="num">{{totalItems - (currentPage - 1) * 10 - $index}}</div>
                            <div class="subject">
                                <span ng-bind-html="notice.title"></span>
                            </div>
                            <div class="date">{{notice.insertDate | Adate }}</div>
                        </li>
					</ul>
					<!--//페이지번호-->
					<div class="page_box" ng-show="totalItems > 0">
						<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
							ng-model="currentPage" ng-change="pageChanged()" class="pagination" previous-text="&lsaquo;"
							next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page ="10">
						</uib-pagination>
					</div>
					<!--페이지번호//-->
				</div>
