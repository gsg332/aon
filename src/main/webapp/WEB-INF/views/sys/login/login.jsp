<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script type="text/javascript-lazy" >
var contextPath = '${pageContext.request.contextPath}';
var returnUrl = location.href.substring(location.href.indexOf(contextPath) + contextPath.length);
location.href =  contextPath + '/sys/login/loginForm.aon?returnUrl=' + encodeURIComponent(returnUrl);
</script>
<script>
var contextPath = '${pageContext.request.contextPath}';
var returnUrl = location.href.substring(location.href.indexOf(contextPath) + contextPath.length);
location.href =  contextPath + '/sys/login/loginForm.aon?returnUrl=' + encodeURIComponent(returnUrl);;
</script>

