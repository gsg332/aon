<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<h2 class="page_tit"><spring:message code='cmm.menu.007'/></h2>
                <!-- form -->
                <form:form name="mForm" method="post" novalidate="true">
                <table class="adminTable">
                    <caption><spring:message code='ntc.lbl.002'/></caption>
                    <colgroup>
                        <col style="width:120px;">
                        <col style="width:auto;">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="col"><spring:message code='cmm.lbl.002'/></th>
                            <td class="left">
                            	<aon-input-text ng-model="title" field-name="title" placeholder="<spring:message code='cmm.msg.002'/>" ng-required="true" alert-message="<spring:message code='ntc.err.001'/>"></aon-input-text>
                            </td>
                        </tr>
                        <tr>
                            <th scope="col"><spring:message code='cmm.lbl.003'/></th>
                            <td class="left">
                                <aon-editor ng-model="content" field-name="content" label="" placeholder="<spring:message code='cmm.msg.003'/>" ng-required="true" alert-message="<spring:message code='ntc.err.002'/>"></aon-editor>
                            </td>
                        </tr>
                    </tbody>
                </table>
                </form:form>
                <!-- //form -->
                <div class="btnArea">
                    <button type="button" class="btn btn-primary" ng-click="submit()" ng-disabled="mForm.$invalid"><spring:message code='cmm.btn.004'/></button>
                    <a href='<c:url value="#/"/>' type="button" class="btn btn-default"><spring:message code='cmm.btn.005'/></a>
                </div>