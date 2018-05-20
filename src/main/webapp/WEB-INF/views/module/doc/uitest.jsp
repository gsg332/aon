<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<style>
div[data-angular-treeview] {
    /* prevent user selection */
    -moz-user-select: -moz-none;
    -khtml-user-select: none;
    -webkit-user-select: none;
    -ms-user-select: none;
    user-select: none;

    /* default */
    font-family: Tahoma;
    font-size:13px;
    color: #555;
    text-decoration: none;
    padding-top: 20px;
}

div[data-tree-model] ul {
    margin: 0;
    padding: 0;
    list-style: none;
    border: none;
    overflow: hidden;
}

div[data-tree-model] li {
    position: relative;
    padding: 0 0 0 20px;
    line-height: 20px;
}

div[data-tree-model] li .expanded {
    padding: 1px 10px;
    background-image: url("http://cfile23.uf.tistory.com/image/205B973A50C13F4B19D9BD");
    background-repeat: no-repeat;
}

div[data-tree-model] li .collapsed {
    padding: 1px 10px;
    background-image: url("http://cfile23.uf.tistory.com/image/1459193A50C13F4B1B05FB");
    background-repeat: no-repeat;
}

div[data-tree-model] li .normal {
    padding: 1px 10px;
    background-image: url("http://cfile23.uf.tistory.com/image/165B663A50C13F4B196CCA");
    background-repeat: no-repeat;
}

div[data-tree-model] li i, div[data-tree-model] li span {
    cursor: pointer;
}

div[data-tree-model] li .selected {
    background-color: #aaddff;
    font-weight: bold;
    padding: 1px 5px;
}
.tree_list > div[data-angular-treeview] > ul > li{
	padding: 0;
}
</style>
<script>
(function() {
	"use strict"
	 angular.module('mainApp', [ 'ngSanitize', 'ui.bootstrap','aon.input.directives' ])
	 .run(function($rootScope, $http){
		 /**
		 * 중복체크 확인용 ajax 메소드
		 * 중복체크 후 중복되었으면 false, 중복되지 않았으면 true 반환
		 */
		 $rootScope.chkDuplicate = function(value, type){
			console.log(value + ' / ' + type);
			if(type == 'email'){
				$rootScope.responsePromise = $http({
					method : 'POST',
					url : jcontext.getCsrfPath('/sys/member/duplicateEmailCheck.json'),
					data : $.param({email : value}),
					headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				});
			} else if(type == 'nick'){
				$rootScope.responsePromise = $http({
					method : 'POST',
					url : jcontext.getCsrfPath('/sys/member/duplicateNickCheck.json'),
					data : $.param({nickName : value}),
					headers: {'Content-Type': 'application/x-www-form-urlencoded'}
				});
			} else {
				$rootScope.responsePromise = true;
			}
		 };
		 
		 $rootScope.aonCallbackAuth = function(param){
			 console.log(param);
			 return false;
		 };
		 
		 $rootScope.chkNumber = '';
	 })
	.controller('TestUiController', [ '$scope', function($scope) {
		$scope.member={
				email: 'test' ,
				startDate:'1470927600000',
				phonenumber: '01051008301'
		};
		
		$scope.date = {
			start : '1465830000000',
			end : '1466607600000'
		};
		
		$scope.item = {
			input1 : 'asdf',
			input2 : '1234',
			select1 : [
			{
				id : '1',
				name : 'aaa',
				code : '111'
			},
			{
				id : '2',
				name : 'bbb',
				code : '222'
			},
			{
				id : '3',
				name : 'ccc',
				code : '333'
			}
			           ]
		};
		
		$scope.search = {
			select1 : '2'
		};
		
		$scope.valueTest = function(){
			console.log($scope.item.input1);
		};
		
		$scope.valueTest1 = function(){
			console.log($scope.date.start + ' / ' + $scope.date.end);
		};
		
		$scope.category={
				  "list" : [ {
					    "id" : 1,
					    "version" : 0,
					    "parentId" : null,
					    "rootId" : 1,
					    "sort" : 1,
					    "name" : "1차생산업",
					    "flagCode" : 0
					  }, {
					    "id" : 2,
					    "version" : 0,
					    "parentId" : 1,
					    "rootId" : 1,
					    "sort" : 2,
					    "name" : "광업",
					    "flagCode" : 0
					  }, {
					    "id" : 3,
					    "version" : 0,
					    "parentId" : 2,
					    "rootId" : 1,
					    "sort" : 3,
					    "name" : "제조",
					    "flagCode" : 0
					  }, {
					    "id" : 4,
					    "version" : 0,
					    "parentId" : 3,
					    "rootId" : 1,
					    "sort" : 4,
					    "name" : "기간산업",
					    "flagCode" : 1
					  } ]
					};
		$scope.submit = function(){
		          $scope.$broadcast("SUBMIT");
		          alert($scope.member.startDate);
		          alert($scope.member.startDate1);
		}
		
		$scope.getCategoryName = function(categoryId){
			return "";
		}
		
		$scope.getIndent = function(category){
			return " here";
		}
		
		$scope.fnChk = function(){
			console.log('asdf');
		}
		
		//node 선택시 콘솔에 정보 출력
        $scope.$watch( 'currentNode', function( newObj, oldObj ) {
            if( $scope.currentNode && angular.isObject($scope.currentNode) ) {
                console.log( 'Node Selected!!' );
                console.log( $scope.currentNode );
            }
        }, false);
		
        $scope.treeList = [
			{
			    "id" : 1,
			    "version" : 0,
			    "parentId" : null,
			    "rootId" : 1,
			    "sort" : 1,
			    "name" : "1차생산업",
			    "flagCode" : 0,
			    "innerTree": []
			  }, {
			    "id" : 2,
			    "version" : 0,
			    "parentId" : 1,
			    "rootId" : 1,
			    "sort" : 2,
			    "name" : "광업",
			    "flagCode" : 0,
			    "innerTree": []
			  }, {
			    "id" : 3,
			    "version" : 0,
			    "parentId" : 2,
			    "rootId" : 1,
			    "sort" : 3,
			    "name" : "제조",
			    "flagCode" : 0,
			    "innerTree" : [
				  {
				    "id" : 4,
				    "version" : 0,
				    "parentId" : 3,
				    "rootId" : 1,
				    "sort" : 4,
				    "name" : "기간산업",
				    "flagCode" : 1,
				    "innerTree": []
				  }
				]
			  }
			];
        
        $scope.test = function(){
        	console.log('성공');
        }
        
        $scope.btnCallbackInController = function(){
        	console.log('asfd');
        }
        
        $scope.testData = 'asdf\nasdf\n2341\nwqer';
        
        /**
        * 전화번호 발송 메소드
        */
        $scope.aonCallbackSend = function() {
        	console.log('callback send ');
        	return true;
        }
        
        /**
        * 전화번호 인증 확인 메소드
        */
        $scope.aonCallbackAuth = function() {
        	/**
        	* 확인 입력 번호 값 : $('#chkNumber').val()
        	*/
        	console.log('callback auth ' + $('#chkNumber').val());
        	return true;
        }
        
	} ])
	.service('DocItemSvc', [ '$http', function($http) {

	} ]);
})();
function fnChk(objArr){
	var flg = true;
	var chkArray = objArr.split(',');
	for(var i = 0; i < chkArray.length; i++){
		if($('[name='+chkArray[i]+']').val() == ''){
			$('[name='+chkArray[i]+']').parent().removeClass('has-success').addClass('has-error');
		} else {
			$('[name='+chkArray[i]+']').parent().removeClass('has-error').addClass('has-success');
			flg = false;
		}
	}
	
	if(flg){
		for(var i = 0; i < chkArray.length; i++){
			$('[name='+chkArray[i]+']').parent().removeClass('has-success').removeClass('has-error');
		}
	}
	/* var obj1 = $('input[name='+name1+']');
	var obj2 = $('input[name='+name2+']');
	var obj3 = $('select[name='+name3+']');
	
	if(obj1.val() == ''){
		obj1.parent().removeClass('has-success').addClass('has-error');
	} else {
		obj1.parent().removeClass('has-error').addClass('has-success');
	}
	console.log('asfd : ' + obj2.val());
	if(obj2.val() == ''){
		obj2.parent().removeClass('has-success').addClass('has-error');
	} else {
		obj2.parent().removeClass('has-error').addClass('has-success');
	}
	
	if(obj3.val() == ''){
		obj3.parent().removeClass('has-success').addClass('has-error');
	} else {
		obj3.parent().removeClass('has-error').addClass('has-success');
	} */
}
</script>
<div class="container" ng-app="mainApp" ng-controller="TestUiController">
<form:form  name="mForm" method="post" novalidate="true" 
   	 	 enctype="multipart/form-data">	
   	<div class="required_item">
		<ul class="ri_list">
			<li>
				<label class="col-sm-3">inpu1</label>
				<div class="col-sm-9" ng-if="search.select1 == 2">
					<div class="check_rs fm_type220">
					   <aon-input-text ng-model="item.input1" 
					           field-name="id1"
					           length-check="true" length-message="2자리 이상 10자리 미만으로 입력해 주세요." min="2" max="10"
					           placeholder="ID를 입력하세요." ng-required="true"
					           alert-message="회원ID는 필수입력사항입니다."></aon-input-text>
					 </div>
					 <button type="button" class="btn btn-default" ng-click="valueTest()">값 테스트</button>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">input2</label>
				<div class="col-sm-9">
					<div class="check_rs fm_type220">
					   <aon-input-text ng-model="item.input2" 
					           field-name="id2"  
					           placeholder="ID를 입력하세요." ng-required="true"
					           alert-message="회원ID는 필수입력사항입니다."></aon-input-text>
					</div>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">select1</label>
				<div class="col-sm-9">
					<div class="check_rs fm_type220">
					   <select ng-model="search.select1" name="select1" class="form-control fm_type140">
						<option ng-repeat="sel in item.select1" ng-selected="{{sel.id == search.select1}}" value="{{sel.id}}">{{sel.name}}</option>
                       </select>
                       
                       <!-- <select class="form-control fm_type140"
                       	ng-init ="item.select1.id = search.select1"
                       	ng-model = "item.select1"
                       	ng-options = "sel.id as sel.name for sel in item.select1 track by sel.id">
                       </select> -->
					</div>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">회원 ID</label>
				<div class="col-sm-9">
					<div class="check_rs fm_type220">
					   <aon-input-text ng-model="member.id" 
					           field-name="id"  
					           placeholder="ID를 입력하세요." ng-required="true"
					           alert-message="회원ID는 필수입력사항입니다."></aon-input-text>
					 </div>
				            <button type="button" class="btn btn-default">중복확인</button>
				   <span class="txt_etc block">4자 이상 20자 내외 영문 문자, 숫자의 조합만 가능</span>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">가격</label>
				<div class="col-sm-9">
					<div class="check_rs fm_type220">
					   <aon-input-price ng-model="member.price" 
					           field-name="price"  
					           placeholder="가격을 입력하세요." ng-required="true"
					           alert-message="가격은 필수입력사항입니다." 
					           format-message="숫자만 입력해 주세요."
					           min-message="5만원부터 만원단위로 입력해주세요." term-message="만원단위로 입력해 주세요." limit-message="최대값은 천만원입니다." price-check="true"></aon-input-price>
					 </div>
				            <button type="button" class="btn btn-default">중복확인</button>
				   <!-- <span class="txt_etc block">4자 이상 20자 내외 영문 문자, 숫자의 조합만 가능</span> -->
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">닉네임</label>
				<div class="col-sm-9">
					<div class="check_rs fm_type220">
					   <aon-input-text ng-model="member.nick" 
					           field-name="nick"  
					           placeholder="닉네임을 입력하세요." ng-required="true"
					           alert-message="닉네임은 필수입력사항입니다."
					           length-message="4자리 이상 10자리 미만으로 입력해 주세요." length-check="true" min="4" max="10"></aon-input-text>
					 </div>
				            <button type="button" class="btn btn-default">중복확인</button>
				   <span class="txt_etc block">4자 이상 20자 내외 영문 문자, 숫자의 조합만 가능</span>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">이메일</label>
				<div class="col-sm-9">
					<div class="check_rs fm_type220">
					   <aon-input-email ng-model="member.email" 
					           field-name="email"  
					           placeholder="이메일을 입력하세요." ng-required="true"
					           alert-message="이메일은 필수입력사항입니다." 
					           format-message="형식에 맞지 않습니다." formated="true"
					           duplicated-message="중복된 이메일입니다." exchanged="true" exchanged-type="email"></aon-input-email>
					 </div>
				            <button type="button" class="btn btn-default">중복확인</button>
				   <!-- <span class="txt_etc block">4자 이상 20자 내외 영문 문자, 숫자의 조합만 가능</span> -->
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">전화번호</label>
				<div class="col-sm-9">
					<div class="check_rs fm_type220">
					   <aon-input-phone ng-model="member.phone" 
					           field-name="phonenumber"  
					           placeholder="전화번호를 입력하세요."
					           alert-message="전화번호는 필수입력사항입니다." maxlength="20"
					           format-message="형식에 맞지 않습니다. 숫자만 입력가능합니다." format-type="N" formated="true"></aon-input-phone>
					 </div>
				   <!-- <span class="txt_etc block">4자 이상 20자 내외 영문 문자, 숫자의 조합만 가능</span> -->
		         </div>
		     </li>
		     <li>
	             <label class="col-sm-3">휴대폰 번호</label>
	             <div class="col-sm-9">
	             	<aon-phonenumber-send phone-num="01051008301" aon-callback-send="aonCallbackSend()" aon-callback-auth="aonCallbackAuth()" auth-message="인증번호가 정확하지 않습니다."></aon-phonenumber-send>
	             </div>
	         </li>

		     <li>
				<label class="col-sm-3">이름</label>
				<div class="col-sm-9">
					<div class="check_rs fm_type220">
					   <aon-input-text ng-model="member.name" 
					           field-name="name"  
					           placeholder="이름을 입력하세요."></aon-input-text>
					  </div>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">이름3</label>
				<div class="col-sm-9">
					<div class="check_rs fm_type444">
					   <aon-input-text ng-model="member.name" 
					           field-name="name"  
					           placeholder="이름을 입력하세요."></aon-input-text>
					  </div>
		         </div>
		     </li>
		      <li>
				<label class="col-sm-3">본문</label>
				<div class="col-sm-9">
					 <aon-editor ng-model="member.content" 
          			 field-name="content" 
          					placeholder="input title" ng-required="true" alert-message="본문을 입력하세요"></aon-editor>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">요약</label>
				<div class="col-sm-9">
					  <aon-textarea  ng-model="member.summary" 
          			 field-name="summary" 
          					 placeholder="요약정보를 입력하세요" ng-required="true" alert-message="요약을 입력하세요"></aon-textarea>
		         </div>
		     </li>
		      <li>
				<label class="col-sm-3">password</label>
				<div class="col-sm-9">
					<div class="er_box fm_type300">
					  <aon-password  ng-model="member.password" 
					           field-name="password"  
					           placeholder="password를 입력하세요." ng-required="true"
					           alert-message="password 필수입력사항입니다."
					           length-message="password는 숫자, 영문, 특수문자 조합으로 4~20자리를 사용해야 합니다." length-check="true"
					           mix-message="password는 숫자, 영문, 특수문자를 두가지 이상 조합해야 합니다."
					           continue-message="password에 4자 이상 연속 또는 반복 문자 및 숫자를 사용할 수 없습니다.">
					 </aon-password>
					 </div>
		         </div>
		     </li>
		      <li>
				<label class="col-sm-3">파일</label>
				<div class="col-sm-9">
					 <aon-files ng-model="member.attachments"
           					 field-name="attachments" 
            					insert-button-label="파일추가" delete-button-label="파일삭제"></aon-files>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">프로필사진</label>
				<div class="col-sm-9">
					 <aon-image-file ng-model="member.image" field-name="image"></aon-image-file>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">DatePicker</label>
				<div class="col-sm-9">
					 <aon-date-picker ng-model="member.startDate" ng-required="true" field-name="startDate"></aon-date-picker>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">DatePicker2</label>
				<div class="col-sm-9">
					 <aon-date-picker ng-model="member.startDate1" field-name="startDate1" date="{{member.startDate1}}"></aon-date-picker>
		         </div>
		     </li>
		      <li>
				<label class="col-sm-3">검색</label>
				<div class="col-sm-9">
				    <div class="ads_ib">
					 <aon-dateterm-picker start-field-name="startDate" start-ng-model="date.start" end-field-name="endDate" end-ng-model="date.end"></aon-dateterm-picker>
					 </div>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">검색</label>
				<div class="col-sm-9">
				    <!-- <div class="ads_ib">
					 <aon-dateterm-picker  start-field-name="startDate1" end-field-name="endDate1"></aon-dateterm-picker>
					 </div> -->
		         </div>
		     </li>
		    <li>
		     	<label class="col-sm-3">select tree(작업중)</label>
				<div class="col-sm-9">
						<aon-select-tree field-name="category" multiple="multiple" ng-model="category.list" ></aon-select-tree>
						
		         </div>
		     </li>
		     <li>
		     	<label class="col-sm-3">select tree(작업중)</label>
				<div class="col-sm-9">
						<aon-select-tree field-name="category" multiple="multiple" ng-model="category.list" selected="4"></aon-select-tree>
						
		         </div>
		     </li>
		     
		     <li>
		     	<label class="col-sm-3">tree view</label>
				<div class="col-sm-9">
					<a class="btn btn-primary" data-toggle="collapse" href="#exampleTreeView" aria-expanded="false" aria-controls="exampleTreeView">tree view</a>
					<div class="collapse tree_list" id="exampleTreeView">
						<div
				                data-angular-treeview="true"
				                data-tree-model="treeList"
				                data-node-id="id"
				                data-node-label="name"
				                data-node-children="innerTree" >
				        </div>
			        </div>
		         </div>
		     </li>
		     
		     <li>
		     	<label class="col-sm-3">button</label>
				<div class="col-sm-9">
					<aon-btn btn-text="버튼 테스트"
						btn-color="success"
						btn-size="large"
						btn-callback="btnCallbackInController()"
						btn-type="B" btn-href="www.naver.com"></aon-btn>
		         </div>
		     </li>
		     
		     <li>
		     	<label class="col-sm-3">test</label>
				<div class="col-sm-9">
					<p ng-bind-html="testData | nl2br"></p>
		         </div>
		     </li>
		     
		     <li>
		     	<button type="button" ng-disabled="mForm.$invalid" class="btn btn-default" ng-click="submit()">Send invitation</button>
		     </li>
		</ul>
	</div>
	
	<div style="position:relative;z-index:999999">
		<div class="center info_detail_btn">
		    <!-- <a href="#adoptA" aon-btn-modal-open class="btn btn-danger" data-toggle="modal">채 택</a> -->
		    <aon-btn-modal-open
		    	field-text="채 택"
		    	modal-id=".adoptA"
		    	btn-class="btn btn-danger"></aon-btn-modal-open>
		    <!-- <button type="button" data-toggle="modal" data-target="#adoptA" class="btn btn-default">채 택</button> -->
		    <!-- <button type="button" class="btn blue btn-outline">추가질문</button> -->
		    <!-- <button type="button" class="btn blue btn-outline">추가질문</button> -->
		    <aon-btn-modal-confirm
		    	field-text="confirm"
		    	modal-id=".confirm"
		    	btn-class="btn blue btn-outline"
		    	confirm-text="이 답변을 채택하시겠습니까?"
		    	confirm-callback="test()"></aon-btn-modal-confirm>
		</div>
		<!-- 채택 확인 레이어 -->
		<div class="modal fade adoptA" id="adoptA" tabindex="-1" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		                <h4 class="modal-title">채택하기</h4>
		            </div>
		            <div class="modal-body center">
		                <p class="modalTxt1">이 답변을 채택하시겠습니까?</p>
		                <p class="modalTxt2">답변 채택은 1건만 가능합니다.<br>채택 후 취소가 불가능 하며, 정보제공자에게 상금이 전달됩니다.</p>
		                <div class="checks modal_la">
		                    <input type="checkbox" id="clauseAgree2" name="clauseAgree2">
		                    <label for="clauseAgree2">동의합니다.</label>
		                </div>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn green">채택하기</button>
		                <button type="button" class="btn dark btn-outline" data-dismiss="modal">취소하기</button>
		            </div>
		        </div>
		    </div>
		</div>
		<!-- //채택 확인 레이어 -->
		<!-- 채택 확인 레이어2 -->
		<!-- <div class="modal fade confirm" id="confirm" tabindex="-1" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-body center">
		                <p class="modalTxt1">이 답변을 채택하시겠습니까?</p>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn green">예</button>
		                <button type="button" class="btn dark btn-outline" data-dismiss="modal">아니오</button>
		                <button type="button" class="btn dark btn-outline" data-dismiss="modal">아니오</button>
		            </div>
		        </div>
		    </div>
		</div> -->
		<!-- //채택 확인 레이어2 -->
	</div>
</form:form>
</div>
	   
<script>
var app = angular.module('TestUi', ['aon.input.directives']);

app.controller('TestUiController', function($scope) {
	    $scope.member = {name:'' };
});

app.controller('FormController', function($scope) {
	$scope.bool = 'asdf';
});
</script>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>