<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">
var notice = angular.module('notice', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize','contactUs'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider)
{
	$routeProvider.when('/', {
		controller : 'NoticeListCtl',
		templateUrl : jcontext.getContextPath('/serviceInfo/notice/list.aon')
	}).when('/html/:id', {
		controller : 'NoticeHtmlCtl',
		templateUrl : function(params){return jcontext.getContextPath('/serviceInfo/' + params.id +'.aon')}
	}).otherwise({
		redirectTo : '/'
	});
});

notice.controller('NoticeListCtl', function($scope, $http, $rootScope){
	$rootScope.htmlView  = 'notice';
	var searchKey = '';
	var searchValue = '';
	$scope.searchKey = 'title';
	$scope.searchValue = '';
	$scope.item = {
			id : ''
		};
	
	var init = function(data){
		$scope.list = data.list;
		$scope.totalItems = data.count;
		if(!$scope.currentPage)
			$scope.currentPage = 1;
	}
	
	$scope.pageChanged = function() {
		var data = jcontext.loadJSON('/module/notice/listPage.json?page='+$scope.currentPage+'&searchKey='+encodeURIComponent(searchKey)+'&searchValue='+encodeURIComponent(searchValue));
		$scope.noticeView = false;
		init(data);
	};
	
	$scope.pageChanged();

	$scope.noticeView = false;
	
	function setValue(data){			
		$scope.item = data.item;
		$scope.previous = data.previous;
		$scope.next = data.next;
		$scope.noticeView = true;
		$('body').animate({
            scrollTop : $(angular.element(navi)).offset().top
        }, 500);
	}

	$scope.load = function(_id){
		var data = jcontext.loadJSON('/module/notice/read.json?id='+_id+'&searchKey='+encodeURIComponent(searchKey)+'&searchValue='+encodeURIComponent(searchValue));
		setValue(data);
		return false;
	};
	
	$scope.search = function(){
		$scope.item.id = '';
		searchKey = $scope.searchKey;
		searchValue = $scope.searchValue;
		$scope.pageChanged();
	};
	
	//엔터키 이벤트
	$scope.enterSearch = function($event){
		var keyCode = $event.which || $event.keyCode;
	    if (keyCode === 13) {
	    	$scope.search();
	    }
	}
	
})
.controller('NoticeHtmlCtl', function($rootScope, $routeParams) { 
    $rootScope.htmlView = $routeParams.id;  
    if($rootScope.htmlView == 'serviceProcess'){
	    angular.element(questionRegist).attr('href',jcontext.getContextPath('/module/contest/index.aon#/write'));
	    angular.element(pointCharge).attr('href',jcontext.getContextPath('/myPage/myPoint/index.aon#/deposit'));
	    angular.element(questionConfirm).attr('href',jcontext.getContextPath('/myPage/myAnswer/index.aon'));
	    angular.element(myQuestion).attr('href',jcontext.getContextPath('/myPage/myQuestion/index.aon'));
	    angular.element(myPoint).attr('href',jcontext.getContextPath('/myPage/myPoint/index.aon'));
    }
});  

</script>
	<!-- sub visual -->
    <%@ include file="/WEB-INF/views/serviceInfo/subVisual.jsp" %>
    <!-- //sub visual -->
		
 	<!-- contents -->
    <div class="contents" ng-app="notice">
        <div class="container">
			<div class="wrap">
                <!-- navigation -->
                <nav> 
                    <ul class="navi" id="navi">
                        <li><a href='<c:url value="/index.aon"/>'><spring:message code='cmm.nav.001'/></a></li>
                        <li><a href='<c:url value="#/html/aboutUs"/>'><spring:message code='cmm.menu.002'/></a></li>
						<li ng-show="htmlView == 'aboutUs'"><spring:message code='cmm.menu.003'/></li> 
                        <li ng-show="htmlView == 'serviceProcess'"><spring:message code='cmm.menu.004'/></li> 
                        <li ng-show="htmlView == 'userAgreement'"><spring:message code='cmm.menu.005'/></li> 
                        <li ng-show="htmlView == 'personalInfo'"><spring:message code='cmm.menu.006'/></li> 
                        <li ng-show="htmlView == 'notice'"><spring:message code='cmm.menu.007'/></li>  
                    </ul>
                </nav>
                <!-- //navigation -->
	
				<!-- sub_con -->
	        	<div ng-view></div>
	        	<!-- //sub_con -->
				<!-- right_menu -->
	            <div class="sub_aside">
	                <div class="rm_top">
                        <h2><spring:message code='cmm.menu.002'/></h2>
                        <ul class="right_menu">
							<li ng-class="htmlView == 'aboutUs' ? 'on' : ''"><a href='<c:url value="#/html/aboutUs"/>'><spring:message code='cmm.menu.003'/></a></li> 
                            <li ng-class="htmlView == 'serviceProcess' ? 'on' : ''"><a href='<c:url value="#/html/serviceProcess"/>'><spring:message code='cmm.menu.004'/></a></li> 
                            <li ng-class="htmlView == 'userAgreement' ? 'on' : ''"><a href='<c:url value="#/html/userAgreement"/>'><spring:message code='cmm.menu.005'/></a></li> 
                            <li ng-class="htmlView == 'personalInfo' ? 'on' : ''"><a href='<c:url value="#/html/personalInfo"/>'><spring:message code='cmm.menu.006'/></a></li> 
                            <li ng-class="htmlView == 'notice' ? 'on' : ''"><a href='<c:url value="#/list"/>'><spring:message code='cmm.menu.007'/></a></li>  
                        </ul>
                    </div>
	                <%@ include file="/WEB-INF/views/include/contactUs.jsp" %>
	            </div>
	            <!-- //right_menu -->
			</div>
        </div>
    </div>
    <!-- //contents --> 
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
