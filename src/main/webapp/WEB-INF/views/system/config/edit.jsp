<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<h2 class="page_tit"><spring:message code='sys.lbl.024'/></h2>
				<div class="admin_search">
					<span class="ads_date">{{className}}</span>
				</div>
                <!-- form -->
                <form:form name="mForm" method="post" novalidate="true">
                <table class="adminTable" ng-repeat="config in item">
                    <caption><spring:message code='sys.lbl.026'/></caption>
                    <colgroup>
                        <col style="width:120px;">
                        <col style="width:auto;">
                    </colgroup>
                    <tbody>
                    	<tr>                            
                            <th scope="col"><spring:message code='sys.lbl.028'/></th>
                            <td class="left">
                            	{{config.key}}
                            </td>
                        </tr>
                        <tr>                            
                            <th scope="col"><spring:message code='sys.lbl.029'/></th>
                            <td class="left">
                            	<aon-input-text ng-model="config.value" field-name="{{config.key}}" ng-if="config.UI == 'input'"></aon-input-text>
                            	<aon-textarea ng-model="config.value" field-name="{{config.key}}" ng-if="config.UI == 'textarea'"></aon-textarea>
                            	<div ng-if="config.UI == 'checkbox'">
	                            	<div class="radio">
		                            	<label>
		                            		<input type="radio" name="{{config.key}}" ng-model="config.value" value="true"> <spring:message code='sys.lbl.030'/>
		                            	</label>
		                            </div>
		                            <div class="radio">
		                            	<label>
		                            		<input type="radio" name="{{config.key}}" ng-model="config.value" value="false"> <spring:message code='sys.lbl.031'/> 
		                            	</label>
		                            </div>
                            	</div>
                            	<!-- select -->
                            </td>
                        </tr>
                    </tbody>
                </table>
                </form:form>
                <!-- //form -->
                <div class="btnArea">
                    <button type="button" class="btn btn-primary" ng-click="submit()" ng-disabled="mForm.$invalid"><spring:message code='cmm.btn.017'/></button>
                    <a href='<c:url value="#/"/>' type="button" class="btn btn-default"><spring:message code='cmm.btn.005'/></a>
                </div>