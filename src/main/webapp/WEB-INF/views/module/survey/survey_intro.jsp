<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
          <!-- mem_app -->
        <div ng-show="!selectLanguage">
           <div>
        		<p> 
        			Select Your Language 
        		</p>
           </div>
           <div class="checks">
	        		<input type="radio" ng-model="userLanguage" name="ko_KR" id="ko_KR" value="ko_KR">
	        		 <label for="ko_KR"><spring:message code='srv.cmm.036'/></label>
	        		<input type="radio" ng-model="userLanguage" name="en_US" id="en_US" value="en_US">
	        		 <label for="en_US"><spring:message code='srv.cmm.037'/></label>
	        		<input type="radio" ng-model="userLanguage" name="vi_VN"  id="vi_VN" value="vi_VN">
	        		 <label for="vi_VN"><spring:message code='srv.cmm.038'/></label>
        	</div>
        	<div>
        			<button type="button" class="btn btn-primary" ng-disabled="!userLanguage" ng-click="selectLanguage=true;changeLang()">Next</button>
        	</div>
        </div>
		<div class="member_app" ng-show="selectLanguage">
			<h2 class="ma_h3"><spring:message code='srv.intro.001'/></h2>
			<div class="ma_link">
				<div class="termBox" style="border-width:1px; border-style: solid; margin:5px;">
                    <h3 class="subtit"><spring:message code='srv.cmm.039'/></h3>
                    <div class="textBox" >
						<div style="text-align:left;">
							<spring:message code='srv.cmm.040'/>
						</div>
					</div>
                </div>
                <div>
					<button type="button" ng-click="startSurvey()" class="btn btn-primary"><spring:message code='srv.cmm.041'/></button>
				</div>
			</div>
        </div>
          <!-- //mem_app -->
