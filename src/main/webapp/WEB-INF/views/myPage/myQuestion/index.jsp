<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<script type="text/javascript">
var question = angular.module('question', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'ngSanitize','contactUs','Filters'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider)
{
	$routeProvider.when('/', {
		controller : 'QuestionListCtl',
		templateUrl : jcontext.getContextPath('/myPage/myQuestion/list.aon')
	}).when('/:unconfirmed', {
		controller : 'QuestionListCtl',
		templateUrl : jcontext.getContextPath('/myPage/myQuestion/list.aon')
	}).when('/view/:id', {
		controller : 'QuestionViewCtl',
		templateUrl : jcontext.getContextPath('/myPage/myQuestion/view.aon')
	}).when('/allView/:groupId/:id', {
		controller : 'QuestionAllViewCtl',
		templateUrl : jcontext.getContextPath('/myPage/myQuestion/allView.aon')
	}).otherwise({
		redirectTo : '/'
	});
});

question.controller('QuestionListCtl', function($scope, $routeParams, $rootScope){
	var searchKey = '';
	var searchValue = '';
	$scope.searchKey = 'title';
	$scope.searchValue = '';

	var unconfirmed = true;
	if($routeParams.unconfirmed == undefined){
		unconfirmed = false;
	}
	
	// 검색어 유지
	if($rootScope.searchValue != undefined && $rootScope.searchValue != ''){
		$scope.searchKey = $rootScope.searchKey;
		$scope.searchValue = $rootScope.searchValue;
	}
	
	var init = function(data){
		$scope.list = data.list;
		$scope.totalItems = data.count;
		if(!$rootScope.currentPage)
			$scope.currentPage = 1;
	}
	
	$scope.pageChanged = function() {
		$rootScope.currentPage = $scope.currentPage;
		var data = jcontext.loadJSON('/module/contest/myList.json?page='+$scope.currentPage+'&searchKey='+encodeURIComponent(searchKey)+'&searchValue='+encodeURIComponent(searchValue)+'&unconfirmed='+unconfirmed);
		init(data);
	};
	
	function setValue(data){			
		$scope.item = data.item;
		$scope.previous = data.previous;
		$scope.next = data.next;
	}
	
	$scope.search = function(){
		searchKey = $scope.searchKey;
		searchValue = $scope.searchValue;
		$rootScope.searchKey = searchKey;
		$rootScope.searchValue = searchValue;
		$scope.pageChanged();
	};
	
	//엔터키 이벤트
	$scope.enterSearch = function($event){
		var keyCode = $event.which || $event.keyCode;
	    if (keyCode === 13) {
	    	$scope.search();
	    }
	}
	
	$scope.search();
})
.controller('QuestionViewCtl', function($scope, $routeParams, $location, $window){
	function setValue(data){			
		$scope.item = data.item;
		$scope.replyList = data.replyList;
		$scope.choosedCount = data.choosedCount;
		$scope.totalItems = data.count;
		var strNoGrade = i18n.getLang('contest','noGrade');
		var strPoint = i18n.getLang('contest','point');
		$scope.gradePoints = [
						{id:0, name:strNoGrade},      
						{id:1, name:'1'+strPoint},
						{id:2, name:'2'+strPoint},
						{id:3, name:'3'+strPoint},
						{id:4, name:'4'+strPoint},
						{id:5, name:'5'+strPoint},
						{id:6, name:'6'+strPoint},
						{id:7, name:'7'+strPoint},
						{id:8, name:'8'+strPoint},
						{id:9, name:'9'+strPoint},
						{id:10, name:'10'+strPoint}];
	}

	$scope.load = function(_id) {
		$scope.rightShow = false;
		var data = jcontext.loadJSON('/module/contest/questionRead.json?id='+_id);
		setValue(data);
	};
	
	$scope.load($routeParams.id);
	
	$scope.openCancel = function(){ 
		$(angular.element(cancelQ)[0]).modal(); 
	} 
	
	$scope.distribute = function() {
		$scope.choosedAnswerList = jcontext.loadJSON('/module/contest/answerListByContest.json?id='+$routeParams.id).choosedAnswerList;
	}
	
	$scope.tempAnswer = null;
	
	$scope.showAnswer = function(_answer) {
		$scope.tempAnswer = _answer;
		$scope.allBychoosedAnswer = jcontext.loadJSON('/module/contest/allListByChoosedAnswer.json?id='+_answer.id+'&groupId='+$routeParams.id).allBychoosedAnswer;
		$scope.rightShow = true;
	}
	
	$scope.gradePointSubmit = function(_id, _gradePoint){
		jcontext.jsonAction('/module/contest/gradePoint.json?id='+_id+'&gradePoint='+_gradePoint, '', 
			{message:i18n.getLang('common','register')}
		);
		$scope.tempAnswer.gradePoint = _gradePoint;
	}
	
	$scope.completeChoose = function() {
		jcontext.jsonAction('/module/contest/completeChoose.json?groupId='+$routeParams.id, '', 
				{message:i18n.getLang('contest','completeChoose')}
			);
		$(angular.element(appraisal)[0]).modal('hide');
		$location.path('/');
	}
	
	$scope.cancelSubmit = function(){
		if($scope.cForm.$valid){
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($("form[name*='cForm']"),'/module/contest/cancel.json',
				{message:i18n.getLang('common','cancel')
					,callback: function(data){
						$scope.$apply(function() {
							$(angular.element(cancelQ)[0]).modal('hide');
							$location.path('/');
						});
					}
				},{ message:i18n.getLang('common','error')
					,callback: function(e){
						alert(e.status);
					}
				}
			);
		} else {
			return false;
		}
	}
	
	$scope.historyBack = function(){
		$window.history.back()
	}
	
	$scope.postNewsfeed = function(){
		var url = jcontext.getLocationPath('/module/contest/index.aon#/snsView/' + $routeParams.id);
		FB.ui({
		  	method: 'feed',
		    display: 'popup',
		    name: $scope.item.title,
		    link: url,
		    picture : 'https://' + i18n.getLang('common','whatinfoDomain') + '/resources/images/sub/whatinfo.jpg',
		    caption: i18n.getLang('common','whatinfoDomain'),
		    description: $scope.item.content.replace(/(<|<\/).*?>/gi,'')
		}, function(response){});
	}
	$scope.postTwitter = function(){
		var url = encodeURIComponent(jcontext.getLocationPath('/module/contest/index.aon#/snsView/' + $routeParams.id));
		window.open("https://twitter.com/intent/tweet?text=" + $scope.item.content.replace(/(<|<\/).*?>/gi,'') + "&url=" + url, "Twitter", "width=800, height=400, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	}
})
.controller('QuestionAllViewCtl', function($scope, $routeParams, $route, $location, $window){
	$scope.writeForm = false;
	$scope.favorite = false;
	
	function setValue(data){			
		$scope.item = data.item;
		$scope.replyList = data.replyList;
		$scope.canChoose = data.canChoose;
		$scope.favorite = data.replyList[0].favorite;
		var strNoGrade = i18n.getLang('contest','noGrade');
		var strPoint = i18n.getLang('contest','point');
		$scope.gradePoints = [
						{id:0, name:strNoGrade},      
						{id:1, name:'1'+strPoint},
						{id:2, name:'2'+strPoint},
						{id:3, name:'3'+strPoint},
						{id:4, name:'4'+strPoint},
						{id:5, name:'5'+strPoint},
						{id:6, name:'6'+strPoint},
						{id:7, name:'7'+strPoint},
						{id:8, name:'8'+strPoint},
						{id:9, name:'9'+strPoint},
						{id:10, name:'10'+strPoint}];
	}

	$scope.load = function(_groupId, _id) {
		var data = jcontext.loadJSON('/module/contest/questionAllRead.json?groupId=' + _groupId + '&id='+_id);
		setValue(data);
	};
	
	$scope.load($routeParams.groupId, $routeParams.id);
	
	$scope.addReply = function(groupId, parentId, answerGroupId, title){
		$scope.writeForm = true;
		$scope.title = '[Q]' + groupId;
		$scope.parentId = parentId;
		$scope.groupId = groupId;
		$scope.answerGroupId = answerGroupId;
		$('body').animate({
            scrollTop : $(angular.element(addReply)).offset().top
        }, 500);
	}
	
	jcontext.loadJSON('/module/contest/isRead.json?groupId='+$routeParams.groupId+'&id='+$routeParams.id+'&mode=Q');
	
	$scope.questionSubmit = function(){
		if($scope.mForm.$valid){
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($("form[name*='mForm']"),'/module/contest/register.json',
				{message:i18n.getLang('common','register')
					,callback: function(data){
						$scope.$apply(function() {
							//$location.path('/view/'+$routeParams.groupId);
							$scope.writeForm = false;
							$scope.load($routeParams.groupId, $routeParams.id);
							//$route.reload();
						});
					}
				},{ message:i18n.getLang('common','error')
					,callback: function(e){
						alert(e.status);
					}
				}
			);
		} else {
			return false;
		}
	}
	
	$scope.questionCancel = function(){
		$route.reload(); // 임시
		$scope.writeForm = false;
		//$scope.content = '';
		angular.element(attachments).html('');
		var _html = '';
		_html += '<button type="button" class="btn btn-primary ng-binding" style="position:relative; overflow:hidden;">';
		_html += i18n.getLang('contest','addFile');
		_html += '<input type="file" style="position:absolute; top:0; right:0; height:100%; opacity:0; filter: alpha(opacity=0);" onclick="angular.element(this).scope().files.doClickFile()" onchange="angular.element(this).scope().files.doAddFile(this)">';
		_html += '</button>';
		angular.element(attachmentsFile).html(_html);
	}
	
	$scope.gradePointSubmit = function(_id, _gradePoint){
		jcontext.jsonAction('/module/contest/gradePoint.json?id='+_id+'&gradePoint='+_gradePoint, '', 
			{message:i18n.getLang('common','register')}
		);
	}
	
	$scope.favoriteToggle = function(_id, _favorite){
		jcontext.jsonAction('/module/contest/favorite.json?id='+_id+'&favorite='+_favorite, '', 
			{message:i18n.getLang('common','register')
				,callback: function(data){
					$scope.favorite = _favorite;
				}
			}
		);
	}
	
	$scope.clauseAgree2 = false;
	
	$scope.openAgree = function(){ 
		$(angular.element(adoptA)[0]).modal();
		if($scope.clauseAgree2){
			$(angular.element(clauseAgree2)).click();
			$scope.clauseAgree2 = false;
		}
	}  
	
	$scope.clauseAgreeClick = function(){
		if($scope.clauseAgree2){
			$scope.clauseAgree2 = false;
		}else{
			$scope.clauseAgree2 = true;
		}
	}
	
	$scope.clauseAgree = function(_groupId, _id){
		jcontext.jsonAction('/module/contest/clauseAgree.json?id='+_id+'&groupId='+_groupId, '', 
			{message:i18n.getLang('contest','choose')
				,callback: function(data){
					$scope.item.choose = true;
					$scope.item.status = 3000;
					$scope.replyList[0].choose = true;
				}
			}
		);
		$(angular.element(adoptA)[0]).modal('hide');
	}
	
	$scope.cancelReason = '';

	$scope.openCancel = function(){
		$scope.cancelReason = '';
		$(angular.element(cancelQ)[0]).modal(); 
	} 
	
	$scope.cancelSubmit = function(){
		if($scope.cForm.$valid){
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($("form[name*='cForm']"),'/module/contest/cancel.json',
				{message:i18n.getLang('common','cancel')
					,callback: function(data){
						$scope.$apply(function() {
							$(angular.element(cancelQ)[0]).modal('hide');
							$location.path('/');
						});
					}
				},{ message:i18n.getLang('common','error')
					,callback: function(e){
						alert(e.status);
					}
				}
			);
		} else {
			return false;
		}
	}
	
	$scope.postNewsfeed = function(){
		var url = jcontext.getLocationPath('/module/contest/index.aon#/snsView/' + $routeParams.groupId);
		FB.ui({
		  	method: 'feed',
		    display: 'popup',
		    name: $scope.item.title,
		    link: url,
		    picture : 'https://' + i18n.getLang('common','whatinfoDomain') + '/resources/images/sub/whatinfo.jpg',
		    caption: i18n.getLang('common','whatinfoDomain'),
		    description: $scope.item.content.replace(/(<|<\/).*?>/gi,'')
		}, function(response){});
	}
	$scope.postTwitter = function(){
		var url = encodeURIComponent(jcontext.getLocationPath('/module/contest/index.aon#/snsView/' + $routeParams.groupId));
		window.open("https://twitter.com/intent/tweet?text=" + $scope.item.content.replace(/(<|<\/).*?>/gi,'') + "&url=" + url, "Twitter", "width=800, height=400, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	}
	
	$scope.historyBack = function(){
		$window.history.back()
	}
})
.directive('replyFile', function() {
	return {
		template : '<div class="info_file"><strong class="if_tit">'+i18n.getLang('contest','attachment')+'</strong>\
	            <ul class="if_list">\
				</ul>\
        	</div>',
		link : {
			post : function(scope, element, attrs){
				element.ready(function () {
					var data = jcontext.loadJSON('/module/contest/readFile.json?id='+attrs.id);
					if(data.item.length > 0){
						for(i=0; i < data.item.length; i++){
							var _html = '';
							_html += '<li><p><a href="<c:url value="/module/contest/download.aon?id="/>'+data.item[i].id+'">';
							_html += data.item[i].filename;
							_html += '</a> (';
							_html += (data.item[i].filesize/1024)+(1-((data.item[i].filesize/1024)%1)%1);
							_html += ' KB)</p></li>';
							element.find('ul').append(_html);	
						}
					}else{
						element.remove();
					}
				});
			}
		}
	}
})
.directive('listContest', function() {
	return function(scope, element, attrs) {
		if(scope.$last){
			element.ready(function () {
				$(".el_txt").dotdotdot({
					watch: "window"
				});
			});
		}
	};
});

</script>
	<!-- sub visual -->
    <%@ include file="/WEB-INF/views/myPage/subVisual.jsp" %>
    <!-- //sub visual -->
		
 	<!-- contents -->
    <div class="contents" ng-app="question">
        <div class="container">
			<div class="wrap">
                <!-- navigation -->
                <nav> 
                    <ul class="navi">
                        <li><a href='<c:url value="/index.aon"/>'><spring:message code='cmm.nav.001'/></a></li>
                        <li><a href='<c:url value="/myPage/myInfo/index.aon"/>'><spring:message code='cmm.menu.010'/></a></li>
                        <li><spring:message code='cmm.menu.012'/></li>
                    </ul>
                </nav>
                <!-- //navigation -->
	
				<!-- sub_con -->
	        	<div ng-view></div>
	        	<!-- //sub_con -->
				<!-- right_menu -->
	            <div class="sub_aside">
	                <div class="rm_top">
                        <h2><spring:message code='cmm.menu.010'/></h2>
                        <ul class="right_menu">
                        	<li><a href='<c:url value="/myPage/myInfo/index.aon"/>'><spring:message code='cmm.menu.011'/></a></li>
                            <li class="on"><a href='<c:url value="#/"/>'><spring:message code='cmm.menu.012'/></a></li>
                            <li><a href='<c:url value="/myPage/myAnswer/index.aon"/>'><spring:message code='cmm.menu.013'/></a></li>
                            <li><a href='<c:url value="/myPage/myPoint/index.aon"/>'><spring:message code='cmm.menu.014'/></a></li>
                            <li><a href='<c:url value="/myPage/member/index.aon"/>'><spring:message code='cmm.menu.015'/></a></li>
                            <li><a href='<c:url value="/myPage/member/index.aon#/memberUpdateProfileForm"/>'><spring:message code='cmm.menu.017'/></a></li>
                            <li><a href='<c:url value="/myPage/drop/index.aon"/>'><spring:message code='cmm.menu.016'/></a></li>
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
