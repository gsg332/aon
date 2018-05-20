<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- find id -->
<form name="memberFindLoginId" id="memberFindLoginId" novalidate="true">
<div class="findId">
	<h2 class="ma_h3"><spring:message code='cmm.btn.020'/></h2>
	<!-- fi list -->
	<ul class="find_list">
		<li>
			<label class="col-sm-2">Email</label>
            <div class="col-sm-10">
				<aon-input-email ng-model="loginId" field-name="loginId"  
					placeholder="<spring:message code='mem.msg.001'/>" ng-required="true"
					alert-message="<spring:message code='mem.err.001'/>"
					format-message="<spring:message code='mem.err.014'/>" formated="true">
				</aon-input-email>
        	</div>
    	</li>
	</ul>
	<!-- //fi list -->
	<div class="btnArea">
    	<button type="submit" class="btn btn-primary" ng-click="loginIdConfirm()"><spring:message code='mem.btn.001'/></button>
    </div>
</div>
</form>
                    <!-- //find id -->
        <!-- //contents -->      
<div class="modal fade" id="emailConfirm" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
	    <div class="modal-content">
	        <div class="modal-header">
	           <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
	           <h4 class="modal-title"><spring:message code='mem.msg.031'/></h4>
	     	</div>
	     	<div class="modal-body">
				<p class="modalTxt2"><spring:message code='mem.msg.032'/></p>
	     	</div>
	     	<div class="modal-footer">
				<button type="button" class="btn green" data-dismiss="modal" aria-hidden="true" ng-click="confirmEmailSend()"><spring:message code='cmm.btn.016'/></button>
			</div>
		</div>
	</div>
</div>  
<div class="modal fade" id="exitsEmailId" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title"><spring:message code='mem.lbl.121'/></h4>
            </div>
            <div class="modal-body">
                <p class="modalTxt2"><spring:message code='mem.msg.112'/></p>
            </div>
            <div class="modal-footer">
                <span type="button" class="btn green" ng-click="gotoLogin()" data-dismiss="modal" aria-hidden="true"><spring:message code='cmm.btn.016'/></span>
            </div>
        </div>
    </div>
</div>