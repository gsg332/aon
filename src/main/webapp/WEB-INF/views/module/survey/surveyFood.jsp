<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
	<div class="poll_box">
        <!-- Sports -->
        <div class="layout_poll">        
        <form:form name="surveyForm" id="surveyForm">
        <input type="hidden" name="surveyId" id="surveyId" value="5"/>
        <input type="hidden" name="userLanguage" id="userLanguage" value="{{userlocale}}"/>
        <p class="lpl_title_b"><spring:message code='srv.pag.005'/></p>
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
                    <span class="lpl_txt"><spring:message code='srv.f&b.p01'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">1.1</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p01.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-1" value="1">
                                <label for="1-1-1">① <spring:message code='srv.f&b.a001'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-2" value="2">
                                <label for="1-1-2">② <spring:message code='srv.f&b.a002'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-3" value="3">
                                <label for="1-1-3">③ <spring:message code='srv.f&b.a003'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-4" value="4">
                                <label for="1-1-4">④ <spring:message code='srv.f&b.a004'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-5" value="5">
                                <label for="1-1-5">⑤ <spring:message code='srv.f&b.a005'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">1.2</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p01.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-1" value="1">
                                <label for="1-2-1">① <spring:message code='srv.f&b.a006'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-2" value="2">
                                <label for="1-2-2">② <spring:message code='srv.f&b.a007'/></label>
                            </div>
                        </li>
                    </ul>
                    <div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step1','step2','food')">
			                <span><spring:message code='cmm.btn.003'/></span>
			            </span>
        			</div>
                </div>
            </div>
			
			<div class="dep_01 step2">
                <p class="lpl_title">
                    <span class="lpl_ico">2.</span>
                    <span class="lpl_txt"><spring:message code='srv.f&b.p02'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">2.1</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p02.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-1" value="1">
                                <label for="2-1-1">① <spring:message code='srv.f&b.a008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-2" value="2">
                                <label for="2-1-2">② <spring:message code='srv.f&b.a009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-3" value="3">
                                <label for="2-1-3">③ <spring:message code='srv.f&b.a010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-4" value="4">
                                <label for="2-1-4">④ <spring:message code='srv.f&b.a011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-5" value="5">
                                <label for="2-1-5">⑤ <spring:message code='srv.f&b.a012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.2</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p02.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-1" value="1">
                                <label for="2-2-1">① <spring:message code='srv.f&b.a013'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-2" value="2">
                                <label for="2-2-2">② <spring:message code='srv.f&b.a014'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-3" value="3">
                                <label for="2-2-3">③ <spring:message code='srv.f&b.a015'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-4" value="4">
                                <label for="2-2-4">④ <spring:message code='srv.f&b.a016'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-5" value="5">
                                <label for="2-2-5">⑤ <spring:message code='srv.f&b.a017'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.3</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p02.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-1" value="1">
                                <label for="2-3-1">① <spring:message code='srv.f&b.a018'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-2" value="2">
                                <label for="2-3-2">② <spring:message code='srv.f&b.a019'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-3" value="3">
                                <label for="2-3-3">③ <spring:message code='srv.f&b.a020'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-4" value="4">
                                <label for="2-3-4">④ <spring:message code='srv.f&b.a021'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-5" value="5">
                                <label for="2-3-5">⑤ <spring:message code='srv.f&b.a022'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.4</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p02.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="hidden" name="2-4" id="2-4-1" value="0">
                                <label for="2-4-1">①( <input type="text" name="2-4text" id="" title="etc" style="width:350px;">  )</label>
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
                    <span class="lpl_txt"><spring:message code='srv.f&b.p03'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">3.1</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p03.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="3-1" id="3-1-1" value="1">
                                <label for="3-1-1">① <spring:message code='srv.f&b.a023'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="3-1" id="3-1-2" value="2">
                                <label for="3-1-2">② <spring:message code='srv.f&b.a024'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="3-1" id="3-1-3" value="3">
                                <label for="3-1-3">③ <spring:message code='srv.f&b.a025'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="3-1" id="3-1-4" value="4">
                                <label for="3-1-4">④ <spring:message code='srv.f&b.a026'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="checkbox" name="3-1" id="3-1-5" value="5">
                                <label for="3-1-5">⑤ <spring:message code='srv.f&b.a027'/></label>
                            </div>
                        </li>
                          <li>
                            <div class="checks">
                                <input type="checkbox" name="3-1" id="3-1-6" value="6">
                                <label for="3-1-6">⑥ <spring:message code='srv.f&b.a028'/></label>
                            </div>
                        </li>
                          <li>
                            <div class="checks">
                                <input type="checkbox" name="3-1" id="3-1-7" value="7" data-etc="etc">
                                <label for="3-1-7">⑦ <spring:message code='srv.f&b.a029'/>( <input type="text" name="3-1text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">3.2</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p03.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-1" value="1">
                                <label for="3-2-1">① <spring:message code='srv.f&b.a030'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-2" value="2">
                                <label for="3-2-2">② <spring:message code='srv.f&b.a031'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-3" value="3">
                                <label for="3-2-3">③ <spring:message code='srv.f&b.a032'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-4" value="4">
                                <label for="3-2-4">④ <spring:message code='srv.f&b.a033'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-5" value="5">
                                <label for="3-2-5">⑤ <spring:message code='srv.f&b.a034'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-6" value="6">
                                <label for="3-2-6">⑥ <spring:message code='srv.f&b.a035'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-7" value="7" data-etc="etc">
                                <label for="3-2-7">⑤ <spring:message code='srv.f&b.a029'/>( <input type="text" name="3-2text" id="" title="etc"> )</label>
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
                    <span class="lpl_txt"><spring:message code='srv.f&b.p04'/></span>
                </p>
                <div class="dep_02">
                	<p class="strong"><spring:message code='srv.f&b.p07'/></p>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.1</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-1" id="4-1-1" value="1">
                                <label for="4-1-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-1" id="4-1-2" value="2">
                                <label for="4-1-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-1" id="4-1-3" value="3">
                                <label for="4-1-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-1" id="4-1-4" value="4">
                                <label for="4-1-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-1" id="4-1-5" value="5">
                                <label for="4-1-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.2</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-1"  value="1">
                                <label for="4-2-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-2"  value="2">
                                <label for="4-2-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-3" value="3">
                                <label for="4-2-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-4" value="4">
                                <label for="4-2-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-5" value="5">
                                <label for="4-2-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.3</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-3" id="4-3-1" value="1">
                                <label for="4-3-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-3" id="4-3-2" value="2">
                                <label for="4-3-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-3" id="4-3-3" value="3">
                                <label for="4-3-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-3" id="4-3-4" value="4">
                                <label for="4-3-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-3" id="4-3-5" value="5">
                                <label for="4-3-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.4</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-4" id="4-4-1" value="1">
                                <label for="4-4-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-4" id="4-4-2" value="2">
                                <label for="4-4-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-4" id="4-4-3" value="3">
                                <label for="4-4-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-4" id="4-4-4" value="4">
                                <label for="4-4-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-4" id="4-4-5" value="5">
                                <label for="4-4-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="strong"><spring:message code='srv.f&b.p08'/></p>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.5</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q05'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-5" id="4-5-1" value="1">
                                <label for="4-5-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-5" id="4-5-2" value="2">
                                <label for="4-5-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-5" id="4-5-3" value="3">
                                <label for="4-5-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-5" id="4-5-4" value="4">
                                <label for="4-5-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-5" id="4-5-5" value="5">
                                <label for="4-5-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.6</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q06'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-6" id="4-6-1" value="1">
                                <label for="4-6-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-6" id="4-6-2" value="2">
                                <label for="4-6-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-6" id="4-6-3" value="3">
                                <label for="4-6-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-6" id="4-6-4" value="4">
                                <label for="4-6-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-6" id="4-6-5" value="5">
                                <label for="4-6-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.7</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q07'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-7" id="4-7-1" value="1">
                                <label for="4-7-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-7" id="4-7-2" value="2">
                                <label for="4-7-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-7" id="4-7-3" value="3">
                                <label for="4-7-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-7" id="4-7-4" value="4">
                                <label for="4-7-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-7" id="4-7-5" value="5">
                                <label for="4-7-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.8</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q08'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-8" id="4-8-1" value="1">
                                <label for="4-8-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-8" id="4-8-2" value="2">
                                <label for="4-8-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-8" id="4-8-3" value="3">
                                <label for="4-8-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-8" id="4-8-4" value="4">
                                <label for="4-8-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-8" id="4-8-5" value="5">
                                <label for="4-8-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="strong"><spring:message code='srv.f&b.p09'/></p>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.9</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q09'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-9" id="4-9-1" value="1">
                                <label for="4-9-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-9" id="4-9-2" value="2">
                                <label for="4-9-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-9" id="4-9-3" value="3">
                                <label for="4-9-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-9" id="4-9-4" value="4">
                                <label for="4-9-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-9" id="4-9-5" value="5">
                                <label for="4-9-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.10</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q10'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-10" id="4-10-1" value="1">
                                <label for="4-10-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-10" id="4-10-2" value="2">
                                <label for="4-10-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-10" id="4-10-3" value="3">
                                <label for="4-10-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-10" id="4-10-4" value="4">
                                <label for="4-10-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-10" id="4-10-5" value="5">
                                <label for="4-10-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.11</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q11'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-11" id="4-11-1" value="1">
                                <label for="4-11-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-11" id="4-11-2" value="2">
                                <label for="4-11-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-11" id="4-11-3" value="3">
                                <label for="4-11-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-11" id="4-11-4" value="4">
                                <label for="4-11-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-11" id="4-11-5" value="5">
                                <label for="4-11-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">4.12</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p04.q12'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-12" id="4-12-1" value="1">
                                <label for="4-12-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-12" id="4-12-2" value="2">
                                <label for="4-12-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-12" id="4-12-3" value="3">
                                <label for="4-12-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-12" id="4-12-4" value="4">
                                <label for="4-12-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-12" id="4-12-5" value="5">
                                <label for="4-12-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
					<div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step4','step5')">
			                <span><spring:message code='cmm.btn.003'/></span>
			            </span>
        			</div>
                </div>
            </div>
            <div class="dep_01 step5">
                <p class="lpl_title">
                    <span class="lpl_ico">5.</span>
                    <span class="lpl_txt"><spring:message code='srv.f&b.p05'/></span>
                </p>
                <div class="dep_02">
                	<p class="lpl_question">
                        <span class="lpl_ico">5.1</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p05.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-1" id="5-1-1" value="1">
                                <label for="5-1-1">① <spring:message code='srv.f&b.a036'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-1" id="5-1-2" value="2">
                                <label for="5-1-2">② <spring:message code='srv.f&b.a037'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-1" id="5-1-3" value="3">
                                <label for="5-1-3">③ <spring:message code='srv.f&b.a038'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-1" id="5-1-4" value="4">
                                <label for="5-1-4">④ <spring:message code='srv.f&b.a039'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-1" id="5-1-5" value="5">
                                <label for="5-1-5">⑤ <spring:message code='srv.f&b.a040'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-1" id="5-1-6" value="6" data-etc="etc">
                                <label for="5-1-6">⑥ <spring:message code='srv.f&b.a029'/>( <input type="text" name="5-1text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.2</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p05.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-2" id="5-2-1"  value="1">
                                <label for="5-2-1">① <spring:message code='srv.f&b.a006'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-2" id="5-2-2"  value="2">
                                <label for="5-2-2">② <spring:message code='srv.f&b.a007'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.3</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p05.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-3" id="5-3-1"  value="1">
                                <label for="5-3-1">① <spring:message code='srv.f&b.a006'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-3" id="5-3-2"  value="2">
                                <label for="5-3-2">② <spring:message code='srv.f&b.a007'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.4</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p05.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="hidden" name="5-4" id="5-4-1" value="0">
                                <label for="5-4-1">( <input type="text" name="5-4text" id="" title="etc" style="width:350px;"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.5</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p05.q05'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-5" id="5-5-1" value="1">
                                <label for="5-5-1">① <spring:message code='srv.f&b.a041'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-5" id="5-5-2" value="2">
                                <label for="5-5-2">② <spring:message code='srv.f&b.a042'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-5" id="5-5-3" value="3">
                                <label for="5-5-3">③ <spring:message code='srv.f&b.a043'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-5" id="5-5-4" value="4">
                                <label for="5-5-4">④ <spring:message code='srv.f&b.a044'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-5" id="5-5-5" value="5">
                                <label for="5-5-5">⑤ <spring:message code='srv.f&b.a045'/></label>
                            </div>
                        </li>
                    	<li>
                            <div class="checks">
                                <input type="radio" name="5-5" id="5-5-6" value="6" data-etc="etc">
                                <label for="5-5-6">⑤ <spring:message code='srv.f&b.a029'/>( <input type="text" name="5-5text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.6</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p05.q06'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="hidden" name="5-6" id="5-6-1" value="0">
                                <label for="5-6-1">( <input type="text" name="5-6text" id="" title="etc" style="width:350px;"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.7</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p05.q07'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-7" id="5-7-1" value="1">
                                <label for="5-7-1">① <spring:message code='srv.f&b.a047'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-7" id="5-7-2" value="2">
                                <label for="5-7-2">② <spring:message code='srv.f&b.a048'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-7" id="5-7-3" value="3">
                                <label for="5-7-3">③ <spring:message code='srv.f&b.a049'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-7" id="5-7-4" value="4">
                                <label for="5-7-4">④ <spring:message code='srv.f&b.a050'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-7" id="5-7-5" value="5">
                                <label for="5-7-5">⑤ <spring:message code='srv.f&b.a051'/></label>
                            </div>
                        </li>
                        
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.8</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p05.q08'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-8" id="5-8-1" value="1">
                                <label for="5-8-1">① <spring:message code='srv.f&b.a041'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-8" id="5-8-2" value="2">
                                <label for="5-8-2">② <spring:message code='srv.f&b.a042'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-8" id="5-8-3" value="3">
                                <label for="5-8-3">③ <spring:message code='srv.f&b.a046'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-8" id="5-8-4" value="4">
                                <label for="5-8-4">④ <spring:message code='srv.f&b.a044'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-8" id="5-8-5" value="5">
                                <label for="5-8-5">⑤ <spring:message code='srv.f&b.a045'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-8" id="5-8-6" value="6" data-etc="etc">
                                <label for="5-8-6">⑤ <spring:message code='srv.f&b.a029'/>( <input type="text" name="5-8text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.9</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p05.q09'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-9" id="5-9-1" value="1">
                                <label for="5-9-1">① <spring:message code='srv.f&b.a052'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-9" id="5-9-2" value="2">
                                <label for="5-9-2">② <spring:message code='srv.f&b.a053'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-9" id="5-9-3" value="3">
                                <label for="5-9-3">③ <spring:message code='srv.f&b.a054'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-9" id="5-9-4" value="4">
                                <label for="5-9-4">④ <spring:message code='srv.f&b.a055'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-9" id="5-9-5" value="5" data-etc="etc">
                                <label for="5-9-5">⑤ <spring:message code='srv.f&b.a029'/>( <input type="text" name="5-9text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.10</span>
                        <span class="lpl_txt"><spring:message code='srv.f&b.p05.q10'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-10" id="5-10-1" value="1">
                                <label for="5-10-1">① <spring:message code='srv.f&b.a006'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-10" id="5-10-2" value="2">
                                <label for="5-10-2">② <spring:message code='srv.f&b.a007'/></label>
                            </div>
                        </li>
                    </ul>
 					<div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step5','step6')">
			                <span><spring:message code='cmm.btn.003'/></span>
			            </span>
        			</div>
                </div>
            </div>
            <div class="dep_01 step6">
                <p class="lpl_title">
                    <span class="lpl_ico">6.</span>
                    <span class="lpl_txt"><spring:message code='srv.f&b.p06'/></span>
                </p>
                <div class="dep_02">
                    <div class="dep_03">
						<input type="hidden" name="6-1" id="6-1" value="0"/>
						<textarea name="6-1text" id="6-1text" class="lpl_textarea" cols="30" rows="5"></textarea>
					</div>
                </div>
                <div class="btn_area">
		            <span class="btn btn-primary" ng-click="nextStep('step6','submit')">
		                <span><spring:message code='cmm.btn.004'/></span>
		            </span>
        		</div>
            </div>
        </form:form>    
        </div>
    </div>