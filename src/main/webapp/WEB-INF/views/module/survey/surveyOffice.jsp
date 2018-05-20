<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
	<div class="poll_box">
        <!-- Sports -->
        <div class="layout_poll">        
        <form:form name="surveyForm" id="surveyForm">
        <input type="hidden" name="surveyId" id="surveyId" value="1"/>
        <input type="hidden" name="userId" id="userId" value="1"/>
        <input type="hidden" name="userLanguage" id="userLanguage" value="{{userlocale}}"/>
        <p class="lpl_title_b" id="title"><spring:message code='srv.pag.001'/></p>
        	<div class="dep_01 step0">
        		<p class="lpl_title">        			
                    <span class="lpl_txt"><spring:message code='srv.cmm.001'/></span>
        		</p>
        		<p class="lpl_question">        			
					<label style="width : 50px;">Email</label> <input type="text" name="email"  id="email" placeholder="ex) user@aon.com">
				</p>
				<p class="lpl_question">
					<label style="width : 50px;">Name</label> <input type="text" name="userName" id="userName">                            
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
                    <span class="lpl_txt"><spring:message code='srv.que.p01'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">1.1</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p01.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-1" value="1" ng-click="checkImprove=1">
                                <label for="1-1-1">① <spring:message code='srv.opt.0001'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-2" value="2" ng-click="checkImprove=2">
                                <label for="1-1-2">② <spring:message code='srv.opt.0002'/></label>
                            </div>
                        </li>
                    </ul>
                    <div ng-show="checkImprove==1">
                    <p class="lpl_question">
                        <span class="lpl_ico">1.2</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p01.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-1" value="1">
                                <label for="1-2-1">① <spring:message code='srv.opt.0003'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-2" value="2">
                                <label for="1-2-2">② <spring:message code='srv.opt.0004'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-3" value="3">
                                <label for="1-2-3">③ <spring:message code='srv.opt.0005'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-4" value="4">
                                <label for="1-2-4">④ <spring:message code='srv.opt.0006'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-2" id="1-2-5" value="5" data-etc="etc">
                                <label for="1-2-5">⑤ <spring:message code='srv.opt.0007'/>( <input type="text" name="1-2text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    </div>
                    <div ng-show="checkImprove==2">
	                    <p class="lpl_question">
	                        <span class="lpl_ico">1.3</span>
	                        <span class="lpl_txt"><spring:message code='srv.ofc.p01.q03'/></span>
	                    </p>
	                    <ul class="dep_03 lpl_yn">
	                        <li>
	                            <div class="checks">
	                                <input type="radio" name="1-3" id="1-3-1" value="1">
	                                <label for="1-3-1">① <spring:message code='srv.opt.0003'/></label>
	                            </div>
	                        </li>
	                        <li>
	                            <div class="checks">
	                                <input type="radio" name="1-3" id="1-3-2" value="2">
	                                <label for="1-3-2">② <spring:message code='srv.opt.0004'/></label>
	                            </div>
	                        </li>
	                        <li>
	                            <div class="checks">
	                                <input type="radio" name="1-3" id="1-3-3" value="3">
	                                <label for="1-3-3">③ <spring:message code='srv.opt.0005'/></label>
	                            </div>
	                        </li>
	                        <li>
	                            <div class="checks">
	                                <input type="radio" name="1-3" id="1-3-4" value="4"> 
	                                <label for="1-3-4">④ <spring:message code='srv.opt.0006'/></label>
	                            </div>
	                        </li>
	                        <li>
	                            <div class="checks">
	                                <input type="radio" name="1-3" id="1-3-5" value="5" data-etc="etc">
	                                <label for="1-3-5">⑤ <spring:message code='srv.opt.0007'/>( <input type="text" name="1-3text" id="" title="etc"> )</label>
	                            </div>
	                        </li>
	                    </ul>
	                    <p class="lpl_question">
	                        <span class="lpl_ico">1.4</span>
	                        <span class="lpl_txt"><spring:message code='srv.ofc.p01.q04'/></span>
	                    </p>
	                    <ul class="dep_03 lpl_yn">
	                        <li>
	                            <div class="checks">
	                                <input type="radio" name="1-4" id="1-4-1" value="1">
	                                <label for="1-4-1">① <spring:message code='srv.opt.0003'/></label>
	                            </div>
	                        </li>
	                        <li>
	                            <div class="checks">
	                                <input type="radio" name="1-4" id="1-4-2" value="2">
	                                <label for="1-4-2">② <spring:message code='srv.opt.0004'/></label>
	                            </div>
	                        </li>
	                        <li>
	                            <div class="checks">
	                                <input type="radio" name="1-4" id="1-4-3" value="3">
	                                <label for="1-4-3">③ <spring:message code='srv.opt.0005'/></label>
	                            </div>
	                        </li>
	                        <li>
	                            <div class="checks">
	                                <input type="radio" name="1-4" id="1-4-4" value="4">
	                                <label for="1-4-4">④ <spring:message code='srv.opt.0006'/></label>
	                            </div>
	                        </li>
	                        <li>
	                            <div class="checks">
	                                <input type="radio" name="1-4" id="1-4-5" value="5" data-etc="etc">
	                                <label for="1-4-5">⑤ <spring:message code='srv.opt.0007'/>( <input type="text" name="1-4text" id="" title="etc"> )</label>
	                            </div>
	                        </li>
	                    </ul>
	                    <p class="lpl_question">
	                        <span class="lpl_ico">1.5</span>
	                        <span class="lpl_txt"><spring:message code='srv.ofc.p01.q05'/></span>
	                    </p>
	                    <div class="dep_03">
	                    	<input type="hidden" name="1-5" id="1-5" value="0" data-etc="etc"/>
							<textarea name="1-5text" id="1-5text" class="lpl_textarea" cols="30" rows="3"></textarea>
						</div>                    
					</div>
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
                    <span class="lpl_txt"><spring:message code='srv.que.p02'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">2.1</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p02.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-1" value="1">
                                <label for="2-1-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-2" value="2">
                                <label for="2-1-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-3" value="3">
                                <label for="2-1-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-4" value="4">
                                <label for="2-1-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-1" id="2-1-5" value="5">
                                <label for="2-1-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.2</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p02.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-1" value="1">
                                <label for="2-2-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-2" value="2">
                                <label for="2-2-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-3" value="3">
                                <label for="2-2-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-4" value="4">
                                <label for="2-2-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-2" id="2-2-5" value="5">
                                <label for="2-2-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.2</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p02.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-1" value="1">
                                <label for="2-3-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-2" value="2">
                                <label for="2-3-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-3" value="3">
                                <label for="2-3-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-4" value="4">
                                <label for="2-3-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-3" id="2-3-5" value="5">
                                <label for="2-3-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.4</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p02.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-1" value="1">
                                <label for="2-4-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-2" value="2">
                                <label for="2-4-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-3" value="3">
                                <label for="2-4-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-4" value="4">
                                <label for="2-4-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-4" id="2-4-5" value="5">
                                <label for="2-4-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.5</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p02.q05'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-5" id="2-5-1" value="1">
                                <label for="2-5-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-5" id="2-5-2" value="2">
                                <label for="2-5-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-5" id="2-5-3" value="3">
                                <label for="2-5-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-5" id="2-5-4" value="4">
                                <label for="2-5-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-5" id="2-5-5" value="5">
                                <label for="2-5-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.6</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p02.q06'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-6" id="2-6-1" value="1">
                                <label for="2-6-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-6" id="2-6-2" value="2">
                                <label for="2-6-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-6" id="2-6-3" value="3">
                                <label for="2-6-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-6" id="2-6-4" value="4">
                                <label for="2-6-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-6" id="2-6-5" value="5">
                                <label for="2-6-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.7</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p02.q07'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-7" id="2-7-1" value="1">
                                <label for="2-7-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-7" id="2-7-2" value="2">
                                <label for="2-7-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-7" id="2-7-3" value="3">
                                <label for="2-7-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-7" id="2-7-4" value="4">
                                <label for="2-7-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-7" id="2-7-5" value="5">
                                <label for="2-7-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">2.8</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p02.q08'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-8" id="2-8-1" value="1">
                                <label for="2-8-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-8" id="2-8-2" value="2">
                                <label for="2-8-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-8" id="2-8-3" value="3">
                                <label for="2-8-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-8" id="2-8-4" value="4">
                                <label for="2-8-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-8" id="2-8-5" value="5">
                                <label for="2-8-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step2','step3')">
			                <span><spring:message code='cmm.btn.003'/></span>
			            </span>
        			</div>
                </div>
            </div>
			
			<div class="dep_01 step3">
                <p class="lpl_title">
                    <span class="lpl_ico">3.</span>
                    <span class="lpl_txt"><spring:message code='srv.que.p03'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">3.1</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p03.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-1" id="3-1-1" value="1">
                                <label for="3-1-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-1" id="3-1-2" value="2">
                                <label for="3-1-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-1" id="3-1-3" value="3">
                                <label for="3-1-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-1" id="3-1-4" value="4">
                                <label for="3-1-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-1" id="3-1-5" value="5">
                                <label for="3-1-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">3.2</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p03.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-1" value="1">
                                <label for="3-2-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-2" value="2">
                                <label for="3-2-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-3" value="3">
                                <label for="3-2-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-4" value="4">
                                <label for="3-2-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-2" id="3-2-5" value="5">
                                <label for="3-2-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">3.3</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p03.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-3" id="3-3-1" value="1">
                                <label for="3-3-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-3" id="3-3-2" value="2">
                                <label for="3-3-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-3" id="3-3-3" value="3">
                                <label for="3-3-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-3" id="3-3-4" value="4">
                                <label for="3-3-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-3" id="3-3-5" value="5">
                                <label for="3-3-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">3.4</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p02.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-4" id="3-4-1" value="1">
                                <label for="3-4-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-4" id="3-4-2" value="2">
                                <label for="3-4-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-4" id="3-4-3" value="3">
                                <label for="3-4-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-4" id="3-4-4" value="4">
                                <label for="3-4-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="3-4" id="3-4-5" value="5">
                                <label for="3-4-5">⑤ <spring:message code='srv.opt.0012'/></label>
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
                    <span class="lpl_txt"><spring:message code='srv.que.p04'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">4.1</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p04.q01'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.ofc.p04.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-1" value="1">
                                <label for="4-2-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-2" id="4-2-2" value="2">
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
                        <span class="lpl_txt"><spring:message code='srv.ofc.p04.q03'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.ofc.p04.q04'/></span>
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
                    <p class="lpl_question">
                        <span class="lpl_ico">4.5</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p04.q05'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.ofc.p04.q06'/></span>
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
                    <span class="lpl_txt"><spring:message code='srv.que.p05'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">5.1</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p05.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-1" id="5-1-1" value="1">
                                <label for="5-1-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-1" id="5-1-2" value="2">
                                <label for="5-1-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-1" id="5-1-3" value="3">
                                <label for="5-1-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-1" id="5-1-4" value="4">
                                <label for="5-1-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-1" id="5-1-5" value="5">
                                <label for="5-1-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.2</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p05.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-2" id="5-2-1" value="1">
                                <label for="5-2-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-2" id="5-2-2" value="2">
                                <label for="5-2-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-2" id="5-2-3" value="3">
                                <label for="5-2-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-2" id="5-2-4" value="4">
                                <label for="5-2-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-2" id="5-2-5" value="5">
                                <label for="5-2-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.2</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p05.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-3" id="5-3-1" value="1">
                                <label for="5-3-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-3" id="5-3-2" value="2">
                                <label for="5-3-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-3" id="5-3-3" value="3">
                                <label for="5-3-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-3" id="5-3-4" value="4">
                                <label for="5-3-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-3" id="5-3-5" value="5">
                                <label for="5-3-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.4</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p05.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-4" id="5-4-1" value="1">
                                <label for="5-4-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-4" id="5-4-2" value="2">
                                <label for="5-4-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-4" id="5-4-3" value="3">
                                <label for="5-4-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-4" id="5-4-4" value="4">
                                <label for="5-4-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-4" id="5-4-5" value="5">
                                <label for="5-4-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.5</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p05.q05'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-5" id="5-5-1" value="1">
                                <label for="5-5-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-5" id="5-5-2" value="2">
                                <label for="5-5-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-5" id="5-5-3" value="3">
                                <label for="5-5-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-5" id="5-5-4" value="4">
                                <label for="5-5-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-5" id="5-5-5" value="5">
                                <label for="5-5-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.6</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p05.q06'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-6" id="5-6-1" value="1">
                                <label for="5-6-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-6" id="5-6-2" value="2">
                                <label for="5-6-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-6" id="5-6-3" value="3">
                                <label for="5-6-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-6" id="5-6-4" value="4">
                                <label for="5-6-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-6" id="5-6-5" value="5">
                                <label for="5-6-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.7</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p05.q07'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-7" id="5-7-1" value="1">
                                <label for="5-7-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-7" id="5-7-2" value="2">
                                <label for="5-7-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-7" id="5-7-3" value="3">
                                <label for="5-7-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-7" id="5-7-4" value="4">
                                <label for="5-7-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-7" id="5-7-5" value="5">
                                <label for="5-7-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.8</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p05.q08'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-8" id="5-8-1" value="1">
                                <label for="5-8-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-8" id="5-8-2" value="2">
                                <label for="5-8-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-8" id="5-8-3" value="3">
                                <label for="5-8-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-8" id="5-8-4" value="4">
                                <label for="5-8-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-8" id="5-8-5" value="5">
                                <label for="5-8-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">5.9</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p05.q08'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-9" id="5-9-1" value="1">
                                <label for="5-9-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-9" id="5-9-2" value="2">
                                <label for="5-9-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-9" id="5-9-3" value="3">
                                <label for="5-9-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-9" id="5-9-4" value="4">
                                <label for="5-9-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="5-9" id="5-9-5" value="5">
                                <label for="5-9-5">⑤ <spring:message code='srv.opt.0012'/></label>
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
                    <span class="lpl_txt"><spring:message code='srv.que.p06'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">6.1</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p06.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-1" id="6-1-1" value="1">
                                <label for="6-1-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-1" id="6-1-2" value="2">
                                <label for="6-1-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-1" id="6-1-3" value="3">
                                <label for="6-1-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-1" id="6-1-4" value="4">
                                <label for="6-1-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-1" id="6-1-5" value="5">
                                <label for="6-1-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">6.2</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p06.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-2" id="6-2-1"  value="1">
                                <label for="6-2-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-2" id="6-2-2"  value="2">
                                <label for="6-2-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-2" id="6-2-3" value="3">
                                <label for="6-2-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-2" id="6-2-4" value="4">
                                <label for="6-2-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-2" id="6-2-5" value="5">
                                <label for="6-2-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">6.3</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p06.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-3" id="6-3-1" value="1">
                                <label for="6-3-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-3" id="6-3-2" value="2">
                                <label for="6-3-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-3" id="6-3-3" value="3">
                                <label for="6-3-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-3" id="6-3-4" value="4">
                                <label for="6-3-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-3" id="6-3-5" value="5">
                                <label for="6-3-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">6.4</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p06.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-4" id="6-4-1" value="1">
                                <label for="6-4-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-4" id="6-4-2" value="2">
                                <label for="6-4-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-4" id="6-4-3" value="3">
                                <label for="6-4-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-4" id="6-4-4" value="4">
                                <label for="6-4-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-4" id="6-4-5" value="5">
                                <label for="6-4-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">6.5</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p06.q05'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-5" id="6-5-1" value="1">
                                <label for="6-5-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-5" id="6-5-2" value="2">
                                <label for="6-5-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-5" id="6-5-3" value="3">
                                <label for="6-5-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-5" id="6-5-4" value="4">
                                <label for="6-5-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-5" id="6-5-5" value="5">
                                <label for="6-5-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
					<div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step6','step7')">
			                <span><spring:message code='cmm.btn.003'/></span>
			            </span>
        			</div>
                </div>
            </div>
			
			<div class="dep_01 step7">
                <p class="lpl_title">
                    <span class="lpl_ico">7.</span>
                    <span class="lpl_txt"><spring:message code='srv.que.p07'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">7.1</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p07.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-1" id="7-1-1" value="1">
                                <label for="7-1-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-1" id="7-1-2" value="2">
                                <label for="7-1-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-1" id="7-1-3" value="3">
                                <label for="7-1-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-1" id="7-1-4" value="4">
                                <label for="7-1-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-1" id="7-1-5" value="5">
                                <label for="7-1-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">7.2</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p07.q02'/></span>
                    </p>
                    <div class="dep_03">
						<input type="hidden" name="7-2" id="7-2" value="0"/>
						<textarea name="7-2text" id="7-2text" class="lpl_textarea" cols="30" rows="5"></textarea>
					</div>
                    <p class="lpl_question">
                        <span class="lpl_ico">7.3</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p07.q03'/></span>
                    </p>
                    <div class="dep_03">
						<input type="hidden" name="7-3" id="7-3" value="0"/>
						<textarea name="7-3text" id="7-3text" class="lpl_textarea" cols="30" rows="5"></textarea>
					</div>
                    <p class="lpl_question">
                        <span class="lpl_ico">7.4</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p07.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-4" id="7-4-1" value="1">
                                <label for="7-4-1">① <spring:message code='srv.opt.0013'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-4" id="7-4-2" value="2">
                                <label for="7-4-2">② <spring:message code='srv.opt.0014'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-4" id="7-4-3" value="3">
                                <label for="7-4-3">③ <spring:message code='srv.opt.0015'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-4" id="7-4-4" value="4">
                                <label for="7-4-4">④ <spring:message code='srv.opt.0016'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-4" id="7-4-5" value="5">
                                <label for="7-4-5">⑤ <spring:message code='srv.opt.0017'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-4" id="7-4-6" value="6" data-etc="etc">
                                <label for="7-4-6">⑥ <spring:message code='srv.opt.0007'/>( <input type="text" name="7-4text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">7.5</span>
                        <span class="lpl_txt"><spring:message code='srv.ofc.p07.q05'/></span>
                    </p>
                    <div class="dep_03">
                    	<input type="hidden" name="7-5" id="7-5" value="0"/>
						<textarea name="7-5text" id="7-5text" class="lpl_textarea" cols="30" rows="5"></textarea>
					</div>
                </div>
                <div class="btn_area">
		            <span class="btn btn-primary" ng-click="nextStep('step7','submit')">
		                <span><spring:message code='cmm.btn.004'/></span>
		            </span>
        		</div>
            </div>
        </form:form>    
        </div>
    </div>