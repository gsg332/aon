<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <div class="aside">
            <div class="aside_btn"><a href="#"><spring:message code='cmm.btn.040'/></a></div>
            <div class="aside_scroll">
                <ul class="aside_list" left-menu>
                    <li>
                        <strong>Home</strong>
                        <ul class="al_dep2">
                            <li ng-class="leftMenu == '' ? 'on' : ''">
                                <a href='<c:url value="/supervisor/index.aon#/"/>'>Admin Main</a>
                            </li>
                            <li>
                                <a href='<c:url value="/index.aon#/"/>'>Homepage</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <strong>System</strong>
                        <ul class="al_dep2">
                            <li ng-class="leftMenu == 'schedule' ? 'on' : ''">
                            	<a href='<c:url value="/system/schedule/index.aon#/"/>'>Schedule</a>
                            </li>
                            <li ng-class="leftMenu == 'scheduleLog' ? 'on' : ''">
								<a href='<c:url value="/system/schedule/index.aon#/log"/>'>Schedule Log</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <strong>Configuration</strong>
                        <ul class="al_dep2">
                        	<li ng-class="leftMenu == 'config' ? 'on' : ''">
								<a href='<c:url value="/system/config/index.aon#/"/>'>System Configuration</a>
                            </li>
                            <li ng-class="leftMenu == 'message' ? 'on' : ''">
								<a href='<c:url value="/system/message/index.aon#/"/>'>Message Configuration</a>
                            </li>
						</ul>
					</li>
                </ul>
            </div>
        </div>
