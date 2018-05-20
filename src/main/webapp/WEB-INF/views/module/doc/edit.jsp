<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
   <div class="container">
	     <form:form  name="mForm" method="post" novalidate="true" enctype="multipart/form-data">
   	 	  <input type="hidden" name="id" value="{{item.id}}"/>
       <div class="required_item">
		<ul class="ri_list">
		     <li>
				<label class="col-sm-3">제목 </label>
				<div class="col-sm-9">
					<div class="check_rs fm_type220">
					<aon-input-text ng-model="item.title" 
					           field-name="title" 
					           placeholder="input Title..." ng-required="true"
					           alert-message="제목을 입력하세요"></aon-input-text>
					 </div>
		         </div>
		     </li>
		     <li>
				<label class="col-sm-3">본문</label>
				<div class="col-sm-9">
					   <aon-editor ng-model="item.content" 
          					 field-name="content" 
          					 placeholder="input title" ng-required="true" alert-message="본문을 입력하세요"></aon-editor>
		         </div>
		     </li>
		    
		      <li>
				<label class="col-sm-3">파일</label>
				<div class="col-sm-9">
					  <aon-files ng-model="item.attachments"
           					 field-name="attachments" 
            				insert-button-label="파일추가" delete-button-label="파일삭제"></aon-files>
		         </div>
		     </li>
		    
		</ul>
            
	        
	       </div>
	       <div>
	        <input type="text" name="categories[0].categoryId" ng-model="item.categories[0].categoryId"> 
	       <input type="text" name="version" ng-model="item.version"/>
	       
	        <button type="button" ng-disabled="mForm.$invalid" class="btn btn-default" ng-click="submit()">Send invitation</button>
	       </div>
        </form:form>
   </div>