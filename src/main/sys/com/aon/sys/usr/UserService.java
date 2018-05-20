package com.aon.sys.usr;

import com.aon.sys.login.LoginService;

public abstract class UserService {
	private static ThreadLocal<UserSession> _logins = new ThreadLocal<UserSession>();
	
	/**
	 * 현재 login한 사용자 정보를 설정한다.
	 */
	public static void setUserSession(UserSession login) throws Exception {
		_logins.set(login);
	}

	/**
	 * 현재 login한 사용자 정보를 가지고 있는 Login 객체를 돌려준다.
	 */
	public static UserSession getUserSession() throws Exception {
		return _logins.get();
	}

	/**
	 * 현재 login한 사용자 정보를 변경한다.
	 */
	public static void setUser(User user) throws Exception {
		getUserSession().setUser(user);
	}

	/**
	 * 사용자의 id를 돌려준다.
	 */
	public static Long getMemberId() throws Exception{
		return getUserSession().getUser().getMemberId();
	}

	public static Integer getUserIp() throws Exception{
		Integer userIp = (Integer) getUserSession().getAttribute("userIp");
		return (userIp == null ? new Integer(0) : userIp);
	}

	/**
	 * 현재 login한 사용자 정보를 돌려준다.
	 *
	 * @return
	 */
	public static User getUser() throws Exception {
		return getUserSession().getUser();
	}

	/**
	 * user session의 속성을 돌려준다.
	 */
	public static Object getAttribute(String key) throws Exception {
		return getUserSession().getAttribute(key);
	}

	/**
	 * user session의 속성을 boolean으로 돌려준다.
	 */
	public static boolean isAttribute(String key) throws Exception {
		return getUserSession().isAttribute(key);
	}

	/**
	 * 인증이 완료된 로그인된 상태인지 여부를 돌려준다.
	 */
	public static boolean isAuthenticated() throws Exception {
		return (getUserSession() != null);
	}

}
