<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/jstl.jsp"%>
<div class="sub_section">
    <h3 class="sub_tit"><spring:message code='mem.nav.100'/></h3>
    <div class="myPageBox">
        <div class="profile01">
            <div class="myPhoto">
            	<img src="<c:url value="/sys/member/download.aon"/>" alt="profile img" style="width:150px; height:150px;" err-src>
            </div>
            <div class="myPtxt">
                <div class="myName"><span>{{member.firstName}} {{member.lastName}}</span></div>
                <div class="buttonArea">
                    <a href="<c:url value="/myPage/myPoint/index.aon#/withdraw"/>" class="btn btn-primary"><spring:message code='cmm.btn.038'/></a>
                </div>
            </div>
        </div>
        <div class="profile02">
            <ul class="myP_list">
                <li>
                    <label class="col-sm-3"><spring:message code='mem.lbl.044'/></label>
                    <div class="col-sm-9">{{member.loginId}}</div>
                </li>
                <li>
                    <label class="col-sm-3"><spring:message code='mem.lbl.008'/></label>
                    <div class="col-sm-9">{{member.nickname}}</div>
                </li>
                <li>
                    <label class="col-sm-3"><spring:message code='pnt.lbl.006'/></label>
                    <div class="col-sm-9">{{chooseCnt}}</div>
                </li>
                <li>
                    <label class="col-sm-3"><spring:message code='pnt.lbl.005'/></label>
                    <div class="col-sm-9">{{cyberAccount.balance | Apoint}} <spring:message code='cmm.lbl.014'/></div>
                </li>
                <li>
                    <label class="col-sm-3"><spring:message code='pnt.lbl.007'/></label>
                    <div class="col-sm-9">{{cyberAccount.chooseSum | Apoint}} <spring:message code='cmm.lbl.010'/></div>
                </li>
                <li>
                    <label class="col-sm-3"><spring:message code='mem.lbl.035'/></label>
                    <div class="col-sm-9">{{member.memberProfile.career}}</div>
                </li>
            </ul>
        </div>
    </div>
    <!-- 진행 중인 나의 질문 -->
    <h3 class="sub_tit mt_40"><spring:message code='cts.lbl.049'/></h3>
    <div class="info_box">
        <ul class="info_eList">
            <!-- 데이터가 없을 경우 현재 display:none 처리 -->
            <li class="data_none" ng-show="myOngoingContestList.length == 0">
                <spring:message code='cmm.msg.012'/>
            </li>
            <!-- //데이터가 없을 경우 -->
            <li ng-repeat="item in myOngoingContestList">
                <a href="<c:url value="/myPage/myQuestion/index.aon#/view/{{item[0]}}"/>">
                    <strong ng-bind-html="item[1]"></strong>
                    <p class="el_txt" ng-bind-html="item[2]" list-contest></p>
                </a>
                <ul class="info_etc info_etc_b">
					<li ng-if="item[6] != null"><span>{{item[6] | ctgrLang}}</span></li>
					<li><span>{{item[7] | ctgrLang}}</span></li>
					<li ng-if="item[8] != ''"><span>{{item[8] | ctgrLang}}</span></li>			
				</ul>
                <ul class="info_etc">
                    <li><span>{{item[4] | Apoint}}</span></li>
                    <li>
                        <i class="glyphicon glyphicon-time"></i>
                        <span class="ie_date">{{item[5] | Adate}}</span>
                    </li>
                    <li>
                    	<span class="status adopt" ng-show="item[3] == true"><spring:message code='cts.lbl.004'/></span>
                    	<span class="status noadopt" ng-show="item[3] == false"><spring:message code='cts.lbl.005'/></span>
                    </li>
                </ul>
                <ul class="info_etc info_etcR">
                    <li><spring:message code='cmm.btn.007'/> <span class="black">{{item[8] | ctgrLang}}</span></li>
                </ul>
            </li>
        </ul>
    </div>
    <!-- //진행 중인 나의 질문 -->
    <!-- 진행 중인 나의 답변 -->
    <h3 class="sub_tit mt_40"><spring:message code='cts.lbl.050'/></h3>
    <div class="info_box">
        <ul class="info_eList">
            <!-- 데이터가 없을 경우 현재 display:none 처리 -->
            <li class="data_none" ng-show="myOngoingAnswerList.length == 0">
                <spring:message code='cmm.msg.012'/>
            </li>
            <!-- //데이터가 없을 경우 -->
            <li ng-repeat="item in myOngoingAnswerList">
                <a href="<c:url value="/myPage/myAnswer/index.aon#/view/{{item[0]}}"/>">
                	<strong ng-bind-html="item[1]"></strong>
                    <p class="el_txt" ng-bind-html="item[2]" list-contest></p>
                </a>
                <ul class="info_etc info_etc_b">
					<li ng-if="item[6] != ''"><span>{{item[6] | ctgrLang}}</span></li>
					<li><span>{{item[7] | ctgrLang}}</span></li>					
				</ul>
                <ul class="info_etc">
                    <li><span>{{item[4] | Apoint}}</span></li>
                    <li>
                        <i class="glyphicon glyphicon-time"></i>
                        <span class="ie_date">{{item[5] | Adate}}</span>
                    </li>
                    <li>
                    	<span class="status adopt" ng-show="item[3] == true"><spring:message code='cts.lbl.004'/></span>
                    	<span class="status noadopt" ng-show="item[3] == false"><spring:message code='cts.lbl.005'/></span>
                    </li>
                </ul>
                <ul class="info_etc info_etcR">
                    <li><spring:message code='cmm.btn.007'/> <span class="black">{{item[8] | ctgrLang}}</span></li>
                </ul>
            </li>
        </ul>
    </div>
    <!-- //진행 중인 나의 답변 -->
</div>
