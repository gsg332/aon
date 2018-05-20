<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp"%>
	<div><spring:message code='srv.cmm.034'/></div> 
  	<div><img src="<c:url value="/resources/images/survey/coupon01.png"/>" alt="<spring:message code="mem.lbl.030"/>"></div>
  	<div><spring:message code='srv.cmm.035'/></div>
  	<div>
  		<button type="button" class="btn btn-primary" ng-click="useCoupon()">Use</button>
  		<button type="button" class="btn" ng-click="sendEmail()" >Send Email</button>
  	</div>
