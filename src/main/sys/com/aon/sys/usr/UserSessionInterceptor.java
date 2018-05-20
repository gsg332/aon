package com.aon.sys.usr;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * request가 요청될 때마다 Spring Security의 세션정보를 확인하여 세션이 존재하면 UserSession에 Security에 담겨 있는 세션 정보를 옮겨 저장한다.
 * Spring Security의 세션과 UserSession의 세션 두 개가 동시에 존재하여 사용되고 있음.
 */
public class UserSessionInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		UserService.setUserSession(null);
		UserSession userSession = new UserSession();
		
		HttpSession httpSession = request.getSession(true);
		SecurityContext ctx = (SecurityContext) httpSession
				.getAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY);

		User user = new User();
		userSession.setUser(user);
		
		if (ctx != null) {
			Authentication auth = ctx.getAuthentication();
			UserSecurity userSecurity = (UserSecurity) auth.getPrincipal();

			if (userSecurity != null) {
				user.setMemberId(userSecurity.getCustomUser().getId());
				user.setDisplayName(userSecurity.getCustomUser().getDisplayName());
			}
		}
		
		UserService.setUserSession(userSession);

		return super.preHandle(request, response, handler);
	}

}
