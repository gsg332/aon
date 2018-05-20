<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<h2 class="page_tit"><spring:message code='sys.lbl.032'/></h2>
<div class="tree_box">
	<div class="tree_left">
		<div id="jstree" style="margin: 0;">
		<aon-tree-view tree-model="tree"></aon-tree-view>
		</div>
	</div>
	<div class="tree_right">
		<div class="tree_AU" ng-show="updateView">
			<h4 class="ua_h4"><spring:message code='sys.lbl.033'/></h4>
			<form:form name="mForm" id="mForm" method="post">
				<input type="hidden" name="key" value="">
				<div ng-repeat="list in locales" class="block">
					<span class="ads_date">{{$root.currentNode.name}}({{list}})</span>
					<textarea class="form-control" ng-model="item.value[list]" name="{{list}}" rows="7" ng-required="list == defaultLocale || list == localeThis" code-replace></textarea>
				</div>
				<input type="hidden" name="className" ng-model="item.value.className" value="{{item.value.className}}" ng-required="true"/>
			</form:form>
				<div class="block">
					<span class="ads_date">Image Class</span>
					<ul class="mc_list">
						<li>
							<button class="alarm_info" ng-class="item.value.className == 'alarm_info' ? 'select' : ''" ng-click="setClass('alarm_info')">
								<div class="tl_area">
									<p class="tl_box"><strong>alarm_info</strong></p>
								</div>
							</button>							
						</li>
						<li>
							<button class="alarm_answer" ng-class="item.value.className == 'alarm_answer' ? 'select' : ''" ng-click="setClass('alarm_answer')">
								<div class="tl_area">
									<p class="tl_box"><strong>alarm_answer</strong></p>
								</div>
							</button>
						</li>
						<li>
							<button class="alarm_check" ng-class="item.value.className == 'alarm_check' ? 'select' : ''" ng-click="setClass('alarm_check')">
								<div class="tl_area">
									<p class="tl_box"><strong>alarm_check</strong></p>
								</div>
							</button>
						</li>
						<li>
							<button class="alarm_point" ng-class="item.value.className == 'alarm_point' ? 'select' : ''" ng-click="setClass('alarm_point')">
								<div class="tl_area">
									<p class="tl_box"><strong>alarm_point</strong></p>
								</div>
							</button>
						</li>
					</ul>
				</div>
				<div class="modal-footer border_none">
					<a class="btn btn-primary" id="updateCategory" ng-click="submitUpdate()" ng-disabled="mForm.$invalid"><spring:message code='cmm.btn.017'/></a>
				</div>
		</div>
	</div>
</div>
