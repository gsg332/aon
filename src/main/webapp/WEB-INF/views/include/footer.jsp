<%@ include file="/WEB-INF/views/include/jstl.jsp" %>
 	<!-- footer -->
    <div class="footer">
        <div class="wrap">
        	<div class="fLeft">
				<ul class="fLink">
				    <li><a href='<c:url value="/serviceInfo/notice/index.aon#/html/aboutUs"/>'><spring:message code='cmm.menu.003'/></a></li>
					<li><a href='<c:url value="/serviceInfo/notice/index.aon#/html/serviceProcess"/>'><spring:message code='cmm.menu.004'/></a></li>
					<li><a href='<c:url value="/serviceInfo/notice/index.aon#/html/personalInfo"/>'><spring:message code='cmm.menu.006'/></a></li>
					<%-- <li><a href="#NoCollectEmail" data-toggle="modal"><spring:message code='cmm.menu.001'/></a></li> --%>
				</ul>
				<address>
				   <spring:message code='ftr.msg.001'/><br>
				    Tel. +82.2.6284.2219  /  Fax. +82.6284.2215  /  E-mail. buyinfo@buyinfo.com
				</address>
			</div>
			<div class="fRight">
				<!--<ul class="icon_sns">
				    <li><a href="#" class="sns_fb">facebook</a></li>
				    <li><a href="#" class="sns_tw">twitter</a></li>
				    <li><a href="#" class="sns_ins">instagram</a></li>
				</ul>-->
				<p class="copyright">Copyright BuyInfo All rights reserved.</p>
			</div>
        </div>
    </div>
    <!-- //footer -->
    <!-- email modal -->
    <div class="modal fade" id="NoCollectEmail" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title"><spring:message code='cmm.menu.001'/></h4>
                </div>
                <div class="modal-body">
                    <p class="modalTxt2"><spring:message code='ftr.msg.002'/></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn green" data-dismiss="modal" aria-hidden="true"><spring:message code='cmm.btn.016'/></button>
                </div>
            </div>
        </div>
    </div>
    <!-- //email modal -->
	<script src="<%=getServletContext().getContextPath() %>/resources/js/moment.js"></script>
	<script src="<%=getServletContext().getContextPath() %>/resources/js/bootstrap-datetimepicker.min.js"></script>
	<script src="<%=getServletContext().getContextPath() %>/resources/js/app.js"></script>
</body>
</html>