<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
<style>
body{
     margin: 0;
 }
 ul,
 li {
     padding: 0;
     margin: 0;
     list-style: none;
 }        
 p {
     margin: 0;
 }  
.left{
	text-align: left;
}
.right{
	text-align: right;
}
.center{
	text-align: center;
}
.under {
    display: block;
    margin-top: 30px;
    color: #666;
    text-decoration: underline;
}
.strong{
    font-weight: bold;
}
.lpl_title_b{
    margin-top: 30px;
    font-size: 32px;
    font-weight: bold;
    text-align: center;
}
.lpl_title {
    position: relative;
    padding-left: 0;
    font-size:16px;
    font-weight: bold;
}
.lpl_title_s{
	margin-top: 30px;
	font-size: 24px;
	font-weight: bold;
}
.lpl_question{
    position: relative;
}
.lpl_ico{
    display: inline-block;
    float: left;
    margin-right: 10px;
}
.lpl_txt{
    display: block;
    overflow: hidden;
}
.rank{
    display: inline-block;
    min-width: 50px;
}
.rank_title{
    display: inline-block;
    width: 70px;
}
.layout_poll{
    padding: 20px;
    font-size: 14px;
}
.dep_01 {
    padding-top: 50px;
    line-height: 180%;
    list-style: upper-alpha;
}        
.dep_01:first-child {
    padding-top: 0;
}

.dep_02 {
    padding: 20px 0 0 20px;
}        
.dep_03 {
    padding: 15px 0 15px 35px;
}
.bt_right .dep_03{
    padding: 0;
}
.lpl_yn li {
    float: left;
    margin-right: 30px;
}        
.lpl_yn:before,
.lpl_yn:after {
    content: '';
    display: block;
    clear: both;
}        
.basic_table_box{            
    padding-top: 10px;
}
.basic_table{
    margin-top: 10px;
    display: table;
    width: 100%;
    border: 1px solid #dedede;
}
.basic_table > li{
    border-top: 1px solid #dedede;
}
.basic_table > li:first-child{
    border-top: 0;
}
.bt_left{
    width: 100px;
    display: table-cell;
    vertical-align: middle;
    text-align: center;
    border-right: 1px solid #dedede;
}
.bt_right{
    display: table-cell;
    padding: 5px 20px;
}
.lpl_textarea{
    width: 100%;
    resize: none;
}

.checks {
    position: relative;
}        
.checks input[type="radio"] {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    border: 0;
}        
.checks input[type="radio"] + label {
    display: inline-block;
    position: relative;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
}        
.checks input[type="radio"]:checked + label {
    color: #3598dc;
}
.checks input[type="radio"]:checked + label:before{
    content: '\2714';
    position: absolute;
    top: -3px;
    left: 3px;
    z-index: 1;
}        
.checks input[type="checkbox"] {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    border: 0;
}
.checks input[type="checkbox"] + label {
  display: inline-block;
  position: relative;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
}        
.checks input[type="checkbox"]:checked + label {
    color: #3598dc;
}
.checks input[type="checkbox"]:checked + label:before{
    content: '\2714';
    position: absolute;
    top: -3px;
    left: 3px;
    z-index: 1;
}

.btn_area{
    text-align: center;
}
.btn{
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: 400;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px
}
.btn-primary {
  color: #fff;
  background-color: #337ab7;
  border-color: #2e6da4;
}
.poll_head{
    padding:5px;
    line-height: 0;
    background: #353f49;
}

.lpl_post_box{
	margin-top: 30px;
	padding: 30px;
	border: 1px solid #dedede;
}
.lpl_post_list{
	margin-bottom: 30px;
}
.lpl_post_list > li{
	margin-top: 30px;
}
.lpl_war{
	font-size: 16px;
	color: #337ab7;
}
.lpl_thank{
	margin-top: 30px;
	font-size: 18px;
	font-weight: bold;
}
</style>
	<div class="poll_box">
        <!-- Sports -->
        <div class="layout_poll">        
        <form:form name="surveyForm" id="surveyForm">
        <input type="hidden" name="surveyId" id="surveyId" value="2"/>
        <input type="hidden" name="userId" id="userId" value="1"/>
        <p class="lpl_title_b"><spring:message code='srv.pag.002'/></p>
            <div class="dep_01 step1">
                <p class="lpl_title">
                    <span class="lpl_ico">1.</span>
                    <span class="lpl_txt"><spring:message code='srv.que.p01'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">1.1</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p01.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-1" value="1">
                                <label for="1-1-1">① <spring:message code='srv.opt.0001'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="1-1" id="1-1-2" value="2">
                                <label for="1-1-2">② <spring:message code='srv.opt.0002'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">1.2</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p01.q02'/></span>
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
                    <p class="lpl_question">
                        <span class="lpl_ico">1.3</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p01.q03'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p01.q04'/></span>
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
                                <input type="radio" name="1-4" id="1-4-2" value="2">>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p01.q05'/></span>
                    </p>
                    <div class="dep_03">
                    	<input type="hidden" name="1-5" id="1-5" value="0" data-etc="etc"/>
						<textarea name="1-5text" id="1-5text" class="lpl_textarea" cols="30" rows="3"></textarea>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p02.q01'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p02.q02'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p02.q03'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p02.q04'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p02.q05'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p02.q06'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p02.q07'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p02.q08'/></span>
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
                    <p class="lpl_question">
                        <span class="lpl_ico">2.9</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p02.q09'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-9" id="2-9-1" value="1">
                                <label for="2-9-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-9" id="2-9-2" value="2">
                                <label for="2-9-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-9" id="2-9-3" value="3">
                                <label for="2-9-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-9" id="2-9-4" value="4">
                                <label for="2-9-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="2-9" id="2-9-5" value="5">
                                <label for="2-9-5">⑤ <spring:message code='srv.opt.0012'/></label>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p03.q01'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p03.q02'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p03.q03'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p03.q04'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p04.q01'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p04.q02'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p04.q03'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p04.q04'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p04.q05'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p04.q06'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p05.q01'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p05.q02'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p05.q03'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p05.q04'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p05.q05'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p05.q06'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p06.q01'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p06.q02'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p06.q03'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p06.q04'/></span>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p06.q05'/></span>
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
                    <p class="lpl_question">
                        <span class="lpl_ico">6.6</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p06.q06'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-6" id="6-6-1" value="1">
                                <label for="6-6-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-6" id="6-6-2" value="2">
                                <label for="6-6-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-6" id="6-6-3" value="3">
                                <label for="6-6-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-6" id="6-6-4" value="4">
                                <label for="6-6-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-6" id="6-6-5" value="5">
                                <label for="6-6-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">6.7</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p06.q07'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-7" id="6-7-1" value="1">
                                <label for="6-7-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-5" id="6-7-2" value="2">
                                <label for="6-7-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-5" id="6-7-3" value="3">
                                <label for="6-7-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-5" id="6-7-4" value="4">
                                <label for="6-7-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-5" id="6-7-5" value="5">
                                <label for="6-7-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">6.8</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p06.q08'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-8" id="6-8-1" value="1">
                                <label for="6-8-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-8" id="6-8-2" value="2">
                                <label for="6-8-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-8" id="6-8-3" value="3">
                                <label for="6-8-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-8" id="6-8-4" value="4">
                                <label for="6-8-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="6-8" id="6-8-5" value="5">
                                <label for="6-8-5">⑤ <spring:message code='srv.opt.0012'/></label>
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p07.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-1" id="7-1" value="1">
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
                        <span class="lpl_txt"><spring:message code='srv.reg.p07.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-2" id="7-2-1" value="1">
                                <label for="7-2-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-2" id="7-2-2" value="2">
                                <label for="7-2-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-2" id="7-2-3" value="3">
                                <label for="7-2-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-2" id="7-2-4" value="4">
                                <label for="7-2-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-2" id="7-2-5" value="5">
                                <label for="7-2-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">7.3</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p07.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-3" id="7-3-1" value="1">
                                <label for="7-3-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-3" id="7-3-2" value="2">
                                <label for="7-3-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-3" id="7-3-3" value="3">
                                <label for="7-3-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-3" id="7-3-4" value="4">
                                <label for="7-3-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-3" id="7-3-5" value="5">
                                <label for="7-3-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">7.4</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p07.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-4" id="7-4-1" value="1">
                                <label for="7-4-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-4" id="4-4-2" value="2">
                                <label for="7-4-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-4" id="7-4-3" value="3">
                                <label for="7-4-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-4" id="7-4-4" value="4">
                                <label for="7-4-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-4" id="7-4-5" value="5">
                                <label for="7-4-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">7.5</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p07.q05'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-5" id="7-5-1" value="1">
                                <label for="7-5-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-5" id="7-5-2" value="2">
                                <label for="7-5-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-5" id="7-5-3" value="3">
                                <label for="7-5-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-5" id="7-5-4" value="4">
                                <label for="7-5-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-5" id="7-5-5" value="5">
                                <label for="7-5-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">7.6</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p07.q06'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-6" id="7-6-1" value="1">
                                <label for="7-6-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-6" id="7-6-2" value="2">
                                <label for="7-6-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-6" id="7-6-3" value="3">
                                <label for="7-6-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-6" id="7-6-4" value="4">
                                <label for="7-6-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="7-6" id="7-6-5" value="5">
                                <label for="7-6-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step7','step8')">
			                <span><spring:message code='cmm.btn.003'/></span>
			            </span>
        			</div>
               </div>
            </div>
			<div class="dep_01 step8">
                <p class="lpl_title">
                    <span class="lpl_ico">8.</span>
                    <span class="lpl_txt"><spring:message code='srv.que.p08'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">8.1</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p08.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-1" id="8-1" value="1">
                                <label for="8-1-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-1" id="8-1-2" value="2">
                                <label for="8-1-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-1" id="8-1-3" value="3">
                                <label for="8-1-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-1" id="8-1-4" value="4">
                                <label for="8-1-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-1" id="8-1-5" value="5">
                                <label for="8-1-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">8.2</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p08.q02'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-2" id="8-2-1" value="1">
                                <label for="8-2-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-2" id="8-2-2" value="2">
                                <label for="8-2-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-2" id="8-2-3" value="3">
                                <label for="8-2-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-2" id="8-2-4" value="4">
                                <label for="8-2-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-2" id="8-2-5" value="5">
                                <label for="8-2-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">8.3</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p08.q03'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-3" id="8-3-1" value="1">
                                <label for="8-3-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-3" id="8-3-2" value="2">
                                <label for="8-3-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-3" id="8-3-3" value="3">
                                <label for="8-3-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-3" id="8-3-4" value="4">
                                <label for="8-3-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-3" id="8-3-5" value="5">
                                <label for="8-3-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">8.4</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p08.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-4" id="8-4-1" value="1">
                                <label for="8-4-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="4-4" id="4-4-2" value="2">
                                <label for="8-4-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-4" id="8-4-3" value="3">
                                <label for="8-4-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-4" id="8-4-4" value="4">
                                <label for="8-4-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="8-4" id="8-4-5" value="5">
                                <label for="8-4-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <div class="btn_area">
			            <span class="btn btn-primary" ng-click="nextStep('step8','step9')">
			                <span><spring:message code='cmm.btn.003'/></span>
			            </span>
        			</div>
               </div>
            </div>	
			<div class="dep_01 step9">
                <p class="lpl_title">
                    <span class="lpl_ico">9.</span>
                    <span class="lpl_txt"><spring:message code='srv.que.p09'/></span>
                </p>
                <div class="dep_02">
                    <p class="lpl_question">
                        <span class="lpl_ico">9.1</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p09.q01'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="9-1" id="9-1-1" value="1">
                                <label for="9-1-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="9-1" id="9-1-2" value="2">
                                <label for="9-1-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="9-1" id="9-1-3" value="3">
                                <label for="9-1-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="9-1" id="9-1-4" value="4">
                                <label for="9-1-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="9-1" id="9-1-5" value="5">
                                <label for="9-1-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">9.2</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p09.q02'/></span>
                    </p>
                    <div class="dep_03">
						<input type="hidden" name="9-2" id="9-2" value="0"/>
						<textarea name="9-2text" id="9-2text" class="lpl_textarea" cols="30" rows="5"></textarea>
					</div>
                    <p class="lpl_question">
                        <span class="lpl_ico">9.3</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p09.q03'/></span>
                    </p>
                    <div class="dep_03">
						<input type="hidden" name="9-3" id="9-3" value="0"/>
						<textarea name="9-3text" id="9-3text" class="lpl_textarea" cols="30" rows="5"></textarea>
					</div>
                    <p class="lpl_question">
                        <span class="lpl_ico">9.4</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p09.q04'/></span>
                    </p>
                    <ul class="dep_03 lpl_yn">
                        <li>
                            <div class="checks">
                                <input type="radio" name="9-4" id="9-4-1" value="1">
                                <label for="9-4-1">① <spring:message code='srv.opt.0008'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="9-4" id="9-4-2" value="2">
                                <label for="9-4-2">② <spring:message code='srv.opt.0009'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="9-4" id="9-4-3" value="3">
                                <label for="9-4-3">③ <spring:message code='srv.opt.0010'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="9-4" id="9-4-4" value="4">
                                <label for="9-4-4">④ <spring:message code='srv.opt.0011'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="9-4" id="9-4-5" value="5">
                                <label for="9-4-5">⑤ <spring:message code='srv.opt.0012'/></label>
                            </div>
                        </li>
                        <li>
                            <div class="checks">
                                <input type="radio" name="9-4" id="9-4-6" value="6" data-etc="etc">
                                <label for="9-4-6">⑥ <spring:message code='srv.opt.0007'/>( <input type="text" name="9-4text" id="" title="etc"> )</label>
                            </div>
                        </li>
                    </ul>
                    <p class="lpl_question">
                        <span class="lpl_ico">9.5</span>
                        <span class="lpl_txt"><spring:message code='srv.reg.p09.q05'/></span>
                    </p>
                    <div class="dep_03">
                    	<input type="hidden" name="9-5" id="9-5" value="0"/>
						<textarea name="9-5text" id="9-5text" class="lpl_textarea" cols="30" rows="5"></textarea>
					</div>
                </div>
                <div class="btn_area">
		            <span class="btn btn-primary" ng-click="nextStep('step9','submit')">
		                <span><spring:message code='cmm.btn.003'/></span>
		            </span>
        		</div>
            </div>
        </form:form>    
        </div>
    </div>