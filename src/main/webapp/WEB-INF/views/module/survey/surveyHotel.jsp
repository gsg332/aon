<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
	<div class="poll_box">
        <!-- Sports -->
        <div class="layout_poll">        
        <form:form name="surveyForm" id="surveyForm">
        <input type="hidden" name="surveyId" id="surveyId" value="9"/>
        <input type="hidden" name="userLanguage" id="userLanguage" value="{{userlocale}}"/>
        <p class="lpl_title_b"><spring:message code='srv.pag.009'/></p>
            <div class="dep_01 step0">
        		<p class="lpl_title">        			
                    <span class="lpl_txt"><spring:message code='srv.cmm.001'/></span>
        		</p>
        		<p class="lpl_question">        			
					<label style="width : 50px;"><spring:message code='srv.cmm.002'/></label> <input type="text" name="email"  id="email" placeholder="ex) user@aon.com">
				</p>
				<p class="lpl_question">
					<label style="width : 50px;"><spring:message code='srv.cmm.003'/></label> <input type="text" name="userName" id="userName">                            
                </p>
                <p class="lpl_title">
                    <span class="lpl_ico"></span>
                    <span class="lpl_txt"><spring:message code='srv.cmm.004'/></span>
                </p>
               	<ul class="dep_02 lpl_yn">
               		<li>
                           <div class="checks">
                               <input type="radio" name="gender" id="gender-1" value="1">
                               <label for="gender-1"><spring:message code='srv.cmm.005'/></label>
                           </div>
                       </li>
                       <li>
                           <div class="checks">
                               <input type="radio" name="gender" id="gender-2" value="2">
                               <label for="gender-2"><spring:message code='srv.cmm.006'/></label>
                           </div>
                       </li>
               	</ul>
               	<p class="lpl_title">
                    <span class="lpl_ico"></span>
                    <span class="lpl_txt"><spring:message code='srv.cmm.007'/></span>
                </p>
               	<ul class="dep_02 lpl_yn">
               		<li>
                         <div class="checks">
                             <input type="radio" name="age" id="age-1" value="1">
                             <label for="age-1"><spring:message code='srv.cmm.008'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="age" id="age-2" value="2">
                             <label for="age-2"><spring:message code='srv.cmm.009'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="age" id="age-3" value="3">
                             <label for="age-3"><spring:message code='srv.cmm.010'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="age" id="age-4" value="4">
                             <label for="age-4"><spring:message code='srv.cmm.011'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="age" id="age-5" value="5">
                             <label for="age-5"><spring:message code='srv.cmm.012'/></label>
                         </div>
                     </li>
               	</ul>
               	<p class="lpl_title">
                    <span class="lpl_ico"></span>
                    <span class="lpl_txt"><spring:message code='srv.cmm.013'/></span>
                </p>
               	<ul class="dep_02 lpl_yn">
               		<li>
                         <div class="checks">
                             <input type="radio" name="job" id="job-1" value="1">
                             <label for="job-1"><spring:message code='srv.cmm.014'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="job" id="job-2" value="2">
                             <label for="job-2"><spring:message code='srv.cmm.015'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="job" id="job-3" value="3">
                             <label for="job-3"><spring:message code='srv.cmm.016'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="job" id="job-4" value="4">
                             <label for="job-4"><spring:message code='srv.cmm.017'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="job" id="job-5" value="5">
                             <label for="job-5"><spring:message code='srv.cmm.018'/></label>
                         </div>
                     </li>
               	</ul>
               	<p class="lpl_title">
                    <span class="lpl_ico"></span>
                    <span class="lpl_txt"><spring:message code='srv.cmm.019'/></span>
                </p>
               	<ul class="dep_02 lpl_yn">
               		<li>
                         <div class="checks">
                             <input type="radio" name="officeSize" id="officeSize-1" value="1">
                             <label for="officeSize-1"><spring:message code='srv.cmm.020'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="officeSize" id="officeSize-2" value="2">
                             <label for="officeSize-2"><spring:message code='srv.cmm.021'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="officeSize" id="officeSize-3" value="3">
                             <label for="officeSize-3"><spring:message code='srv.cmm.022'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="officeSize" id="officeSize-4" value="4">
                             <label for="officeSize-4"><spring:message code='srv.cmm.023'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="officeSize" id="officeSize-5" value="5">
                             <label for="officeSize-5"><spring:message code='srv.cmm.024'/></label>
                         </div>
                     </li>
               	</ul>
               	<p class="lpl_title">
                    <span class="lpl_ico"></span>
                    <span class="lpl_txt"><spring:message code='srv.cmm.025'/></span>
                </p>
               	<ul class="dep_02 lpl_yn">
               		<li>
                         <div class="checks">
                             <input type="radio" name="year" id="year-1" value="1">
                             <label for="year-1"><spring:message code='srv.cmm.026'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="year" id="year-2" value="2">
                             <label for="year-2"><spring:message code='srv.cmm.027'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="year" id="year-3" value="3">
                             <label for="year-3"><spring:message code='srv.cmm.028'/></label>
                         </div>
                     </li>
                     <li>
                         <div class="checks">
                             <input type="radio" name="year" id="year-4" value="4">
                             <label for="year-4"><spring:message code='srv.cmm.029'/></label>
                         </div>
                     </li>
               	</ul>
               	<div class="btn_area">
		            <span class="btn btn-primary" ng-click="secondStep('step0','step1')">
		                <span><spring:message code='cmm.btn.003'/></span>
		            </span>
       			</div>
        	</div>
            <div class="dep_01 step1">
                <p class="lpl_title">
                    <span class="lpl_ico">1.</span>
                    <span class="lpl_txt"><spring:message code='srv.hot.p01'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">1.1</span>
                        <span class="lpl_txt"><spring:message code='srv.hot.p01.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-1" value="1">
                                <label for="1-1-1">① <spring:message code='srv.hot.a001'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-2" value="2">
                                <label for="1-1-2">② <spring:message code='srv.hot.a002'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">1.2</span>
                        <span class="lpl_txt"><spring:message code='srv.hot.p01.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-1" value="1">
                                <label for="1-2-1">① <spring:message code='srv.hot.a004'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-2" value="2">
                                <label for="1-2-2">② <spring:message code='srv.hot.a005'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-3" value="3">
                                <label for="1-2-3">③ <spring:message code='srv.hot.a006'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-4" value="4">
                                <label for="1-2-4">④ <spring:message code='srv.hot.a007'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-5" value="5" data-etc="etc">
                                <label for="1-2-5">⑤ <spring:message code='srv.hot.a008'/>( <input type="text" name="1-2text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">1.3</span>
                        <span class="lpl_txt"><spring:message code='srv.hot.p01.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-3" id="1-3-1" value="1">
                                <label for="1-3-1">① <spring:message code='srv.hot.a009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-3" id="1-3-2" value="2">
                                <label for="1-3-2">② <spring:message code='srv.hot.a010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-3" id="1-3-3" value="3">
                                <label for="1-3-3">③ <spring:message code='srv.hot.a011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-3" id="1-3-4" value="4">
                                <label for="1-3-4">④ <spring:message code='srv.hot.a012'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-3" id="1-3-5" value="5" data-etc="etc">
                                <label for="1-3-5">⑤ <spring:message code='srv.hot.a003'/>( <input type="text" name="1-3text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">1.4</span>
                        <span class="lpl_txt"><spring:message code='srv.hot.p01.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="1-4" id="1-4-1" value="1">
                                <label for="1-4-1">① <spring:message code='srv.hot.a013'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="1-4" id="1-4-2" value="2">
                                <label for="1-4-2">② <spring:message code='srv.hot.a014'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="1-4" id="1-4-3" value="3">
                                <label for="1-4-3">③ <spring:message code='srv.hot.a015'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="1-4" id="1-4-4" value="4">
                                <label for="1-4-4">④ <spring:message code='srv.hot.a016'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="1-4" id="1-4-5" value="5">
                                <label for="1-4-5">⑤ <spring:message code='srv.hot.a017'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="1-4" id="1-4-6" value="6">
                                <label for="1-4-6">⑥ <spring:message code='srv.hot.a018'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="1-4" id="1-4-7" value="7">
                                <label for="1-4-7">⑦ <spring:message code='srv.hot.a019'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="1-4" id="1-4-8" value="8" data-etc="etc">
                                <label for="1-4-8">⑧ <spring:message code='srv.hot.a003'/>( <input type="text" name="1-4text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
				</div>
            </div>
			
			<div class="dep_01 step1">
                <p class="lpl_title">
                    <span class="lpl_ico">2.</span>
                    <span class="lpl_txt"><spring:message code='srv.hot.p02'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">2.1</span>
                        <span class="lpl_txt"><spring:message code='srv.hot.p02.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-1" value="1">
                                <label for="2-1-1">① <spring:message code='srv.hot.a020'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-2" value="2">
                                <label for="2-1-2">② <spring:message code='srv.hot.a021'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-3" value="3">
                                <label for="2-1-3">③ <spring:message code='srv.hot.a022'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-4" value="4">
                                <label for="2-1-4">④ <spring:message code='srv.hot.a023'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-5" value="5">
                                <label for="2-1-5">⑤ <spring:message code='srv.hot.a024'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.2</span>
                        <span class="lpl_txt"><spring:message code='srv.hot.p02.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-1" value="1">
                                <label for="2-2-1">① <spring:message code='srv.hot.a025'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-2" value="2">
                                <label for="2-2-2">② <spring:message code='srv.hot.a026'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-3" value="3">
                                <label for="2-2-3">③ <spring:message code='srv.hot.a027'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-4" value="4">
                                <label for="2-2-4">④ <spring:message code='srv.hot.a028'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-5" value="5">
                                <label for="2-2-5">⑤ <spring:message code='srv.hot.a029'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.3</span>
                        <span class="lpl_txt"><spring:message code='srv.hot.p02.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-1" value="1">
                                <label for="2-3-1">① <spring:message code='srv.hot.a030'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-2" value="2">
                                <label for="2-3-2">② <spring:message code='srv.hot.a031'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-3" value="3">
                                <label for="2-3-3">③ <spring:message code='srv.hot.a032'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-4" value="4">
                                <label for="2-3-4">④ <spring:message code='srv.hot.a033'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-5" value="5">
                                <label for="2-3-5">⑤ <spring:message code='srv.hot.a034'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-6" value="6">
                                <label for="2-3-6">⑥ <spring:message code='srv.hot.a035'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.4</span>
                        <span class="lpl_txt"><spring:message code='srv.hot.p02.q04'/></span>
                    </p>
                    <div class="dep_03">
                    	<input type="hidden" name="2-4" id="2-4" value="0"/>
						<textarea name="2-4text" id="2-4text" class="lpl_textarea" cols="30" rows="5"></textarea>
					</div>
               		<div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step2','submit')">
			                <span><spring:message code='cmm.btn.004'/></span>
			            </span>
        			</div>
                </div>
            </div>
        </form:form>    
        </div>
    </div>