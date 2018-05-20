<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<link rel="stylesheet" href="<%=getServletContext().getContextPath() %>/resources/css/sweetalert.css">
<script src="<%= request.getContextPath() %>/resources/js/aon.range.slider.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/sweetalert.min.js"></script>
<script type="text/javascript">
var contest = angular.module('Contest', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'aon.range.slider', 'ngSanitize','contactUs', 'Filters'])
.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common = { 'Accept': 'text/html, text/ng-template' };
})
.config(function($routeProvider)
{
	$routeProvider.when('/list', {
		controller : 'ContestListCtl',
		templateUrl : jcontext.getContextPath('/module/contest/list.aon')
	}).when('/list/:catSeq', {
		controller : 'ContestListCtl',
		templateUrl : jcontext.getContextPath('/module/contest/list.aon')
	}).when('/view/:id', {
		controller : 'ContestReadCtl',
		templateUrl : jcontext.getContextPath('/module/contest/view.aon')
	}).when('/snsView/:id', {
		controller : 'ContestSnsReadCtl',
		templateUrl : jcontext.getContextPath('/module/contest/snsView.aon')
	}).when('/write', {
		controller : 'ContestWriteCtl',
		templateUrl : jcontext.getContextPath('/module/contest/write.aon')
	}).otherwise({
		redirectTo : '/list'
	});
});

contest.controller('CategoryListCtl', function($scope, $rootScope) {
	var init = function(data){
		$scope.list = data.list;
		$rootScope.categoryList = data.list;
	}
	var data = jcontext.loadJSON('/module/contest/categoryList.json');
	init(data);
})
.controller('ContestListCtl', function($scope, $routeParams, $rootScope, $location) {
	var searchKey = '';
	var searchValue = '';
	var catSeq = $routeParams.catSeq;
	$rootScope.catView  = catSeq;
	
	if(catSeq == undefined){
		catSeq = 0;
		$rootScope.naviCategory = '';
	}
	
	if(catSeq != 0){
		for(var i=0; i<$rootScope.categoryList.length; i++){
			if ($rootScope.categoryList[i][0] == $rootScope.catView) {
				$rootScope.naviCategory = $rootScope.categoryList[i][3];
			}
		}
	}
	
	$scope.searchKey = 'title';
	$scope.searchValue = '';
	
	// 검색어 유지
	if($rootScope.searchValue != undefined && $rootScope.searchValue != '' && $routeParams.catSeq == undefined){
		$scope.searchKey = $rootScope.searchKey;
		$scope.searchValue = $rootScope.searchValue;
		searchKey = $scope.searchKey;
		searchValue = $scope.searchValue;
	}
	
	var init = function(data){
		$scope.list = data.list;
		$scope.totalItems = data.count;
		if(!$rootScope.currentPage)
			$scope.currentPage = 1;
	}
	
	$scope.pageChanged = function() {
		//alert(catSeq);
		$rootScope.currentPage = $scope.currentPage;
		var data = jcontext.loadJSON('/module/contest/list.json?page='+$scope.currentPage+'&searchKey='+encodeURIComponent(searchKey)+'&searchValue='+encodeURIComponent(searchValue)+'&catSeq='+catSeq);
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
		if($location.path() == '/list'){
			$scope.pageChanged();
		}else{
			$location.path('/list');	
		}
	};
	
	//엔터키 이벤트
	$scope.enterSearch = function($event){
		var keyCode = $event.which || $event.keyCode;
	    if (keyCode === 13) {
	    	$scope.search();
	    }
	}
	
	$scope.pageChanged();
})
.controller('ContestWriteCtl', function($scope, $location){
	$scope.depth = '';
 	$scope.depth1 = '0';
 	$scope.depth2 = '0';
 	$scope.depthShow = false;
 	$scope.tagShow = false;
	$scope.point = 0;
	
	$scope.zeroPoint = true;
	$scope.simpleAfter = true;
	
	$scope.item = [];
	$scope.item.chooseCount = 0;
	$scope.item.point = 0;
	$scope.item.pointRatio = ''; 
	
	$scope.writeSimpleSubmit = function(pointSimple){
		$scope.simpleAfter = false;
		$(angular.element(writeSimple)[0]).modal('hide');
		$(angular.element).find('input[name=point]').val(pointSimple);
		if(data.cyberAccount.balance < $(angular.element).find('input[name=point]').val()) {
			$scope.zeroPoint = false;
			$scope.$apply(function() {
				$scope.point = data.cyberAccount.balance;
			});
			$(angular.element(noPoint)[0]).modal();
			$(angular.element(noPoint)[0]).on('hidden.bs.modal', function() {
				$scope.$apply(function() {
					$location.path("/list");
				});
			});
		}
	}
	
	$scope.goList = function(){
		if($scope.simpleAfter){
			$scope.$apply(function() {
				$location.path("/list");
			});	
		}
	}
	
	var categoryData = jcontext.loadJSON('/sys/category/getListByParent.json?pid=whatinfo');
	$scope.categoryList = categoryData.list;
	
	$scope.categoryChange = function(){
		$(angular.element).find('#depth1').tooltip('hide');
		if ($scope.depth1 != '0') {
			$scope.depth2 = '0';
			$scope.tag = '';
			$scope.tagShow = false;
			var subCategory = jcontext.loadJSON('/sys/category/getListByParent.json?pid='+$scope.depth1);
			$scope.subCategoryList = subCategory.list;
			if($scope.subCategoryList.length > 0){
				$scope.depthShow = true;
				$scope.depth = '';
			}else{
				$scope.depthShow = false;
				$scope.depth = $scope.depth1;
			}
		}else{
			$scope.depthShow = false;
			$scope.tagShow = false;
			$scope.depth2 = '0';
		}
	}
	
	$scope.subChange = function() {
		var selectText = $('#depth2 option:checked').text();
		var compareText = i18n.getLang('category','etc');
		$(angular.element).find('#depth2').tooltip('hide');
		if ($scope.depth2 != '0') {
			if (selectText == compareText)	{
				$scope.tag = '';
				$scope.tagShow = true;
			} else {
				$scope.tag = '';
				$scope.tagShow = false;
			}
			$scope.depth = $scope.depth2;
		} else {
			$scope.depth = '';
			$scope.tagShow = false;
			$scope.depth2 = '0';
			$scope.tag = '';
		}
	}
	
	$scope.registCheck = false;
	
	$scope.submit = function(){
		if(!$scope.registCheck) {
			$(angular.element(registCheck)[0]).focus();
			new PageAlert({'type':'success','title':' ','message':i18n.getLang('contest','questionAgreeCheck')});
			return false;
		}
		
		if ($scope.depth1 == '0') {
			$(angular.element).find('#depth1').focus();
			$(angular.element).find('#depth1').tooltip('show');
			return false;
		} else if ($scope.depth2 == '0' && $scope.subCategoryList.length > 0) {
			$(angular.element).find('#depth2').focus();
			$(angular.element).find('#depth2').tooltip('show');
			return false;
		}
		
		if ($scope.tagShow && $scope.tag.length == 0) {
			$(angular.element).find('#tag').focus();
			$(angular.element).find('#tag').tooltip('show');
			return false;
		}
		
		if(data.cyberAccount.balance < $scope.item.point) {
			$scope.zeroPoint = false;
			$scope.point = data.cyberAccount.balance;
			$(angular.element(noPoint)[0]).modal();
			$(angular.element(noPoint)[0]).on('hidden.bs.modal', function() {
				$scope.$apply(function() {
					$location.path("/list");
				});
			});
		}else{
			$(angular.element).find('input[name=point]').val($scope.item.point);
			if($scope.contestWriteForm.$valid){
				$scope.$broadcast('SUBMIT');
				jcontext.formSubmit($('form[name=contestWriteForm]'),'/module/contest/register.json',
					  	 {message:i18n.getLang('contest','submitSuccess')
					     ,callback: function(data){
						  			 $scope.$apply(function() {
						  				$(angular.element(noPoint)[0]).modal('hide');
						        		$location.path("/list");
						  			  });
					  			    }
					   	}
					   ,{ message:i18n.getLang('contest','submitFail'),
						  callback: function(e){
							  alert(e.status);
						   }
						}
					);
			} else {
				return false;
			}
		}	
	}
	
	angular.element(document).ready(function(){
		$('#title,#point').off().on('click', function(){
   			$('#memberArea').show();
    	});
	});
	
	/**
     * 분배 적용 버튼 이벤트
     * 
     * @returns
     */
    $scope.distribution = function(){
      var point = $('#point').val();
      var member = $('#member').val();
      
      // 인원 10명 이상일때 문구
      if(member > 10){
        //toastr.warning('포인트 분배 인원은 최대 10명입니다.');
        swal('Caution!', i18n.getLang('contest','pointDivision'), 'warning');
        return false;
      } else {
        $('.mpb_slider').show();
        $('.mpb_message').show();
        $('#slider-area').show();
        
        // var result = member+'명에게 '+(point / member)+'포인트씩 지급됩니다.';
        // $('#output').text(result);
        // $('.output').show();

        /*
        $scope.$apply(function(){
          $scope.initFlg = false;
          $scope.otherProbs = [];
        });

        var result2 = 100 / member;
        for(var i = 0; i < member; i++){
          $scope.$apply(function(){
            $scope.otherProbs.push(result2);
          });
        }
        */
        
        $scope.safeApply(function(){
        	$scope.initFlg = false;
            $scope.otherProbs = [];
        });
        
        var result2 = 100 / member;
        if((100 % member) == 0){
	        for(var i = 0; i < member; i++){
	          $scope.safeApply(function(){
	            $scope.otherProbs.push(result2);
	          });
	        }
        } else {
        	for(var i = 0; i < member; i++){
        		if(i == (member - 1)){
        			var lastVal = 100 - (result2.toFixed(1) * (member - 1));
        			$scope.safeApply(function(){
         	            $scope.otherProbs.push(lastVal.toFixed(1) * 1);
         	        });
        		} else {
        			$scope.safeApply(function(){
         	            $scope.otherProbs.push(result2.toFixed(1) * 1);
         	        });
        		}
  	        }
        }
        
        console.log($scope.otherProbs);
      }
    };
    
    $scope.safeApply = function(fn){
		var phase = this.$root.$$phase;
		if(phase == '$apply' || phase == '$digest')
			this.$eval(fn);
		else
			this.$apply(fn);
    };

    /**
     * 결과보기 버튼 이벤트
     */
    $scope.viewResult = function(){
      console.log('result');
      $('.output').show();
    };

    // 슬라이드 좌표를 위한 퍼센트 모델
    //$scope.otherProbs = [20, 20, 20, 20, 20];
    $scope.otherProbs = [];

    // backend로 전달할 포인트를 분배한 실제 모델
    $scope.pointData = [];

//     $scope.init();
	$scope.receive = function(data, correction, returnPoint, title, pointSimple, chooseCount, equal){
		console.log(data);
		console.log(correction);
		console.log(returnPoint);
		console.log(title);
		console.log(pointSimple);
		console.log(chooseCount);
		console.log(equal);
		$scope.safeApply(function(){
			$scope.item.title = title;
			$scope.item.chooseCount = chooseCount;
			$scope.item.point = pointSimple;
			$scope.item.pointRatio = '{"data":' + JSON.stringify(data) + ',"correction":' + correction +',"return":' + returnPoint + ', "equal":' + equal + '}';
		});
		$scope.writeSimpleSubmit(pointSimple);
	};
	
	<sec:authorize access="isAuthenticated()">
	var data = jcontext.loadJSON('/module/cyberAccount/read.json');
	
	if(data.length != 0){
		<%
		String data = null;
		String correction = null;
		String returnPoint = null;
		String title = null;
		String pointSimple = null;
		String chooseCount = null;
		String equal = null;
		
		if(request.getParameter("data") != null){
			data = request.getParameter("data");
			correction = request.getParameter("correction");
			returnPoint = request.getParameter("returnPoint");
			title =  request.getParameter("title");
			pointSimple = request.getParameter("pointSimple");
			chooseCount = request.getParameter("chooseCount");
			equal = request.getParameter("equal");
		}
		%>
		
		if(data.cyberAccount.balance < 1) {
			$(angular.element(noPoint)[0]).modal();
			$(angular.element(noPoint)[0]).on('hidden.bs.modal', function() {
				$scope.$apply(function() {
					$location.path("/list");
				});
			});
		}else{
			<% if (data != null) { %>
				$scope.receive(jQuery.parseJSON('<%=data%>'.replace(/&quot;/g, '"')), <%=correction%>, <%=returnPoint%>, '<%=title%>', '<%=pointSimple%>', '<%=chooseCount%>', <%=equal%>);
			<% } else { %>
			$(angular.element(writeSimple)[0]).modal();
			$(angular.element(writeSimple)[0]).on('hidden.bs.modal', function() {
				$scope.goList();
			});
			<% } %>
		}
	};
	</sec:authorize>
})
.controller('ContestReadCtl', function($window, $scope, $location, $routeParams, $route, $window) {
	$('body').animate({
        scrollTop : $(angular.element(header)).offset().top
    }, 500);
	
	function setValue(data){			
		$scope.item = data.item;
	}

	$scope.load = function(id) {
		var data = jcontext.loadJSON('/module/contest/read.json?id='+id);
		if (data.isOwner) {
			$window.location.replace('<c:url value="/myPage/myQuestion/index.aon#/view/'+id+'"/>');
		} else if (data.isAnswer) {
			$window.location.replace('<c:url value="/myPage/myAnswer/index.aon#/view/'+id+'"/>');
		} else {
			setValue(data);
			$scope.contestBtn = true;
			$scope.answerView = false;			
		}
	};
	
	$scope.load($routeParams.id);
	
	$scope.answerCheck = false;
	
	$scope.cancelAnswerLayer = function(){
		$route.reload(); // 임시
		$scope.contestBtn = true;
		$scope.answerView = false;
		$scope.title = '';
		//$scope.content = '';
		angular.element(attachments).html('');
		var _html = '';
			_html += '<button type="button" class="btn btn-primary ng-binding" style="position:relative; overflow:hidden;">';
			_html += i18n.getLang('contest','addFile');
			_html += '<input type="file" style="position:absolute; top:0; right:0; height:100%; opacity:0; filter: alpha(opacity=0);" onclick="angular.element(this).scope().files.doClickFile()" onchange="angular.element(this).scope().files.doAddFile(this)">';
			_html += '</button>';
		angular.element(attachmentsFile).html(_html);
	}
	
	$scope.openAnswerLayer = function(){
		if(!$scope.answerCheck) {
			$(angular.element(answerCheck)[0]).focus();
			new PageAlert({'type':'success','title':'','message':i18n.getLang('contest','answerAgreeCheck')});
 			return false;
 		}
		
		if($scope.answerWriteForm.$valid){
			$(angular.element(confirmA)[0]).modal();
		}
	}
	
	$scope.answerCompleate = true;
	
	$scope.answerSubmit = function(){
		if($scope.answerWriteForm.$valid){
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($("form[name*='answerWriteForm']"),'/module/contest/register.json',
				{message:i18n.getLang('contest','submitSuccess')
					,callback: function(data){
						$scope.$apply(function() {
							$route.reload();
						});
					}
				},{ message:i18n.getLang('contest','submitFail')
					,callback: function(e){
						alert(e.status);
					}
				}
			);
		} else {
			return false;
		}
	}
	
	$scope.goAnswer = function() {
		$scope.contestBtn = false;
		$scope.answerView = true;
	}

	$scope.openReport = function(){ 
		$(angular.element(reportA)[0]).modal(); 
	}  
	
	$scope.sendReport = function(){
		if($scope.reportForm.$valid){
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($("form[name*='reportForm']"),'/module/contest/report/sendReport.json',
				{message:i18n.getLang('contest','process')
					,callback: function(data){
						$scope.$apply(function() {
							$(angular.element(reportA)[0]).modal('hide');
							$route.reload();
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
		var url = jcontext.getLocationPath('/module/contest/index.aon#/snsView/' + $routeParams.id);
		FB.ui({
		  	method: 'feed',
		    display: 'popup',
		    name: $scope.item.title,
		    link: jcontext.getLocationPath('/module/contest/index.aon#/snsView/' + $routeParams.id),
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
.controller('ContestSnsReadCtl', function($window, $scope, $location, $routeParams, $route, $window) {
	$('body').animate({
        scrollTop : $(angular.element(header)).offset().top
    }, 500);
	
	function setValue(data){			
		$scope.item = data.item;
	}

	$scope.load = function(id) {
		var data = jcontext.loadJSON('/module/contest/snsRead.json?id='+id);
		
		if(data.isLogin){
			$window.location.replace('<c:url value="/module/contest/index.aon#/view/'+id+'"/>');
		} else if (data.isOwner) {
			$window.location.replace('<c:url value="/myPage/myQuestion/index.aon#/view/'+id+'"/>');
		} else if (data.isAnswer) {
			$window.location.replace('<c:url value="/myPage/myAnswer/index.aon#/view/'+id+'"/>');
		} else {
			setValue(data);
		}
	};
	$scope.load($routeParams.id);
	
	//$scope.item.status = 4200
	switch($scope.item.status){
		case 3000 :
			$scope.messageForSns = i18n.getLang('contest', 'contestComplete');
			$('#noMember').modal('show');
			break;
		case 4000 :
			$scope.messageForSns = i18n.getLang('contest', 'contestExpired');
			$('#noMember').modal('show');
			break;
		case 4200 :
			$scope.messageForSns = i18n.getLang('contest', 'contestCancel');
			$('#noMember').modal('show');
			break;
		default : 
			break;
	}
	
	$scope.goList = function(){
		$location.path("/list");
	}
	
	$scope.goAnswer = function() {
		$window.location.replace('<c:url value="/module/contest/index.aon#/view/'+$routeParams.id+'"/>');
	}

	$scope.openReport = function(){ 
		$(angular.element(reportA)[0]).modal(); 
	}  
	$scope.sendReport = function(){
		if($scope.reportForm.$valid){
			$scope.$broadcast('SUBMIT');
			jcontext.formSubmit($("form[name*='reportForm']"),'/module/contest/report/sendReport.json',
				{message:i18n.getLang('contest','process')
					,callback: function(data){
						$scope.$apply(function() {
							$(angular.element(reportA)[0]).modal('hide');
							$route.reload();
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
		FB.ui({
		  	method: 'feed',
		    display: 'popup',
		    name: $scope.item.title,
		    link: location.href,
		    picture : 'https://' + i18n.getLang('common','whatinfoDomain') + '/resources/images/sub/whatinfo.jpg',
		    caption: i18n.getLang('common','whatinfoDomain'),
		    description: $scope.item.content.replace(/(<|<\/).*?>/gi,'')
		}, function(response){});
	}
	$scope.postTwitter = function(){
		window.open("https://twitter.com/intent/tweet?text=" + $scope.item.content.replace(/(<|<\/).*?>/gi,'') + "&url=" + encodeURIComponent(location.href), "Twitter", "width=800, height=400, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
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
    <div class="sub_visual sVisual5">
        <div class="wrap">
            <h2><spring:message code='cmm.menu.008'/></h2>
            <p class="sV_title"><spring:message code='cts.msg.014'/></p>
            <!-- <div class="sV_sns">
                <ul class="icon_sns">
                    <li><a href="#" class="sns_fb">facebook</a></li>
                    <li><a href="#" class="sns_tw">twitter</a></li>
                    <li><a href="#" class="sns_ins">instagram</a></li>
                </ul>
            </div> -->
        </div>        
    </div>
    <!-- //sub visual -->
		
 	<!-- contents -->
    <div class="contents" ng-app="Contest">
    
    
    	<head>	    
			<meta name="og:title" content="OAASYS 2.0"/>
			<meta name="og:type" content="article"/>
			<meta name="og:image" content="http://www.oaasys.com/img/common/oaasys.gif"/>
			<meta name="og:description" content="Product Description"/>
			<meta name="fb:app_id" content="1285874574776184"/>
		</head>
    	
        <div class="container">        
            <div class="wrap">
                <!-- navigation -->
                <nav>
                    <ul class="navi" id="navi">
                        <li><a href='<c:url value="/index.aon"/>'><spring:message code='cmm.nav.001'/></a></li>
                        <li><a href='<c:url value="#/list/0"/>'><spring:message code='cts.nav.001'/></a></li>
                        <li>{{naviCategory | ctgrLang}}</li>
                    </ul>
                </nav>
                <!-- //navigation -->
	
				<!-- sub_con -->
				<div ng-view></div>
				<!-- //sub_con -->
				<!-- right_menu -->
	            <div class="sub_aside">
                    <div class="rm_top" ng-controller="CategoryListCtl">
                        <h2><spring:message code='cts.lbl.010'/></h2>
                        <ul class="right_menu">
                            <li ng-repeat="category in categoryList" ng-class="catView == category[0] ? 'on' : ''">
                            	<a href='<c:url value="#/list/{{category[0]}}"/>'>{{category[3] | ctgrLang}}({{category[4]}})</a>
                            </li>
                        </ul> 
                    </div>
	                <%@ include file="/WEB-INF/views/include/contactUs.jsp" %>                           
	            </div>
	            <!-- //right_menu -->
			</div>
        </div>
    </div>
    <!-- //contents --> 
    <script src="<%= request.getContextPath() %>/resources/js/jquery.dotdotdot.min.js"></script>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
