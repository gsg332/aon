<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
	<div class="poll_box">
        <!-- Sports -->
        <div class="layout_poll">        
        <form:form name="surveyForm" id="surveyForm">
        <input type="hidden" name="surveyId" id="surveyId" value="6"/>
        <input type="hidden" name="userLanguage" id="userLanguage" value="{{userlocale}}"/>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
        <p class="lpl_title_b"><spring:message code='srv.pag.006'/></p>
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
                    <span class="lpl_txt"><spring:message code='srv.but.p01'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">1.1</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p01.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-1" value="1">
                                <label for="1-1-1">① <spring:message code='srv.but.a001'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-2" value="2">
                                <label for="1-1-2">② <spring:message code='srv.but.a002'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-3" value="3">
                                <label for="1-1-3">③ <spring:message code='srv.but.a003'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-4" value="4">
                                <label for="1-1-4">④ <spring:message code='srv.but.a004'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-5" value="5">
                                <label for="1-1-5">⑤ <spring:message code='srv.but.a005'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">1.2</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p01.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-1" value="1">
                                <label for="1-2-1">① <spring:message code='srv.but.a006'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-2" value="2">
                                <label for="1-2-2">② <spring:message code='srv.but.a007'/></label>
                            </div>
                        </li>
                    </ul>
                    <div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step1','step2','beauty')">
			                <span><spring:message code='cmm.btn.003'/></span>
			            </span>
        			</div>
                </div>
            </div>
			
			<div class="dep_01 step2">
                <p class="lpl_title">
                    <span class="lpl_ico">2.</span>
                    <span class="lpl_txt"><spring:message code='srv.but.p02'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">2.1</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p02.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-1" value="1">
                                <label for="2-1-1">① <spring:message code='srv.but.a008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-2" value="2">
                                <label for="2-1-2">② <spring:message code='srv.but.a009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-3" value="3">
                                <label for="2-1-3">③ <spring:message code='srv.but.a010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-4" value="4">
                                <label for="2-1-4">④ <spring:message code='srv.but.a011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-5" value="5">
                                <label for="2-1-5">⑤ <spring:message code='srv.but.a012'/></label>
                            </div>
                        </li>
                        <li>
                        	<div class="checks">
                                <input type="radio" name="2-1" id="2-1-6" value="6" data-etc="etc">
                                <label for="2-1-6">⑥ <spring:message code='srv.but.a005'/>( <input type="text" name="2-1text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.2</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p02.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-1" value="1">
                                <label for="2-2-1">① <spring:message code='srv.but.a013'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-2" value="2">
                                <label for="2-2-2">② <spring:message code='srv.but.a014'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-3" value="3">
                                <label for="2-2-3">③ <spring:message code='srv.but.a015'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-4" value="4">
                                <label for="2-2-4">④ <spring:message code='srv.but.a016'/></label>
                            </div>
                        </li>
                        <li>
                        	<div class="checks">
                                <input type="radio" name="2-2" id="2-2-5" value="5" data-etc="etc">
                                <label for="2-2-5">⑤ <spring:message code='srv.but.a005'/>( <input type="text" name="2-2text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.3</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p02.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-1" value="1">
                                <label for="2-3-1">① <spring:message code='srv.but.a017'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-2" value="2">
                                <label for="2-3-2">② <spring:message code='srv.but.a018'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-3" value="3">
                                <label for="2-3-3">③ <spring:message code='srv.but.a019'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-4" value="4">
                                <label for="2-3-4">④ <spring:message code='srv.but.a020'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-5" value="5">
                                <label for="2-3-5">⑤ <spring:message code='srv.but.a021'/></label>
                            </div>
                        </li>
                        <li>
                        	<div class="checks">
                                <input type="radio" name="2-3" id="2-3-6" value="6" data-etc="etc">
                                <label for="2-3-6">⑥ <spring:message code='srv.but.a005'/>( <input type="text" name="2-3text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.4</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p02.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-1" value="1">
                                <label for="2-4-1">① <spring:message code='srv.but.a022'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-2" value="2">
                                <label for="2-4-2">② <spring:message code='srv.but.a023'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-3" value="3">
                                <label for="2-4-3">③ <spring:message code='srv.but.a024'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-4" value="4">
                                <label for="2-4-4">④ <spring:message code='srv.but.a025'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-5" value="5">
                                <label for="2-4-5">⑤ <spring:message code='srv.but.a026'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.5</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p02.q05'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-5" id="2-5-1" value="1">
                                <label for="2-5-1">① <spring:message code='srv.but.a027'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-5" id="2-5-2" value="2">
                                <label for="2-5-2">② <spring:message code='srv.but.a028'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-5" id="2-5-3" value="3">
                                <label for="2-5-3">③ <spring:message code='srv.but.a029'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-5" id="2-5-4" value="4">
                                <label for="2-5-4">④ <spring:message code='srv.but.a030'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-5" id="2-5-5" value="5">
                                <label for="2-5-5">⑤ <spring:message code='srv.but.a031'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.6</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p02.q06'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-6" id="2-6-1" value="1">
                                <label for="2-6-1">① <spring:message code='srv.but.a032'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-6" id="2-6-2" value="2">
                                <label for="2-6-2">② <spring:message code='srv.but.a033'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-6" id="2-6-3" value="3">
                                <label for="2-6-3">③ <spring:message code='srv.but.a034'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-6" id="2-6-4" value="4">
                                <label for="2-6-4">④ <spring:message code='srv.but.a035'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.7</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p02.q07'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-7" id="2-7-1" value="1">
                                <label for="2-7-1">① <spring:message code='srv.but.a036'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-7" id="2-7-2" value="2">
                                <label for="2-7-2">② <spring:message code='srv.but.a037'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-7" id="2-7-3" value="3">
                                <label for="2-7-3">③ <spring:message code='srv.but.a038'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-7" id="2-7-4" value="4" data-etc="etc">
                                <label for="2-7-4">⑤ <spring:message code='srv.but.a005'/>( <input type="text" name="2-7text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step2','step4')">
			                <span><spring:message code='cmm.btn.003'/></span>
			            </span>
        			</div>
               </div>
            </div>	
			<div class="dep_01 step3">
                <p class="lpl_title">
                    <span class="lpl_ico">3.</span>
                    <span class="lpl_txt"><spring:message code='srv.but.p03'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">3.1</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p03.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-1" id="3-1-1" value="1">
                                <label for="3-1-1">① <spring:message code='srv.but.a039'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-1" id="3-1-2" value="2">
                                <label for="3-1-2">② <spring:message code='srv.but.a040'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-1" id="3-1-3" value="3">
                                <label for="3-1-3">③ <spring:message code='srv.but.a041'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-1" id="3-1-4" value="4">
                                <label for="3-1-4">④ <spring:message code='srv.but.a042'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-1" id="3-1-5" value="5">
                                <label for="3-1-5">⑤ <spring:message code='srv.but.a043'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">3.2</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p03.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-1" value="1">
                                <label for="3-2-1">① <spring:message code='srv.but.a044'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-2" value="2">
                                <label for="3-2-2">② <spring:message code='srv.but.a045'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-3" value="3">
                                <label for="3-2-3">③ <spring:message code='srv.but.a046'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-4" value="4">
                                <label for="3-2-4">④ <spring:message code='srv.but.a047'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-5" value="5">
                                <label for="3-2-5">⑤ <spring:message code='srv.but.a048'/></label>
                            </div>
                        </li>
                    </ul>
                    <div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step3','step4')">
			                <span><spring:message code='cmm.btn.003'/></span>
			            </span>
        			</div>
               </div>
            </div>	
			
			<div class="dep_01 step4">
                <p class="lpl_title">
                    <span class="lpl_ico">4.</span>
                    <span class="lpl_txt"><spring:message code='srv.but.p04'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">4.1</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p04.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-1" id="4-1-1" value="1">
                                <label for="4-1-1">① <spring:message code='srv.but.a049'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-1" id="4-1-2" value="2">
                                <label for="4-1-2">② <spring:message code='srv.but.a050'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.2</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p04.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-1"  value="1">
                                <label for="4-2-1">① <spring:message code='srv.but.a013'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-2"  value="2">
                                <label for="4-2-2">② <spring:message code='srv.but.a014'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-3" value="3">
                                <label for="4-2-3">③ <spring:message code='srv.but.a051'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-4" value="4">
                                <label for="4-2-4">④ <spring:message code='srv.but.a052'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-5" value="5">
                                <label for="4-2-5">⑤ <spring:message code='srv.but.a005'/>( <input type="text" name="2-7text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.3</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p04.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="4-3" id="4-3-1" value="1">
                                <label for="4-3-1">① <spring:message code='srv.but.a053'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="4-3" id="4-3-2" value="2">
                                <label for="4-3-2">② <spring:message code='srv.but.a054'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="4-3" id="4-3-3" value="3">
                                <label for="4-3-3">③ <spring:message code='srv.but.a055'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="4-3" id="4-3-4" value="4">
                                <label for="4-3-4">④ <spring:message code='srv.but.a056'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="4-3" id="4-3-5" value="5">
                                <label for="4-3-5">⑤ <spring:message code='srv.but.a005'/>( <input type="text" name="4-3text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.4</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p04.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                         <li>
                            <div class="checks">
                                <input type="radio" name="4-4" id="4-4-1" value="1">
                                <label for="4-4-1">① <spring:message code='srv.but.a049'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-4" id="4-4-2" value="2">
                                <label for="4-4-2">② <spring:message code='srv.but.a050'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.5</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p04.q05'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-5" id="4-5-1" value="1">
                                <label for="4-5-1">① <spring:message code='srv.but.a057'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-5" id="4-5-2" value="2">
                                <label for="4-5-2">② <spring:message code='srv.but.a058'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-5" id="4-5-3" value="3">
                                <label for="4-5-3">③ <spring:message code='srv.but.a059'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-5" id="4-5-4" value="4">
                                <label for="4-5-4">④ <spring:message code='srv.but.a060'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-5" id="4-5-5" value="5">
                                <label for="4-5-5">⑤ <spring:message code='srv.but.a005'/>( <input type="text" name="4-5text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.6</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p04.q06'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="hidden" name="4-6" id="4-6-1" value="0">
                                <label for="4-6-1">( <input type="text" name="4-6text" id="" title="etc" style="width:350px;"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.7</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p04.q07'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="hidden" name="4-7" id="4-7-1" value="0">
                                <label for="4-7-1">( <input type="text" name="4-7text" id="" title="etc" style="width:350px;"> )</label>
                            </div>            
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.8</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p04.q08'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-8" id="4-8-1" value="1">
                                <label for="4-8-1">① <spring:message code='srv.but.a061'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-8" id="4-8-2" value="2">
                                <label for="4-8-2">② <spring:message code='srv.but.a062'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-8" id="4-8-3" value="3">
                                <label for="4-8-3">③ <spring:message code='srv.but.a063'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-8" id="4-8-4" value="4">
                                <label for="4-8-4">④ <spring:message code='srv.but.a064'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.9</span>
                        <span class="lpl_txt"><spring:message code='srv.but.p04.q09'/></span>
                    </p>
                    <div class="dep_03">
                    	<input type="hidden" name="4-9" id="4-9" value="0"/>
						<textarea name="4-9text" id="4-9text" class="lpl_textarea" cols="30" rows="5"></textarea>
					</div>
					<div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step4','submit')">
			                <span><spring:message code='cmm.btn.004'/></span>
			            </span>
        			</div>
                </div>
            </div>
        </form:form>    
        </div>
    </div>