<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<style>
	html,body{width:100%; height:100%; margin:0; padding:0;}
</style>
<div style="display: table; width:100%; height:100%;">
	<div style="display: table-cell; vertical-align: middle; text-align: center;">
		<div style="display: inline-block; margin:0 auto; text-align: left;">
			<h1 style="margin: 0; font-size: 36px; color: #353f49;"><spring:message code='err.404.title'/></h1>
			<p style="display: inline-block; margin-top:20px; padding-bottom:20px; line-height: 200%; font-size:16px;  color: #aeb2b6;">
		  	<spring:message code='err.404.desc'/>
			</p>
			<a href="<c:url value="/index.aon"/>" style="display: block; padding:12px; margin:0; font-weight: 300; color:#FFFFFF; background-color: #286090; text-decoration: none; font-size:0.9em; border-radius: 5px; text-align:center;">
			<spring:message code='err.404.move'/>
			</a>					
		</div>							
	</div>
</div>