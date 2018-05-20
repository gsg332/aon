package com.aon.sys.usr;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.aon.doc.PermissionDeniedException;

public class UserPermission {

	/**
	 * 관리자여부
	 *
	 * @return
	 * @throws Exception
	 */
	public boolean isAdmin() throws Exception {

		ServletRequestAttributes servletRequestAttribute = (ServletRequestAttributes) RequestContextHolder
				.currentRequestAttributes();
		HttpSession httpSession = servletRequestAttribute.getRequest().getSession(true);
		SecurityContext ctx = (SecurityContext) httpSession
				.getAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY);

		if (ctx != null) {
			Authentication auth = ctx.getAuthentication();

			UserSecurity userSession = (UserSecurity) auth.getPrincipal();

			Object[] grantedAuthList = auth.getAuthorities().toArray();

			for (int i = 0; i < grantedAuthList.length; i++) {
				GrantedAuthority grantedAuthority = (GrantedAuthority) grantedAuthList[i];
				String roleType = grantedAuthority.getAuthority();

				if (User.ROLE_ADMIN.equals(roleType) && userSession.isEnabled()) {
					return true;
				}
			}
		}

		return false;

	}

	/**
	 * 관리자가 아니면 예외처리.
	 * 
	 * @param doc
	 * @throws Exception
	 */
	public void checkAdmin() throws Exception {

		if (!isAdmin()) {
			throw new PermissionDeniedException();
		}
	}

}
