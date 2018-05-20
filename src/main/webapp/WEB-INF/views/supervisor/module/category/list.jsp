<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp"%>
<h2 class="page_tit"><spring:message code='cat.lbl.001'/></h2>
<div class="tree_box">
	<div class="tree_left">
		<div id="jstree">
		<aon-tree-view tree-model="tree"></aon-tree-view>
		</div>
		<button id="muBtn" class="glyphicon tree_up" type="button" ng-click="upNode()"></button>
		<button id="mdBtn" class="glyphicon tree_down" type="button" ng-click="downNode()"></button>
		<button id="muBtn" class="tree_fa tree_first" type="button" ng-click="topNode()">
			<img src="<%=getServletContext().getContextPath() %>/resources/images/admin/btn_first_top.png"/>	
		</button>
		<button id="mdBtn" class="tree_fa tree_last" type="button" ng-click="bottomNode()">
			<img src="<%=getServletContext().getContextPath() %>/resources/images/admin/btn_last_bottom.png"/>
		</button>
	</div>
	<div class="tree_right">
		<div class="tree_AU" ng-show="addView">
			<h4 class="ua_h4"><span ng-show="$root.currentNode.id == 0">ROOT </span><spring:message code='cat.lbl.002'/></h4>
			<form:form name="categoryWriteForm" id="categoryWriteForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="parentId" value="">
				<input type="hidden" ng-model="name" name="name" value="{{name}}">
				<div ng-repeat="list in locales" class="block">
					<span class="ads_date">Name({{list}})</span>
					<aon-input-text ng-model="nameList[list]"
						field-name="{{list}}" label="list" 
						placeholder="<spring:message code='cat.msg.001'/>" ng-required="list == defaultLocale || list == localeThis"
						alert-message="<spring:message code='cat.msg.001'/>">
					</aon-input-text>
				</div>
				<div class="block">
					<span class="ads_date">Image Class</span>
					<input type="text" class="form-control" name="className" ng-model="className" placeholder="" />
				</div>
				<div class="modal-footer">
					<a class="btn btn-primary" id="addCategory" ng-click="submitAdd()" ng-disabled="categoryWriteForm.$invalid"><spring:message code='cmm.btn.039'/></a>
				</div>
			</form:form>
		</div>
		<div class="tree_AU" ng-show="updateView">
			<h4 class="ua_h4"><spring:message code='cat.lbl.003'/></h4>
			<form:form name="categoryUpdateForm" id="categoryUpdateForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="id" value="">
				<input type="hidden" ng-model="name" name="name" value="{{name}}">
				<div ng-repeat="list in locales" class="block">
					<span class="ads_date">Name({{list}})</span>
					<aon-input-text ng-model="nameList[list]"
						field-name="{{list}}" label="list" 
						placeholder="<spring:message code='cat.msg.001'/>" ng-required="list == defaultLocale || list == localeThis"
						alert-message="<spring:message code='cat.msg.001'/>">
					</aon-input-text>
				</div>
				<div class="block">
					<span class="ads_date">Image Class</span>
					<input type="text" class="form-control" name="className" ng-model="className" placeholder="" />
				</div>
				<div class="modal-footer">
					<a class="btn btn-primary" id="updateCategory" ng-click="submitUpdate()" ng-disabled="categoryUpdateForm.$invalid"><spring:message code='cmm.btn.017'/></a>
				</div>
			</form:form>
		</div>
	</div>
</div>
<div class="btnArea">
	<button id="addBtn" class="btn btn-primary" type="button" ng-click="addNode()"><spring:message code='cmm.btn.039'/></button>
	<button id="updateBtn" class="btn btn-warning" type="button" ng-click="updateNode()"><spring:message code='cmm.btn.017'/></button>
	<aon-btn-modal-confirm field-text="<spring:message code='cmm.btn.018'/>" modal-id=".confirm" btn-class="btn btn-danger" confirm-text="<spring:message code='cat.msg.003'/>" confirm-callback="deleteNode()"></aon-btn-modal-confirm>
	<button id="moveBtn" class="btn btn-default" type="button" ng-click="moveNode()"><spring:message code='cmm.btn.044'/></button>
	<button id="contentsMoveBtn" class="btn btn-default" type="button" ng-click="contentsMove()"><spring:message code='cmm.btn.045'/></button>
</div>
<!-- error modal -->
<div class="modal fade error" id="error" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
			<div class="modal-body center">
				<p class="modalTxt1"><spring:message code='cat.msg.004'/></p>
			</div>
            <div class="modal-footer">
            	<button type="button" class="btn green" data-dismiss="modal" ng-click="load()"><spring:message code='cmm.btn.016'/></button>
            </div>
        </div>
    </div>
</div>
<!-- //error modal -->
<!-- alert modal -->
<div class="modal fade alertText" id="alertText" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body center">
                <p class="modalTxt1">{{alertText}}</p>
            </div>
            <div class="modal-footer">
            	<button type="button" class="btn green" data-dismiss="modal"><spring:message code='cmm.btn.016'/></button>
            </div>
        </div>
    </div>
</div>
<!-- //alert modal -->
