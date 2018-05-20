<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<h2 class="page_tit"><spring:message code='sys.lbl.001'/></h2>
                <!-- form -->
                <form:form name="mForm" method="post" novalidate="true">
                <input type="hidden" name="id" value="{{item.id}}"/>
                <table class="adminTable">
                    <caption><spring:message code='sys.lbl.004'/></caption>
                    <colgroup>
                        <col style="width:120px;">
                        <col style="width:auto;">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.005'/></th>
                            <td class="left">
                                {{item.id}}
                            </td>
						</tr>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.007'/></th>
                            <td class="left">
								<span ng-if="item.result == 0"><spring:message code='sys.lbl.013'/></span>
								<span ng-if="item.result == 1000"><spring:message code='sys.lbl.014'/></span>
                                <span ng-if="item.result == 2000"><spring:message code='sys.lbl.015'/></span>
                                <span ng-if="item.result == 3000"><spring:message code='sys.lbl.016'/></span>
                            </td>
						</tr>
                        <tr>                            
                            <th scope="col"><spring:message code='sys.lbl.008'/></th>
                            <td class="left">
                            	<span ng-if="item.paused"><spring:message code='sys.lbl.017'/></span>
                            </td>
                        </tr>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.006'/></th>
                            <td class="left">
                            	<aon-input-text ng-model="item.className" field-name="className" placeholder="<spring:message code='sys.msg.003'/>" ng-required="true" alert-message="<spring:message code='sys.err.001'/>"></aon-input-text>
                            </td>
                        </tr>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.009'/></th>
                            <td class="left">
                            	<aon-input-text ng-model="item.param" field-name="param" placeholder="<spring:message code='sys.msg.004'/>" ng-required="true" alert-message="<spring:message code='sys.err.002'/>"></aon-input-text>
                            </td>
                        </tr>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.011'/></th>
                            <td class="left">
                            	<input type="text" class="form-control" placeholder="<spring:message code='sys.msg.005'/>" name="cron" ng-model="item.cron" ng-readonly="item.interval > 0">
                            </td>
                        </tr>
                        <tr>
                            <th scope="col"><spring:message code='sys.lbl.012'/></th>
                            <td class="left">
                            	<input type="number" class="form-control" placeholder="<spring:message code='sys.msg.006'/>" name="interval" ng-model="item.interval" ng-readonly="item.cron" ng-pattern="/^[0-9]+$/">
                            </td>
                        </tr>
                    </tbody>
                </table>
                </form:form>
                <!-- //form -->
                <div class="btnArea">
                    <button type="button" class="btn btn-primary" ng-click="submit()" ng-disabled="mForm.$invalid"><spring:message code='cmm.btn.017'/></button>
                    <button type="button" class="btn btn-warning" ng-click="openToggle(true)" ng-show="!item.paused"><spring:message code='sys.btn.001'/></button>
                    <button type="button" class="btn btn-warning" ng-click="openToggle(false)" ng-show="item.paused"><spring:message code='sys.btn.002'/></button>
                    <aon-btn-modal-confirm field-text="<spring:message code='cmm.btn.018'/>" modal-id=".confirm" btn-class="btn btn-danger" confirm-text="<spring:message code='sys.msg.002'/>" confirm-callback="del()"></aon-btn-modal-confirm>
                    <a href='<c:url value="#/"/>' type="button" class="btn btn-default"><spring:message code='cmm.btn.005'/></a>
                </div>
                
                <div id="confirmS" class="modal fade confirmS" tabindex="-1" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-body center">
								<p class="modalTxt1 ng-binding" ng-show="!item.paused"><spring:message code='sys.msg.007'/></p>
								<p class="modalTxt1 ng-binding" ng-show="item.paused"><spring:message code='sys.msg.008'/></p>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn green" data-dismiss="modal" ng-click="toggle()"><spring:message code='cmm.btn.042'/></button>
								<button type="button" class="btn dark btn-outline" data-dismiss="modal"><spring:message code='cmm.btn.043'/></button>
							</div>
						</div>
					</div>
				</div>
                