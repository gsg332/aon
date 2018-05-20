<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<h2 class="page_tit"><spring:message code='sys.lbl.001'/></h2>
                <!-- form -->
                <form:form name="mForm" method="post" novalidate="true">
                <table class="adminTable">
                    <caption><spring:message code='sys.lbl.003'/></caption>
                    <colgroup>
                        <col style="width:120px;">
                        <col style="width:auto;">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.006'/></th>
                            <td class="left">
                            	<aon-input-text ng-model="className" field-name="className" placeholder="<spring:message code='sys.msg.003'/>" ng-required="true" alert-message="<spring:message code='sys.err.001'/>"></aon-input-text>
                            </td>
                        </tr>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.009'/></th>
                            <td class="left">
                            	<aon-input-text ng-model="param" field-name="param" placeholder="<spring:message code='sys.msg.004'/>" ng-required="true" alert-message="<spring:message code='sys.err.002'/>"></aon-input-text>
                            </td>
                        </tr>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.011'/></th>
                            <td class="left">
                            	<input type="text" class="form-control" placeholder="<spring:message code='sys.msg.005'/>" name="cron" ng-model="cron" ng-readonly="interval > 0">
                            </td>
                        </tr>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.012'/></th>
                            <td class="left">
                            	<input type="number" class="form-control" placeholder="<spring:message code='sys.msg.006'/>" name="interval" ng-model="interval" ng-readonly="cron" ng-pattern="/^[0-9]+$/">
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