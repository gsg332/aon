package com.aon.sys.usr;

import java.io.Serializable;

import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class User implements Serializable {

	public static final String ROLE_USER = "ROLE_USER";
	public static final String ROLE_ADMIN = "ROLE_ADMIN";
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8225479693272931974L;
	@JsonView(BaseJsonView.Summary.class)
	private Long memberId;

	@JsonView(BaseJsonView.Summary.class)
	private String displayName;

	public User() {
	}

	public User(Long id, String displayName) {
		this.memberId = id;
		this.displayName = displayName;
	}

	public User(User user) {
		memberId = user.getMemberId();
		displayName = user.getDisplayName();
	}

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long id) {
		this.memberId = id;
	}

	/**
	 * 화면에 표시할 상세 이름을 보여준다.
	 */
	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public boolean equals(Object obj) {
		if (memberId == null || !(this.getClass().isInstance(obj))) {
			return super.equals(obj);
		}
		return memberId.equals(((User) obj).memberId);
	}

	public int hashCode() {
		if (memberId == null) {
			return super.hashCode();
		}
		return memberId.hashCode();
	}

}
