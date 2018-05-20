<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
   <div class="container"> 
           <div class="page-header">
           		<h3>{{item.title}}<span class="label label-default">New</span></h3>
           </div>
           <div class="form-group" ng-bind-html="item.content">
           </div>
           <div class="form-group">
	             {{item.insertDate | Adate }}
           </div>
           <div class="form-group">
	             {{item.updateDate | Adate }}
           </div>
           <div class="form-grup">
	           <ul class="list-group" ng-repeat="attach in item.attachments">
	 			 <li class="list-group-item"><a href="<c:url value="/module/doc/download.aon?id="/>{{attach.id}}">{{attach.filename}}</a></li>
			  </ul>
	        </div>
	        <div class="row">
				<div class="col-md-2" style="display: inline-block;vertical-align:middle;">
					<a ng-href='#/edit/{{item.id}}' type="button" class="btn btn-primary"> 수정 </a><button type="button" class="btn btn-default" ng-click="deleteItem()">삭제 </button>
				</div> 
			</div>
   </div>