<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
 <div class="jumbotron">
      <div class="container">
        <h1><spring:message code='doc.001'/></h1>
        <p>This is a template for a simple marketing or informational website. It includes a large callout called a jumbotron and three supporting pieces of content. Use it as a starting point to create something more unique.</p>
        <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more &raquo;</a></p>
      </div>
    </div>
	<div class="container">
		<table class="table table table-hover">
			<thead>
				<tr>
					<td width="20">ID</td>
					<td>TITLE</td>
					<td width="10">Read</td>
					<td width="60">INSERT_DATE</td>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="doc in list">
					<td>{{doc.id}}</td>
					<td><a href='#/view/{{doc.id}}'>{{doc.title}}</a></td>
					<td>{{doc.readCount }}</td> <!-- 참고 angularjs date filter -->
					<td>{{doc.insertDate | Adate }}</td> <!-- 참고 angularjs date filter -->
				</tr>
			</tbody>
		</table>
		<div class="row">
			<div class="col-md-2" style="display: inline-block;vertical-align:middle;">
					  <a href='<c:url value="#/write"/>' id="btnNotice" type="button" class="btn btn-primary">쓰기</a>
			</div>
			<div class="col-md-8">
				<uib-pagination boundary-links="true" total-items="totalItems" max-size="10" 
					ng-model="currentPage" ng-change="pageChanged()" class="pagination-lg" previous-text="&lsaquo;"
					next-text="&rsaquo;" first-text="&laquo;" last-text="&raquo;" items-per-page ="10">
				</uib-pagination>
			</div>
			
		</div>
	</div>