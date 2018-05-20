package com.aon.sys.login;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.aon.lib.event.EventPublisher;
import com.aon.lib.util.NetworkUtil;
import com.aon.sys.member.IMemberRepository;
import com.aon.sys.member.Member;
import com.aon.sys.usr.UserSecurity;

@Component("loginSuccessHandler")
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	private static final Logger LOGGER = LoggerFactory.getLogger(LoginSuccessHandler.class);

	@Autowired
	private IMemberRepository repository;

	@Autowired
	private EventPublisher publisher;

	private String defaultUrl = "/index.aon";
	private String loginUrl = "/sys/login/login.aon";

	public LoginSuccessHandler() {
	}

	public String getDefaultUrl() {
		return defaultUrl;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth)
			throws IOException, ServletException {

		UserSecurity userSecurity = (UserSecurity) auth.getPrincipal();

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userSecurity", userSecurity);
		param.put("request", request);
		publisher.broadcast(new LoginEvent.Login(param));
		
		Member member = repository.loadWithLock(userSecurity.getCustomUser().getId());
		member.setTotalAccessCnt(member.getTotalAccessCnt() + 1);
		member.setLastAccessIp(NetworkUtil.StringToLongIp(NetworkUtil.getClientIp(request)));
		member.setLastAccessDate(new Date());

		HttpSession session = request.getSession(false);
		if (session != null) {
			session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
		}
		String targetUrl = null;
		SavedRequest savedRequest = new HttpSessionRequestCache().getRequest(request, response);
		String returnUrl = (String) request.getParameter("returnUrl");
		//jsp로 일반적인 페이지에 filter 적용시 return url일 login.aon으로 리턴 된다. 
		LOGGER.debug("savedRequest="+ savedRequest);
		if(returnUrl.contains(loginUrl) && savedRequest!=null){
			String ctx = request.getServletContext().getContextPath();
			if(ctx.length()!=0){
			 int ch = savedRequest.getRedirectUrl().lastIndexOf(ctx);
			 returnUrl = savedRequest.getRedirectUrl().substring(ch+ctx.length());
			} else {
				returnUrl = savedRequest.getRedirectUrl();
			}
			LOGGER.debug("returnUrl="+ returnUrl);
			LOGGER.debug("savedRequest.getRedirectUrl()="+ savedRequest.getRedirectUrl());
		}
		
		if (!StringUtils.isEmpty(returnUrl)) {
			targetUrl = request.getContextPath() + returnUrl;
		} else {
			targetUrl = request.getContextPath() + defaultUrl;
		}

		response.sendRedirect(targetUrl);
	}
}
