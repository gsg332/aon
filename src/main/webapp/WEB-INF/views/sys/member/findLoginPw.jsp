<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<div class="findId">
    <h2 class="ma_h3"><spring:message code='mem.lbl.040'/></h2>
    <!-- fi list -->
    <form name="findPasswordForm" id="findPasswordForm" novalidate="true">
    <ul class="find_list">
        <li>
            <label class="col-sm-2"><spring:message code='mem.lbl.007'/></label>
            <div class="col-sm-10">
                <aon-input-email ng-model="loginId" field-name="loginId"  
				placeholder="<spring:message code='mem.msg.001'/>" ng-required="true"
				alert-message="<spring:message code='mem.err.001'/>"
				format-message="<spring:message code='mem.err.014'/>" formated="true"></aon-input-email>
            </div>
        </li>
        <li>
            <label class="col-sm-2 fl_m_block"><spring:message code='mem.lbl.011'/></label>
            <div class="col-sm-4">
                <aon-input-text ng-model="firstName" 
				field-name="firstName"  
				placeholder="<spring:message code='mem.msg.008'/>" ng-required="true"
				alert-message="<spring:message code='mem.err.007'/>"></aon-input-text>
            </div>
            <label class="col-sm-2"><spring:message code='mem.lbl.012'/></label>
            <div class="col-sm-4">
				<aon-input-text ng-model="lastName" 
				field-name="lastName"  
				placeholder="<spring:message code='mem.msg.009'/>" ng-required="true"
				alert-message="<spring:message code='mem.err.006'/>"></aon-input-text>
            </div>
        </li>
    </ul>
    </form>
    <!-- //fi list -->
    <div class="btnArea">
        <button type="submit" class="btn btn-primary" ng-click="findPassword()"><spring:message code='mem.btn.002'/></button>
    </div>
</div>
<!-- //contents -->
	<div class="modal fade" id="noMember" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body center">
	                <p class="modalTxt1"><spring:message code='mem.lbl.041'/></p>
	            </div>
                <div class="modal-footer">
                    <button type="button" class="btn green" data-dismiss="modal" aria-hidden="true"><spring:message code='cmm.btn.016'/></button>
                </div>
            </div>
        </div>
    </div>        
