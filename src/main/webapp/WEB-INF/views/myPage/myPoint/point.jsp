<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
				<div class="sub_section">
					<h3 class="sub_tit"><spring:message code="pnt.lbl.004"/></h3>
                    <div class="bankbook_box">
                        <div class="bb_top">
                            <div class="bbt_tit">
                                <div class="bbt_p_img">
                                    <img src="<c:url value="/resources/images/sub/profile_default_f.png"/>" alt="<spring:message code="mem.lbl.030"/>">
                                </div>
                                <p><span>{{member.firstName}} {{member.lastName}}</span></p>
                                <div class="bbr_right">
                                    <!--<button type="button" class="btn btn-primary" ng-click="deposit()"><spring:message code="cmm.btn.024"/></button>-->
                                    <button type="button" class="btn btn-primary" ng-click="depositPaypal()"><spring:message code="cmm.btn.024"/></button>
                                    <button type="button" class="btn btn-primary" ng-click="withdraw()"><spring:message code="cmm.btn.038"/></button>
                                </div>
                            </div>
                            <ul class="bbt_box">
                                <li>
                                    <span><spring:message code="pnt.lbl.005"/></span>
                                    <p><strong>{{cyberAccount.balance | Apoint}}</strong> <spring:message code="cmm.lbl.014"/></p>
                                </li>
                                <li>
                                    <span><spring:message code="pnt.lbl.006"/></span>
                                    <p><strong>{{member.chooseCount}}</strong> <spring:message code="cmm.lbl.016"/></p>
                                </li>
                                <li>
                                    <span><spring:message code="pnt.lbl.007"/></span>
                                    <p><strong class="emerald">{{cyberAccount.chooseSum | Apoint}}</strong> <spring:message code="pnt.lbl.044"/></p>
                                </li>
                            </ul>
                            <ul class="bbt_put">
                                <li>
                                    <span><spring:message code="pnt.lbl.008"/></span>
                                    <p>{{member.loginId}}</p>
                                </li>
                                <li>
                                    <span><spring:message code="pnt.lbl.009"/></span>
                                    <p>{{cyberAccount.cyberAccNumber | cyberAccNum}}</p>
                                </li>
                                <li>
                                    <span><spring:message code="pnt.lbl.010"/></span>
                                    {{member.insertDate | Adate}}
                                </li>
                            </ul>
                            <div class="bbt_stamp">
                                <p class="bbt_s_tit">WHATINFO</p>
                                <span>www.whatinfo.com</span>
                            </div>
                        </div>
                        <!-- Account Activity -->
                        <div class="bbt_body">
                            <h4 class="blue"><spring:message code="pnt.lbl.011"/></h4>
                            <div class="basic_table traded_table">
                                <ul class="bt_top">
                                    <li class="pNo">&nbsp;</li>
                                    <li class="pDate"><spring:message code="pnt.lbl.012"/></li>
                                    <li class="pDescription"><spring:message code="pnt.lbl.013"/></li>
                                    <li class="pDeposit"><spring:message code="pnt.lbl.014"/></li>
                                    <li class="pWithdraw"><spring:message code="pnt.lbl.015"/></li>
                                    <li class="pBalance"><spring:message code="pnt.lbl.016"/></li>
                                </ul>
                                <ul class="bt_con">
                                    <!-- data가 없을 경우 현재 display:none 처리 -->
                                    <li class="data_none" ng-show="totalItems == 0">
                                        <spring:message code="pnt.msg.001"/>
                                    </li>
                                    <!-- //data가 없을 경우 -->
                                    <li ng-repeat="point in points">
                                        <div class="pNo">{{totalItems - (currentPage - 1) * itemsPerPage - $index}}</div>
                                        <div class="pDate">{{point.insertDate | Adate}}</div>
                                        <div class="pDescription">
                                        	<span ng-if="point.type == 1000"><spring:message code="pnt.type.1000"/> (<spring:message code="cmm.lbl.017"/> : {{point.sourceId}})</span>
                                        	<span ng-if="point.type == 1010"><spring:message code="pnt.type.1010"/> (<spring:message code="cmm.lbl.017"/> : {{point.sourceId}})</span>
                                        	<span ng-if="point.type == 1020"><spring:message code="pnt.type.1020"/></span>
                                        	<span ng-if="point.type == 1030"><spring:message code="pnt.type.1030"/> (<spring:message code="cmm.lbl.017"/> : {{point.sourceId}})</span>
                                        	<span ng-if="point.type == 1090"><spring:message code="pnt.type.1090"/></span>
                                        	<span ng-if="point.type == -1000"><spring:message code="pnt.type.-1000"/> (<spring:message code="cmm.lbl.017"/> : {{point.sourceId}})</span>
                                        	<span ng-if="point.type == -1020"><spring:message code="pnt.type.-1020"/></span>
                                        	<span ng-if="point.type == -1090"><spring:message code="pnt.type.-1090"/></span>
                                        </div>
                                        <div class="pDeposit">
                                        	<span ng-if="point.type > 0">{{point.point | Apoint}}</span>
                                        </div>
                                        <div class="pWithdraw">
                                        	<span ng-if="point.type < 0">{{point.point | Apoint}}</span>
                                        </div>
                                        <div class="pBalance">{{point.balance | Apoint}}</div>
                                    </li>
                                </ul>
                            </div>
                            <div class="page_box" ng-show="totalItems > 0">
                            	<uib-pagination boundary-links="true" total-items="totalItems"  max-size="10" ng-model="currentPage" ng-change="pageChanged()" class="pagination" previous-text="&lsaquo;"
                            	next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page="itemsPerPage">
                            	</uib-pagination>
                            </div>
                        </div>
                        <!-- //aded Content -->
                    </div>
				</div>