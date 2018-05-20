<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <div class="aside">
            <div class="aside_btn"><a href="#"><spring:message code='cmm.btn.040'/></a></div>
            <div class="aside_scroll">
                <ul class="aside_list" left-menu>
                    <li>
                        <strong>Home</strong>
                        <ul class="al_dep2">
                            <li ng-class="leftMenu == 'adminMain' ? 'on' : ''">
                                <a href='<c:url value="/supervisor/index.aon#/"/>'>Admin Main</a>
                            </li>
                            <li>
                                <a href='<c:url value="/index.aon#/"/>'>Homepage</a>
                            </li>
                            <li ng-class="leftMenu == 'onlineAsk' ? 'on' : ''">
                               <a href='<c:url value="/supervisor/module/onlineAsk/index.aon#/"/>'>Online Inquiry</a>
                            </li>
                            <li ng-class="leftMenu == 'notice' ? 'on' : ''">
                                <a href='<c:url value="/supervisor/notice/index.aon#/"/>'>Notice</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <strong>Inquiry</strong>
                        <ul class="al_dep2">
                            <li ng-class="leftMenu == 'contest' ? 'on' : ''">
                            	<a href='<c:url value="/supervisor/module/contest/index.aon#/"/>'>New Question</a>
                            </li>
                            <li ng-class="leftMenu == 'answer' ? 'on' : ''">
								<a href='<c:url value="/supervisor/module/contest/answer.aon#/"/>'>Answer</a>
                            </li>
                            <li ng-class="leftMenu == 'report' ? 'on' : ''">
                                <a href='<c:url value="/supervisor/module/contest/report/index.aon#/"/>'><spring:message code='cts.lbl.053'/></a>
                            </li>
                            <li ng-class="leftMenu == 'category' ? 'on' : ''">
                                <a href='<c:url value="/supervisor/module/category/index.aon#/"/>'><spring:message code='cat.lbl.001'/></a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <strong>Member</strong>
                        <ul class="al_dep2">
                            <li ng-class="leftMenu == 'member' ? 'on' : ''">
                                <a href="<c:url value="/supervisor/member/index.aon#/"/>">Member</a>
                            </li>
                            <li ng-class="leftMenu == 'dropout' ? 'on' : ''">
                                <a href="<c:url value="/supervisor/dropout/index.aon#/"/>"><spring:message code='mem.lbl.120'/></a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <strong>Payment</strong>
                        <ul class="al_dep2">
                            <li ng-class="leftMenu == 'deposit' ? 'on' : ''">
                                <a href="<c:url value="/supervisor/deposit/index.aon#/"/>">Deposit status</a>
                            </li>
                            <li ng-class="leftMenu == 'withdraw' ? 'on' : ''">
                                <a href="<c:url value="/supervisor/withdraw/index.aon#/"/>">Withdraw status</a>
                            </li>
                            <li ng-class="leftMenu == 'point' ? 'on' : ''">
                                <a href="<c:url value="/supervisor/point/index.aon#/"/>">Point</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
