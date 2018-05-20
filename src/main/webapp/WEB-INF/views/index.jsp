<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ include file="/WEB-INF/views/include/main_header.jsp" %>
<script type="text/javascript">
var index = angular.module('index', ['ngRoute', 'ui.bootstrap','aon.input.directives', 'aon.range.slider', 'ngSanitize', 'Filters'])
index.run(function($rootScope){
	$rootScope.safeApply = function(fn) {
        var phase = this.$root.$$phase;
        if(phase == '$apply' || phase == '$digest') {
            if(fn && (typeof(fn) === 'function')) {
                fn();
            }
        } else {
            this.$apply(fn);
        }
    };
});
index.controller('IndexListCtl', function($scope, $rootScope, $window){
	catSeq = 0;
	
	var cateData = jcontext.loadJSON('/sys/category/getListByParent.json?pid=whatinfo');
	$scope.cateList = cateData.list;
	
	var init = function(data){
		$scope.list = data.list;
		$scope.totalItems = data.count;
		if(!$scope.currentPage)
			$scope.currentPage = 1;
	}
	
	$scope.pageChanged = function() {
		var data = jcontext.loadJSON('/module/contest/list.json?page='+$scope.currentPage+'&searchKey=&searchValue=&catSeq='+catSeq);
		$scope.indexView = false;
		init(data);
	};
	
	$scope.pageChanged();
	
    $scope.initFlg = false;
    
    <sec:authorize access="isAnonymous()">
    angular.element(document).ready(function(){
    	$('#title,#point').off().on('click', function(){
    		//swal('Caution!', '로그인 후 등록 가능합니다. 로그인페이지로 이동합니다.', 'warning');
    		$window.location.href = jcontext.getCsrfPath('/sys/login/loginForm.aon');
    		return false;
    	});
    });
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
    angular.element(document).ready(function(){
    	$('#title,#point').off().on('click', function(){
   			$('#memberArea').show();
   			$('#btnApply').show();
   			$('.mpb_slider').show();
    	});
    });
    </sec:authorize>

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
        $('#slider-area').show();
        $('.btn_area').show();
        $('.mpb_message').show();
        
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
		<sec:authorize access="isAnonymous()">
			$window.location.href = jcontext.getCsrfPath('/sys/login/loginForm.aon');
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
		$scope.$apply(function() {
			$scope.data = data;
			$scope.correction = correction;
			$scope.returnPoint = returnPoint;
			$scope.title = title;
			$scope.pointSimple = pointSimple;
			$scope.chooseCount = chooseCount;
			$scope.equal = equal;
		});
		$('form[name=pointForm]').attr('action', '<c:url value="/module/contest/index.aon#/write"/>');
		$('form[name=pointForm]').submit();
		</sec:authorize>
	};
	
}).directive('listContest', function() {
	return function(scope, element, attrs) {
		if(scope.$last){
			element.ready(function () {
				$(".el_txt").dotdotdot({
					watch: "window"
				});
			});
		}
	};
}).filter('replaceS', function ($cookies) {
	return function (input) {
		if(jcontext.getLocale($cookies) == 'ko_KR'){
			return input;
		}else{
			return input.replace(/[/]/g, '<br/>');
		}
		//return input.replace(/[/]/g, ' / ');
		//return '<span>' + input.replace(/[/]/g, '</span><span>') + '</span>';
	};
});  

</script>
<script src="<%= request.getContextPath() %>/resources/js/aon.range.slider.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/toastr.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/sweetalert.min.js"></script>
<script src="<%= request.getContextPath() %>/resources/js/jquery.imagemapster.min.js"></script>
<script>
$(function(){
	$('.m_map').mapster({
		render_highlight: {
			stroke: false,
			altImage: '/resources/images/main/main_back_on.jpg'
		},
		render_select: {
			stroke: false,
			altImage: '/resources/images/main/main_back_on.jpg'
		},
		fadeInterval: 50,
		mapKey: 'data-area',
		areas: [
			{
				key: 'fashion'
			},
			{
				key: 'beauty'
			},
			{
				key: 'fb',						
			},
			{
				key: 'education'
			},
			{
				key: 'hotel'
			},
			{
				key: 'travel'
			},
			{
				key: 'etc'
			},
			{
				key: 'hospital'
			},
			{
				key: 'finance'
			},
			{
				key: 'realE'
			},
			{
				key: 'etc1'
			}
		]
	});

	function resize(maxWidth,maxHeight) {
		var image =  $('.m_map'),
			imgWidth = image.width(),
			imgHeight = image.height(),
			newWidth=0,
			newHeight=0;

		if (imgWidth/maxWidth>imgHeight/maxHeight || imgWidth/maxWidth<imgHeight/maxHeight) {
			newWidth = maxWidth;
		} else {
			newHeight = maxHeight;
		}
		image.mapster('resize',newWidth,newHeight,resizeTime);   
	}

	// Track window resizing events, but only actually call the map resize when the
	// window isn't being resized any more

	function onWindowResize() {

		var curWidth = $('.main_map').width(),
			curHeight = $('.main_map').height(),
			checking=false;
		if (checking) {
			return;
		}
		checking = true;
		window.setTimeout(function() {
			var newWidth = $('.main_map').width(),
				newHeight = $('.main_map').height();
			if (newWidth === curWidth &&
				newHeight === curHeight) {
				resize(newWidth,newHeight); 
			}
			checking=false;
		},resizeDelay );
	}

	$(window).bind('resize',onWindowResize);
});
</script>
<div ng-app="index" ng-controller="IndexListCtl">	
	<div class="main_top">
		<!-- map -->
		<div class="main_map">		
			<img src="<%= request.getContextPath() %>/resources/images/main/main_back.jpg" usemap="#Map" alt="main img" class="m_map">
			<map name="Map">
				<area data-area="fashion" shape="poly" coords="254,341,203,302,204,222,212,215,226,197,261,191,256,180,254,162,257,155,254,148,269,142,280,142,277,146,280,150,288,149,300,191,330,200,342,215,358,237,355,286,360,298,370,291,366,276,363,278,365,264,358,246,369,245,371,237,375,240,375,246,382,248,378,263,376,267,382,275,373,278,375,293,380,300,372,303,363,303,357,308,354,327,314,339,309,334,291,344,253,340" href="#">
				<area data-area="beauty" shape="poly" coords="403,257,352,207,349,146,337,151,354,118,352,101,345,96,349,86,367,85,380,90,379,100,377,102,417,98,438,82,449,81,473,89,482,88,493,110,502,113,502,124,520,154,511,157,514,222,510,225" href="#">
				<area data-area="fb" shape="poly" coords="586,237,564,241,564,221,570,210,522,126,515,21,511,13,515,7,633,60,640,61,650,74,645,75,649,146,668,177,667,185,657,192,655,211" href="#">
				<area data-area="education" shape="poly" coords="957,213,955,207,954,160,953,155,954,131,950,133,952,75,962,72,971,52,976,33,953,20,1028,14,1101,48,1088,51,1089,65,1093,78,1096,100,1096,117,1079,114,1083,96,1082,73,1086,72,1082,47,1067,50,1062,64,1075,73,1075,105,1076,133,1073,133,1072,199,1088,185,1105,193,1107,208,1089,225,1070,215" href="#">
				<area data-area="hotel" shape="poly" coords="1210,232,1208,225,1180,217,1179,190,1170,190,1189,158,1194,157,1193,119,1185,119,1205,74,1206,65,1209,65,1213,46,1223,40,1231,44,1252,33,1258,39,1268,48,1304,50,1301,54,1324,105,1317,107,1318,181,1297,196,1302,208,1296,216,1279,223,1267,218,1260,217,1258,214,1257,223,1252,226,1250,221,1233,233,1234,237,1229,242,1226,238,1215,234,1215,239,1209,238" href="#">
				<area data-area="travel" shape="poly" coords="1458,256,1458,255,1452,263,1445,273,1438,270,1433,270,1425,268,1427,249,1420,253,1408,249,1391,264,1375,257,1374,240,1370,237,1377,213,1378,164,1372,167,1398,66,1438,38,1463,46,1471,39,1472,27,1460,19,1476,27,1486,31,1483,46,1479,57,1475,61,1484,81,1479,85,1466,69,1459,76,1457,83,1476,117,1469,127,1466,186,1468,208,1465,213,1453,223,1459,232" href="#">
				<area data-area="etc" shape="poly" coords="1619,298,1509,259,1507,197,1500,197,1535,146,1547,141,1569,147,1585,135,1588,139,1602,155,1630,160,1652,202,1650,207,1645,202,1650,265" href="#">
				<area data-area="hospital" shape="poly" coords="303,591,297,591,173,545,176,443,286,428,312,413,324,415,317,425,301,433,348,470,345,502,353,502,356,518,357,544,344,552,344,561,352,565,358,570,360,582,352,591,339,594,322,596" href="#">
				<area data-area="finance" shape="poly" coords="463,617,463,618,462,625,441,633,411,616,411,597,420,595,401,582,403,509,390,506,466,444,494,461,503,448,514,441,525,442,536,446,543,461,549,465,559,473,565,478,574,493,569,516,579,522,583,533,599,538,591,539,591,544,596,544,598,549,605,553,601,561,591,564,585,560,584,553,589,552,581,538,578,545,569,549,569,569,573,569,573,581,547,593,537,585,537,580,512,589,518,594,520,609,484,629" href="#">
				<area data-area="realE" shape="poly" coords="796,620,799,610,792,599,786,586,787,577,794,567,807,561,820,569,825,581,823,593,821,603,815,614,832,616,832,495,856,450,910,449,910,442,907,440,919,428,926,430,935,442,927,442,927,448,933,450,954,493,956,617,910,621" href="#">
				<area data-area="etc1" shape="poly" coords="1172,608,1153,607,1151,535,1143,538,1176,475,1208,476,1205,473,1215,458,1240,460,1248,474,1246,479,1272,537,1264,536,1267,547,1298,548,1314,573,1312,597,1317,597,1315,489,1307,489,1334,424,1361,424,1361,408,1355,411,1364,399,1382,399,1389,411,1382,411,1382,420,1391,427,1411,488,1401,490,1403,607" href="#">
			</map>
		</div>
		<!-- map -->
	
		<!-- ms_form -->
		<div class="main_point_box">
			<div class="mpb_tail">
				<div class="mpb_top"></div>
				<div class="mpb_body">				
					<div class="mpb_center">
						<form:form name="pointForm" method="post" class="form-inline">
						<div class="mpb_info">
							<div class="mpb_question">
								<input type="text" class="form-control" name="title" id="title" placeholder="<spring:message code='cts.msg.023'/>">
							</div>													
						</div>
						<!-- point write -->
						<div class="mpb_form">
								<input type="hidden" name="data" value="{{data}}"/>
								<input type="hidden" name="correction" value="{{correction}}"/>
								<input type="hidden" name="returnPoint" value="{{returnPoint}}"/>
								<input type="hidden" name="title" value="{{title}}"/>
								<input type="hidden" name="pointSimple" value="{{pointSimple}}"/>
								<input type="hidden" name="chooseCount" value="{{chooseCount}}"/>
								<input type="hidden" name="equal" value="{{equal}}"/>
								<!-- 로그인 시 포인트 입력창만 보여야 함, 창 클릭시 아래 출력 -->
								<div class="form-group">
									<input type="text" class="form-control" id="point" num-chk ng-model="tmpVal" placeholder="<spring:message code='cts.msg.024'/>">
								</div>
								<!-- //로그인 시 포인트 입력창만 보여야 함, 창 클릭시 아래 출력 -->
								<div class="form-group" id="memberArea" style="display:none;">
									<input type="text" class="form-control mini" id="member" num-chk ng-model="tmpVal"> <span><spring:message code='cts.lbl.057'/></span>
								</div>
								<!-- <button class="btn btn-success" onclick="angular.element(this).scope().distribution()">적용</button><br> -->
								<!-- <button type="button" id="btnApply" style="display:none;" class="btn btn-success" onclick="angular.element(this).scope().distribution()" ng-click="distribution()"><spring:message code='cmm.btn.050'/></button><br> -->
						</div>
						</form:form>
						<!-- point slider -->
						<div class="mpb_slider" style="display:none;">
							<p class="mpb_message" style="display:none;">
								<span><spring:message code='cts.lbl.058'/></span>
								<!--<sapn>1등의 지급 포인트는 XXXXXX포인트 입니다.</sapn>-->
							</p>
							<div class="panel panel-success" id="slider-area" style="display:none">				
								<slider model="otherProbs" init_flg="initFlg" point_data="pointData" apply-callback="distribution()" receive-callback="receive(data, correction, returnPoint, title, pointSimple, chooseCount, equal)"></slider>
							</div>
							<input type="hidden" name="pointRatio" id="pointRatio" ng-model="pointRatio" />
							<div class="btn_area center" style="display:none">
								<button class="btn btn-success" id="btnRegist" ng-disabled="!otherProbs.length"><spring:message code='cmm.btn.004'/></button>
							</div>		
						</div>
						<!-- //point slider -->
					</div>					
				</div>
				<div class="mpb_bottom"></div>
			</div>			
		</div>
		<!-- //ms_form -->
	</div>
	
	<!-- 분류 -->
	<div class="InfoCategory">
		<div class="cateWidth">
			<div class="categorySlider">
				<div class="item {{category.className}}" ng-repeat="category in cateList">
                	<a href='<c:url value="/module/contest/index.aon#/list/{{category.id}}"/>' ng-bind-html="category.name | replaceS | ctgrLang"></a>
                </div>
			</div>
		</div>
	</div>		
	<!-- //분류 -->
	
	<!-- main_slider -->
	<div class="hero_area">
		<div class="container">
			<div class="row">
				<div class="new_row">
					<div class="hero_area_list">
						<div class="hero_area_item h_back_{{$index + 1}}" ng-repeat="item in list" ng-if="$index < 3">
							<div class="hero_area_img">
								<img src="<%=getServletContext().getContextPath() %>/resources/images/main/index_1_hero_bg_{{$index + 1}}.jpg" alt="">
							</div>
							<div class="hero_area_text">
								<div class="hero_area_table">
									<div class="hero_area_table_cell">						
										<div class="hero_area_text_title">Today’s Information Exchange</div>
										<!-- //질문시작 -->
										<div class="hero_area_text_content">
											<p class="subject" ng-bind-html="item[1]"></p>
											<p class="el_txt" ng-bind-html="item[2]" list-contest></p>
											<div class="infoItem">
												<div class="areaL" style="margin-top:7px;">
												<span class="categ"><span ng-if="item[6] != null">{{item[6] | ctgrLang}} <img src="<%=getServletContext().getContextPath() %>/resources/images/common/arrow_bar.png" alt="" style="height: 11px;width: 6px;display: inline;"> </span>{{item[7] | ctgrLang}}<span ng-if="item[8] != ''"> <img src="<%=getServletContext().getContextPath() %>/resources/images/common/arrow_bar.png" alt="" style="height: 11px;width: 6px;display: inline;"> {{item[8] | ctgrLang}}</span></span>
												<span class="bline">|</span>{{item[4] | Apoint}}<span class="bline">|</span><i class="glyphicon glyphicon-time"></i> {{item[5] | Adate}}<span class="bline">|</span><spring:message code='cts.lbl.055'/> <span class="fb">{{item[9]}}</span></div>
												<div class="areaR"><a href='<c:url value="/module/contest/index.aon#/view/{{item[0]}}"/>' class="btn dark btn-outline"><spring:message code='cts.lbl.056'/></a></div>
											</div>
										</div>
										<!-- //질문끝 -->
									</div>
								</div> <!-- hero_area_table end -->
							</div> <!-- hero_area_text end -->
						</div> <!-- hero_area_item end -->
					</div> <!-- hero_area_list end -->
				</div> <!-- col-md-8 end -->
			</div> <!-- row end -->
		</div> <!-- container end -->
	</div>
	<!-- //main_slider -->
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>