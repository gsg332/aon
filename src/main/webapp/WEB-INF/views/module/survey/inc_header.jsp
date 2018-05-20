<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ include file="/WEB-INF/views/include/appconfig.jsp" %>
<%@ page buffer="none" errorPage="/WEB-INF/views/etc/err/error.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WHATINFO</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=getServletContext().getContextPath() %>/resources/css/style.css">
    <script src="<%= request.getContextPath() %>/resources/js/jcontext.js"></script>
    <script src="<%=getServletContext().getContextPath() %>/resources/js/respond.js"></script>
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-route.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-cookies.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5//angular-sanitize.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/1.3.3/ui-bootstrap-tpls.min.js"></script>
    <script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
    <script src="<%= request.getContextPath() %>/resources/js/bootstrap.js"></script>
    <script src="<%= request.getContextPath() %>/resources/js/scripts.min.js"></script>
	<script src="<%= request.getContextPath() %>/resources/js/directives/aon.input.diretives.js"></script>
	<script src="<%= request.getContextPath() %>/resources/js/filters/aon.filters.js"></script>
	<script src="//cdn.ckeditor.com/4.5.9/standard/ckeditor.js"></script>
	<script src="<c:url value="/resources/js/script.language.${pageContext.response.locale}.js"/>"></script>
	<script>jcontext.init('<%= request.getContextPath() %>',{'${_csrf.parameterName}':'${_csrf.token}'});</script>
	<style>
	body{
	    margin: 0;
	}
	ul,
	li {
	    padding: 0;
	    margin: 0;
	    list-style: none;
	}        
	p {
	    margin: 0;
	}        
	.under {
	    display: block;
	    margin-top: 30px;
	    color: #666;
	    text-decoration: underline;
	}
	.strong{
	    font-weight: bold;
	}
	.lpl_title_b{
	    margin-top: 30px;
	    font-size: 32px;
	    font-weight: bold;
	    text-align: center;
	}
	.lpl_title {
	    position: relative;
	    padding-left: 0;
	    font-size:16px;
	    font-weight: bold;
	}
	.lpl_question{
	    position: relative;
	}
	.lpl_ico{
	    display: inline-block;
	    float: left;
	    margin-right: 10px;
	}
	.lpl_txt{
	    display: block;
	    overflow: hidden;
	}
	.rank{
	    display: inline-block;
	    min-width: 50px;
	}
	.rank_title{
	    display: inline-block;
	    width: 70px;
	}
	.layout_poll{
	    padding: 20px;
	    font-size: 14px;
	}
	.dep_01 {
	    padding-top: 50px;
	    line-height: 180%;
	    list-style: upper-alpha;
	}        
	.dep_01:first-child {
	    padding-top: 0;
	}
	
	.dep_02 {
	    padding: 20px 0 0 20px;
	}        
	.dep_03 {
	    padding: 15px 0 15px 35px;
	}
	.bt_right .dep_03{
	    padding: 0;
	}
	.lpl_yn li {
	    float: left;
	    margin-right: 30px;
	}        
	.lpl_yn:before,
	.lpl_yn:after {
	    content: '';
	    display: block;
	    clear: both;
	}        
	.basic_table_box{            
	    padding-top: 10px;
	}
	.basic_table{
	    margin-top: 10px;
	    display: table;
	    width: 100%;
	    border: 1px solid #dedede;
	}
	.basic_table > li{
	    border-top: 1px solid #dedede;
	}
	.basic_table > li:first-child{
	    border-top: 0;
	}
	.bt_left{
	    width: 100px;
	    display: table-cell;
	    vertical-align: middle;
	    text-align: center;
	    border-right: 1px solid #dedede;
	}
	.bt_right{
	    display: table-cell;
	    padding: 5px 20px;
	}
	.lpl_textarea{
	    width: 100%;
	    resize: none;
	}
	
	.checks {
	    position: relative;
	}        
	.checks input[type="radio"] {
	    position: absolute;
	    width: 1px;
	    height: 1px;
	    padding: 0;
	    margin: -1px;
	    overflow: hidden;
	    clip: rect(0, 0, 0, 0);
	    border: 0;
	}        
	.checks input[type="radio"] + label {
	    display: inline-block;
	    position: relative;
	    cursor: pointer;
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	}        
	.checks input[type="radio"]:checked + label {
	    color: #3598dc;
	}
	.checks input[type="radio"]:checked + label:before{
	    content: '\2714';
	    position: absolute;
	    top: -3px;
	    left: 3px;
	    z-index: 1;
	}        
	.checks input[type="checkbox"] {
	    position: absolute;
	    width: 1px;
	    height: 1px;
	    padding: 0;
	    margin: -1px;
	    overflow: hidden;
	    clip: rect(0, 0, 0, 0);
	    border: 0;
	}
	.checks input[type="checkbox"] + label {
	  display: inline-block;
	  position: relative;
	  cursor: pointer;
	  -webkit-user-select: none;
	  -moz-user-select: none;
	  -ms-user-select: none;
	}        
	.checks input[type="checkbox"]:checked + label {
	    color: #3598dc;
	}
	.checks input[type="checkbox"]:checked + label:before{
	    content: '\2714';
	    position: absolute;
	    top: -3px;
	    left: 3px;
	    z-index: 1;
	}
	
	.btn_area{
	    text-align: center;
	}
	.btn{
	    display: inline-block;
	    padding: 6px 12px;
	    margin-bottom: 0;
	    font-size: 14px;
	    font-weight: 400;
	    line-height: 1.42857143;
	    text-align: center;
	    white-space: nowrap;
	    vertical-align: middle;
	    -ms-touch-action: manipulation;
	    touch-action: manipulation;
	    cursor: pointer;
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	    user-select: none;
	    background-image: none;
	    border: 1px solid transparent;
	    border-radius: 4px
	}
	.btn-primary {
	  color: #fff;
	  background-color: #337ab7;
	  border-color: #2e6da4;
	}
	.poll_head{
	    padding:5px;
	    line-height: 0;
	    background: #353f49;
	}
	</style>
</head>
<body>
