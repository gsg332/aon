<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<h2 class="page_tit"><spring:message code='cmm.menu.007'/></h2>
                <!-- form -->
                <form:form name="mForm" method="post" novalidate="true">
                <input type="hidden" name="id" value="{{item.id}}"/>
                <table class="adminTable">
                    <caption><spring:message code='ntc.lbl.003'/></caption>
                    <colgroup>
                        <col style="width:120px;">
                        <col style="width:auto;">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="col"><spring:message code='cmm.lbl.001'/></th>
                            <td class="left">
                                {{item.id}}
                            </td>
                        </tr>
                        <tr>
                            <th scope="col"><spring:message code='cmm.lbl.002'/></th>
                            <td class="left">
                            	<aon-input-text ng-model="item.title" field-name="title" placeholder="<spring:message code='cmm.msg.002'/>" ng-required="true" alert-message="<spring:message code='ntc.err.001'/>"></aon-input-text>
                            </td>
                        </tr>
                        <tr>
                            <th scope="col"><spring:message code='cmm.lbl.003'/></th>
                            <td class="left">
                                <aon-editor ng-model="item.content" field-name="content" label="" placeholder="<spring:message code='cmm.msg.003'/>" ng-required="true" alert-message="<spring:message code='ntc.err.002'/>"></aon-editor>
                            </td>
                        </tr>
                    </tbody>
                </table>
                </form:form>
                <!-- //form -->
                <div class="btnArea">
                    <button type="button" class="btn btn-primary" ng-click="submit()" ng-disabled="mForm.$invalid"><spring:message code='cmm.btn.017'/></button>
                    <aon-btn-modal-confirm field-text="<spring:message code='cmm.btn.018'/>" modal-id=".confirm" btn-class="btn btn-danger" confirm-text="<spring:message code='ntc.msg.002'/>" confirm-callback="del()"></aon-btn-modal-confirm>
                    <a href='<c:url value="#/"/>' type="button" class="btn btn-default"><spring:message code='cmm.btn.005'/></a>
                </div>