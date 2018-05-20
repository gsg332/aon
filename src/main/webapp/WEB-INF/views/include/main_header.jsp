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
    <!-- <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> -->
    <link rel="stylesheet" href="<%=getServletContext().getContextPath() %>/resources/css/style.css">
    <link rel="stylesheet" href="<%=getServletContext().getContextPath() %>/resources/css/main.css">
	<link rel="stylesheet" href="<%=getServletContext().getContextPath() %>/resources/css/owl.carousel.css">
	<link rel="stylesheet" href="<%=getServletContext().getContextPath() %>/resources/css/jquery.bxslider.css">
    <script src="<%= request.getContextPath() %>/resources/js/jcontext.js"></script>
    <script src="<%=getServletContext().getContextPath() %>/resources/js/respond.js"></script>
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-route.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-cookies.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.5.5/angular-sanitize.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/1.3.3/ui-bootstrap-tpls.min.js"></script>
    <script src="//code.jquery.com/jquery-2.1.3.min.js"></script>
    <script src="<%= request.getContextPath() %>/resources/js/bootstrap.js"></script>
    <script src="<%= request.getContextPath() %>/resources/js/scripts.min.js"></script>
	<script src="<%= request.getContextPath() %>/resources/js/directives/aon.input.diretives.js"></script>
	<script src="<%= request.getContextPath() %>/resources/js/filters/aon.filters.js"></script>
	<script src="//cdn.ckeditor.com/4.5.9/standard/ckeditor.js"></script>
	<script src="<c:url value="/resources/js/script.language.${pageContext.response.locale}.js"/>"></script>
    <script>
    	jcontext.init('<%= request.getContextPath() %>',{'${_csrf.parameterName}':'${_csrf.token}'});
    
    	var headerApp = angular.module("HeaderApp", ['ngRoute', 'ngSanitize', 'ui.bootstrap', 'aon.input.directives', 'Filters'])
    	.controller('HeaderCtl',function($scope, $cookies){
    		$cookies.put('defaultLocale', '<c:out value="${defaultLocale}"/>');
    		$cookies.put('locales', '<c:out value="${locales}"/>');
    		
    		$scope.view = false;
    		$scope.style = {width:'auto'};
    		$scope.lastId = 0;
    		
    		var init = function(data){
    			$scope.list = data.list;
    			$scope.totalItems = data.count;
    			if($scope.totalItems > 0){
    				$scope.lastId = $scope.list[$scope.list.length - 1].id;
    			}
    		}
    		
    		$scope.load = function() {
    			var data = jcontext.loadJSON('/sys/message/list.json');
    			var newCount = jcontext.loadJSON('/sys/message/newMsgCount.json');
        		$scope.newCount = newCount.count;
	    		init(data);
    		}
    		
    		$scope.toggle = function() {
    			if(!$scope.view){
    				if($scope.totalItems == 0){
    					$(angular.element(alertText)[0]).modal();
    					return false;
    				}
    				$scope.notified($scope.list);
    				$scope.view = true;
    				$scope.style = {};
    			}else{
    				$scope.view = false;
    				$scope.style = {width:'auto'};
    			}
    		}
    		
    		$scope.delAll = function(){
    			jcontext.jsonAction('/sys/message/deleteAll.aon','',
       				{
       					message:i18n.getLang('common','delete')
       				 	,callback: function(data){
	       				 	$scope.list = null;
	       		    		$scope.totalItems = 0;
	       		    		$scope.view = false;
	       		    		$scope.style = {width:'auto'};
       				    }
       				}
       			);
    		}
    		
    		$scope.del = function(node){
    			jcontext.jsonAction('/sys/message/delete.aon','messageId='+node.id,
   					{
   						message:i18n.getLang('common','delete')
   					 	,callback: function(data){
							var index = $scope.getNodeIndex($scope.list, node);
							$scope.list.splice(index,1);
							$scope.totalItems--;
							if($scope.totalItems == 0){
								$scope.view = false;
								$scope.style = {width:'auto'};
							}
   					    }
   					}
   				);
    		}
    		
    		$scope.more = function(){
    			var more = jcontext.loadJSON('/sys/message/list.json?id='+$scope.lastId);
    			if(more.count == 0){
    				$(angular.element(alertText)[0]).modal();
    			}else{
    				$scope.notified(more.list);
    				$scope.list.push.apply($scope.list, more.list);
        			$scope.lastId = $scope.list[$scope.list.length - 1].id;
        			$scope.totalItems += more.count;	
    			}
    		}
    		
    		$scope.getNodeIndex = function(nodes, node) {
    			if (!nodes || !node) return -1;
    			for (var i=0; i<nodes.length; i++) {
    				if (node === nodes[i]) return i;
    			}
    		}
    		
    		$scope.notified = function(list){
    			var ids = '';
    			for (var i=0; i<list.length; i++) {
    				if(!list[i].receivers[0].isNotified){
    					if(ids.length > 0){
    						ids += ', ';
    					}
    					ids += list[i].id;
    				}
    			}
    			if(ids.length > 0){
    				var result = jcontext.loadJSON('/sys/message/readCheck.json','ids='+ids);
    			}
    		}
    		
    		<sec:authorize access="isAuthenticated()">
    		$scope.load();
    		</sec:authorize>
    		
			$scope.beforeDrop = null;
    		
    		$scope.dropDown = function(event){
    			if($(event.target).parent().hasClass('open')){
    				$(event.target).attr('aria-expanded', false);
    				$(event.target).parent().removeClass('open');
    			}else{
    				if($scope.beforeDrop != null){
		    			$scope.beforeDrop.attr('aria-expanded', false);
		    			$scope.beforeDrop.parent().removeClass('open');
					}	
	    			$(event.target).attr('aria-expanded', true);
	    			$(event.target).parent().addClass('open');
	    			$scope.beforeDrop = $(event.target);
    			}
    		}

    		$scope.afterDrop = function(){
    			if($scope.beforeDrop != null){
	    			$scope.beforeDrop.attr('aria-expanded', false);
	    			$scope.beforeDrop.parent().removeClass('open');
    			}
    		}
    	});
    	angular.element($('document')).ready(function($scope) {
    	    angular.bootstrap($('#header'), ["HeaderApp"]);
    	});
     
     <% if(useAnalytics()) {%>
 	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
 	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
 	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
 	  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

 	  ga('create', 'UA-79598725-1', 'auto');
 	  ga('send', 'pageview');
	<%} %>
    </script>
    <script src="<%= request.getContextPath() %>/resources/js/owl.carousel.min.js"></script>
	<script src="<%= request.getContextPath() %>/resources/js/jquery.bxslider.js"></script>
	<script>
		$(function(){
			$(".hero_area_list").owlCarousel({
				items: 1,
				margin: 15,
				/*autoplay: true,*/
				nav: true,
				navText: ["<i class='glyphicon glyphicon-chevron-left'></i>" , "<i class='glyphicon glyphicon-chevron-right'></i>"],
				dots: false,
				loop: true
			});	
			
			$('.categorySlider').owlCarousel({
				loop: true,
				items: 1,
				margin:10,
				dots: false,
				nav: true,
				autoplay: true,
				autoplayHoverPause: true,
				autoplayTimeout: 1000,
				smartSpeed: 1000,
				fluidSpeed: 1000,
				responsiveClass: true,
				responsive:{
					0:{
						items:2
					},
					640:{
						items:5
					},
					1000:{
						items:10
					}
				}			
			});
			/* var slider = $('.categorySlider').bxSlider({
				slideWidth : 97,
				minSlides : 2,
				maxSlides : 10,
				moveSlides : 1,
				slideMargin : 10,
				speed: 1500,
				captions : true,
				auto : true,
				infiniteLoop : true,
				adaptiveHeight : true,
				controls : true,
				pager : false,
				randomStart : false,
				autoHover : true,
				touchEnabled:false,
				nextSelector : '.cate_right',
				prevSelector : '.cate_left',
				onSlideAfter: function() {
		            slider.stopAuto();
		            slider.startAuto();
		        }
			});
			//창사이즈를 변경하면 슬라이드가 멈추는 현상이 있기 때문에 사이즈가 변경될 때마다 리로드 될 수 있도록 함.
			$(window).on('resize', function () {
				slider.reloadSlider();
			}); */
		});
	</script>
</head>
<body class="main">
	<div id="alert-div"></div>
    <div class="header" id="header">
        <!-- Static navbar -->
        <nav class="navbar navbar-default navbar-static-top">
            <div class="container" ng-controller="HeaderCtl">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <h1><a class="navbar-brand" href='<c:url value="/index.aon"/>'>WHATINFO</a></h1>
                </div>
                <!-- nav-collapse -->
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <p class="dropdown-toggle" role="button" aria-expanded="false" ng-click="dropDown($event)"><spring:message code='cmm.menu.002'/> <span class="caret"></span></p>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href='<c:url value="/serviceInfo/notice/index.aon#/html/aboutUs"/>' ng-click="afterDrop()"><spring:message code='cmm.menu.003'/></a></li>
                                <li><a href='<c:url value="/serviceInfo/notice/index.aon#/html/serviceProcess"/>' ng-click="afterDrop()"><spring:message code='cmm.menu.004'/></a></li>
                                <li><a href='<c:url value="/serviceInfo/notice/index.aon#/html/userAgreement"/>' ng-click="afterDrop()"><spring:message code='cmm.menu.005'/></a></li>
                                <li><a href='<c:url value="/serviceInfo/notice/index.aon#/html/personalInfo"/>' ng-click="afterDrop()"><spring:message code='cmm.menu.006'/></a></li>
                                <li><a href='<c:url value="/serviceInfo/notice/index.aon"/>' ng-click="afterDrop()"><spring:message code='cmm.menu.007'/></a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href='<c:url value="/module/contest/index.aon"/>' class="dropdown-toggle" role="button" ng-click="afterDrop()"><spring:message code='cmm.menu.008'/></a>
                        </li>
                        <li class="dropdown">
                            <p class="dropdown-toggle" role="button" aria-expanded="false" ng-click="dropDown($event)"><spring:message code='cmm.menu.010'/> <span class="caret"></span></p>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href='<c:url value="/myPage/myInfo/index.aon"/>' ng-click="afterDrop()"><spring:message code='cmm.menu.011'/></a></li>
                                <li><a href='<c:url value="/myPage/myQuestion/index.aon"/>' ng-click="afterDrop()"><spring:message code='cmm.menu.012'/></a></li>
                                <li><a href='<c:url value="/myPage/myAnswer/index.aon"/>' ng-click="afterDrop()"><spring:message code='cmm.menu.013'/></a></li>
                                <li><a href='<c:url value="/myPage/myPoint/index.aon"/>' ng-click="afterDrop()"><spring:message code='cmm.menu.014'/></a></li>
                                <li><a href='<c:url value="/myPage/member/index.aon"/>' ng-click="afterDrop()"><spring:message code='cmm.menu.015'/></a></li>
                                <li><a href='<c:url value="/myPage/member/index.aon#/memberUpdateProfileForm"/>' ng-click="afterDrop()"><spring:message code='cmm.menu.017'/></a></li>
                            </ul>
                        </li>
                    </ul>
                    <sec:authorize access="isAuthenticated()">
	                    <ul class="nav navbar-nav navbar-right nav_logout">
	                    	<div style="display:none;">
	                        	<!-- 로그아웃된 상태에서 controller에 Spring tag를 넣으면 화면이 보이지 않는 오류가 발생하여 다음과 같이 처리. -->
	                        	{{balance = '<sec:authentication property="principal.balance"/>'}}
	                        	{{questionIsRead  = '<sec:authentication property="principal.questionIsRead"/>'}}
	                        	{{answerIsRead  = '<sec:authentication property="principal.answerIsRead"/>'}}
	                        </div>
	                        <li class="timelist" ng-style="style">
	                      		<button class="relative btn_timeline" ng-click="toggle()">
	                      			<span class="t_b_circle">
										<i class="glyphicon glyphicon-volume-up"></i>
	                      			</span>
									<span class="t_s_circle ng-hide" ng-show="newCount > 0" ng-bind-html="newCount > 99 ? '&middot;&middot;&middot;' : newCount "></span>
	                       		</button>
								<div class="timeline_box">
									<div class="timeline ng-hide" ng-show="view">
										<p class="tl_title">Timeline</p>
										<button class="btn_none" ng-click="delAll()">
											<span><spring:message code='cmm.lbl.025'/></span>
										</button>
										<ul>
											<li ng-repeat="message in list" class="{{message.content | className}}" ng-class="message.receivers[0].isNotified ? 'grayscale' : ''">
												<div class="tl_area">
													<p class="tl_box" ng-init="tempContent = (message.content | ctgrLang | codeHtml:true)" ng-bind-html="tempContent"></p>
													<span class="tl_from tl_from_r">{{message.sendedDate | timeago:true}}</span>
												</div>
												<button class="tl_esc" ng-click="del(message)">
													<span class="glyphicon glyphicon-remove"></span>
												</button>
											</li>
										</ul>
										<button class="btn tl_more" ng-click="more()">
											<span><img src="<%= request.getContextPath() %>/resources/images/common/ico_time_more.png" alt=""></span>
										</button>
									</div>
								</div> 
	                       	</li>
	                        <li><a href='<c:url value="/myPage/myInfo/index.aon"/>'><span class="tl_info"><sec:authentication property="principal.customUser.displayName"/></span></a></li>
	                        <li><a href='<c:url value="/myPage/myPoint/index.aon"/>'><span class="tl_point"><em class="pl_pt">P</em> <span ng-bind="balance | Apoint"></span></span></a></li>
	                        <li ng-if="answerIsRead > 0"><a href='<c:url value="/myPage/myAnswer/index.aon#/true"/>' class="tl_gText"><span ng-bind="'<spring:message code='cmm.btn.036'/>'"></span> <span ng-class="answerIsRead > 0 ? 'bCircle' : ''" ng-bind="answerIsRead"></span></a></li>
							<li ng-if="questionIsRead > 0"><a href='<c:url value="/myPage/myQuestion/index.aon#/true"/>' class="tl_gText"><span ng-bind="'<spring:message code='cmm.btn.037'/>'"></span> <span ng-class="questionIsRead > 0 ? 'bCircle' : ''" ng-bind="questionIsRead"></span></a></li>
							<li class="nl_block">
	                            <button type="submit" class="btn_logout" onclick="location.href='<c:url value="/sys/login/logout.aon"/>' "><spring:message code='cmm.btn.019'/></button>
	                        </li>
	                    </ul>
                    </sec:authorize>
                    	<sec:authorize access="isAnonymous()">
	                    <form name="loginform" method="post" action="<c:url value="/securityLogin"/>?${_csrf.parameterName}=${_csrf.token}">
		                    <ul class="nav navbar-nav navbar-right nav_login">
		                        <li><a href='<c:url value="/sys/login/loginForm.aon"/>'><spring:message code='cmm.btn.006'/></a></li>
		                        <li><a href='<c:url value="/sys/member/index.aon#/emailConfirm"/>'><spring:message code='cmm.btn.020'/></a></li>
		                    </ul>
	                	</form>
                    </sec:authorize>
                </div><!-- //nav-collapse -->
            </div>
        </nav>
        <!-- //Static navbar -->
    </div>
    <!-- //header -->
    <!-- alert modal -->
	<div class="modal fade alertText" id="alertText" tabindex="-1" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-body center">
	                <p class="modalTxt1"><spring:message code='sys.msg.009'/></p>
	            </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn green" data-dismiss="modal"><spring:message code='cmm.btn.016'/></button>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- //alert modal -->   