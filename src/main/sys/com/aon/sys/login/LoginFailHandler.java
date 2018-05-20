package com.aon.sys.login;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

@Component("loginFailHandler")
public class LoginFailHandler implements AuthenticationFailureHandler {

	private static final Logger LOGGER = LoggerFactory.getLogger(LoginFailHandler.class);

	private String defaultUrl = "/sys/login/loginForm.aon";

	public LoginFailHandler() {
	}

	public String getDefaultUrl() {
		return defaultUrl;
	}

	public void setDefaultUrl(String defaultUrl) {
		this.defaultUrl = defaultUrl;
	}

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		HttpSession session = request.getSession(false);
		if (session != null) {
			session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
		}

		String returnUrl = (String) request.getParameter("returnUrl");

		String targetUrl = request.getContextPath() + defaultUrl + "?fail=true";

		if (!StringUtils.isEmpty(returnUrl)) {
			targetUrl += "&returnUrl=" + URLEncoder.encode(returnUrl, "utf-8");
		}

		response.sendRedirect(targetUrl);
	}

}
