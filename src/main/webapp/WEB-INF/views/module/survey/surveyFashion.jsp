<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>

	<div class="poll_box">
        <!-- Sports -->
        <div class="layout_poll">        
        <form:form name="surveyForm" id="surveyForm">
        <input type="hidden" name="surveyId" id="surveyId" value="8"/>
        <input type="hidden" name="userLanguage" id="userLanguage" value="{{userlocale}}"/>
        <p class="lpl_title_b"><spring:message code='srv.pag.008'/></p>
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
                    <span class="lpl_txt"><spring:message code='srv.fas.p01'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">1.1</span>
                        <span class="lpl_txt"><spring:message code='srv.fas.p01.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-1" value="1">
                                <label for="1-1-1">① <spring:message code='srv.fas.a004'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-2" value="2">
                                <label for="1-1-2">② <spring:message code='srv.fas.a005'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-3" value="3">
                                <label for="1-1-3">③ <spring:message code='srv.fas.a006'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-4" value="4">
                                <label for="1-1-4">④ <spring:message code='srv.fas.a007'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-5" value="5">
                                <label for="1-1-5">⑤ <spring:message code='srv.fas.a003'/>( <input type="text" name="1-1text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">1.2</span>
                        <span class="lpl_txt"><spring:message code='srv.fas.p01.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-1" value="1">
                                <label for="1-2-1">① <spring:message code='srv.fas.a008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-2" value="2">
                                <label for="1-2-2">② <spring:message code='srv.fas.a009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-3" value="3">
                                <label for="1-2-3">③ <spring:message code='srv.fas.a010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-4" value="4">
                                <label for="1-2-4">④ <spring:message code='srv.fas.a011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-5" value="5" data-etc="etc">
                                <label for="1-2-5">⑤ <spring:message code='srv.fas.a003'/>( <input type="text" name="1-2text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">1.3</span>
                        <span class="lpl_txt"><spring:message code='srv.fas.p01.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-3" id="1-3-1" value="1">
                                <label for="1-3-1">① <spring:message code='srv.fas.a012'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-3" id="1-3-2" value="2">
                                <label for="1-3-2">② <spring:message code='srv.fas.a013'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-3" id="1-3-3" value="3">
                                <label for="1-3-3">③ <spring:message code='srv.fas.a014'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-3" id="1-3-4" value="4">
                                <label for="1-3-4">④ <spring:message code='srv.fas.a015'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-3" id="1-3-5" value="5" data-etc="etc">
                                <label for="1-3-5">⑤ <spring:message code='srv.fas.a003'/>( <input type="text" name="1-3text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">1.4</span>
                        <span class="lpl_txt"><spring:message code='srv.fas.p01.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-4" id="1-4-1" value="1">
                                <label for="1-4-1">① <spring:message code='srv.fas.a016'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-4" id="1-4-2" value="2">
                                <label for="1-4-2">② <spring:message code='srv.fas.a017'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-4" id="1-4-3" value="3">
                                <label for="1-4-3">③ <spring:message code='srv.fas.a018'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-4" id="1-4-4" value="4">
                                <label for="1-4-4">④ <spring:message code='srv.fas.a019'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-4" id="1-4-5" value="5" data-etc="etc">
                                <label for="1-4-5">⑤ <spring:message code='srv.fas.a003'/>( <input type="text" name="1-4text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">1.5</span>
                        <span class="lpl_txt"><spring:message code='srv.fas.p01.q05'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-5" id="1-5-1" value="1">
                                <label for="1-5-1">① <spring:message code='srv.fas.a020'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-5" id="1-5-2" value="2">
                                <label for="1-5-2">② <spring:message code='srv.fas.a021'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-5" id="1-5-3" value="3">
                                <label for="1-5-3">③ <spring:message code='srv.fas.a022'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-5" id="1-5-4" value="4">
                                <label for="1-5-4">④ <spring:message code='srv.fas.a023'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-5" id="1-5-5" value="5" data-etc="etc">
                                <label for="1-5-5">⑤ <spring:message code='srv.fas.a003'/>( <input type="text" name="1-5text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
               		<p class="lpl_question">
                        <span class="lpl_ico">1.6</span>
                        <span class="lpl_txt"><spring:message code='srv.fas.p01.q06'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-6" id="1-6-1" value="1">
                                <label for="1-6-1">① <spring:message code='srv.fas.a024'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-6" id="1-6-2" value="2">
                                <label for="1-6-2">② <spring:message code='srv.fas.a025'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-6" id="1-6-3" value="3">
                                <label for="1-6-3">③ <spring:message code='srv.fas.a026'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-6" id="1-6-4" value="4">
                                <label for="1-6-4">④ <spring:message code='srv.fas.a027'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-6" id="1-6-5" value="5" data-etc="etc">
                                <label for="1-6-5">⑤ <spring:message code='srv.fas.a003'/>( <input type="text" name="1-6text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step1','step2')">
			                <span><spring:message code='cmm.btn.003'/></span>
			            </span>
        			</div>
                </div>
            </div>
			
			<div class="dep_01 step2">
                <p class="lpl_title">
                    <span class="lpl_ico">2.</span>
                    <span class="lpl_txt"><spring:message code='srv.fas.p02'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">2.1</span>
                        <span class="lpl_txt"><spring:message code='srv.fas.p02.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="2-1" id="2-1-1" value="1">
                                <label for="2-1-1">① <spring:message code='srv.fas.a028'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="2-1" id="2-1-2" value="2">
                                <label for="2-1-2">② <spring:message code='srv.fas.a029'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="2-1" id="2-1-3" value="3">
                                <label for="2-1-3">③ <spring:message code='srv.fas.a030'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="2-1" id="2-1-4" value="4">
                                <label for="2-1-4">④ <spring:message code='srv.fas.a031'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="2-1" id="2-1-5" value="5">
                                <label for="2-1-5">④ <spring:message code='srv.fas.a032'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="2-1" id="2-1-6" value="6">
                                <label for="2-1-6">④ <spring:message code='srv.fas.a033'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="2-1" id="2-1-7" value="7">
                                <label for="2-1-7">⑥ <spring:message code='srv.fas.a003'/>( <input type="text" name="2-1text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.2</span>
                        <span class="lpl_txt"><spring:message code='srv.fas.p02.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-1" value="1">
                                <label for="2-2-1">① <spring:message code='srv.fas.a034'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-2" value="2">
                                <label for="2-2-2">② <spring:message code='srv.fas.a035'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-3" value="3">
                                <label for="2-2-3">③ <spring:message code='srv.fas.a036'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-4" value="4">
                                <label for="2-2-4">④ <spring:message code='srv.fas.a037'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-5" value="5">
                                <label for="2-2-5">⑤ <spring:message code='srv.fas.a038'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-6" value="6" data-etc="etc">
                                <label for="2-2-6">⑥ <spring:message code='srv.fas.a003'/>( <input type="text" name="2-2text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.3</span>
                        <span class="lpl_txt"><spring:message code='srv.fas.p02.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-1" value="1">
                                <label for="2-3-1">① <spring:message code='srv.fas.a001'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-2" value="2">
                                <label for="2-3-2">② <spring:message code='srv.fas.a002'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.4</span>
                        <span class="lpl_txt"><spring:message code='srv.fas.p02.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-1" value="1">
                                <label for="2-4-1">① <spring:message code='srv.fas.a039'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-2" value="2">
                                <label for="2-4-2">② <spring:message code='srv.fas.a040'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-3" value="3">
                                <label for="1-4-3">③ <spring:message code='srv.fas.a041'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-4" value="4" data-etc="etc">
                                <label for="2-4-4">④ <spring:message code='srv.fas.a003'/>( <input type="text" name="2-4text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.5</span>
                        <span class="lpl_txt"><spring:message code='srv.fas.p02.q05'/></span>
                    </p>
                    <div class="dep_03">
                    	<input type="hidden" name="2-5" id="2-5" value="0"/>
						<textarea name="2-5text" id="2-5text" class="lpl_textarea" cols="30" rows="5"></textarea>
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