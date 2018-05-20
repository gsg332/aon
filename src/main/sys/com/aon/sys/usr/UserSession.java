package com.aon.sys.usr;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * login한 사용자에 대한 정보를 가지고 있다.
 */
public class UserSession implements Serializable {
	private static final long serialVersionUID = -5835398069991161814L;

	private static final String ADMIN = "admin";

	private User _user;
	private Map<String, Object> _attr;

	public UserSession() {
		_attr = new HashMap<String, Object>();
	}

	/**
	 * 사용자 정보를 돌려준다.
	 * 
	 * @return 사용자 정보(User class)
	 */
	public User getUser() {
		return _user;
	}

	public void setUser(User user) {
		_user = user;
	}

	/**
	 * 기타 세션 정보를 관리하는 맵을 돌려준다.
	 */
	public Map<String, Object> getAttributes() {
		return _attr;
	}

	public void setAttributes(Map<String, Object> attr) {
		_attr = attr;
	}

	/**
	 * user session의 속성을 돌려준다.
	 */
	public Object getAttribute(String key) {
		return _attr.get(key);
	}

	public void setAttribute(String key, Object value) {
		_attr.put(key, value);
	}

	/**
	 * user session의 속성을 boolean 값으로 돌려준다.
	 */
	public boolean isAttribute(String key) {
		Boolean value = (Boolean) getAttribute(key);
		return (value == null) ? false : value.booleanValue();
	}

	public void setAttribute(String key, boolean value) {
		_attr.put(key, new Boolean(value));
	}

	/**
	 * 관리자인지의 여부를 돌려준다.
	 */
	public boolean isAdmin() {
		return isAttribute(ADMIN);
	}

	public void setAdmin(boolean value) {
		setAttribute(ADMIN, value);
	}

}
