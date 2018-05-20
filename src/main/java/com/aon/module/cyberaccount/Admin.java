package com.aon.module.cyberaccount;

import com.aon.doc.BaseDoc;
import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

/**
 * 관리자 join 용도로 사용.
 */
@QueryEntity
public class Admin extends BaseDoc {

	private static final long serialVersionUID = -1746273301150253606L;

	@JsonView(BaseJsonView.Summary.class)
	private String loginId;

	@JsonView(BaseJsonView.Summary.class)
	private String nickname;

	@JsonView(BaseJsonView.Summary.class)
	private String firstName;

	@JsonView(BaseJsonView.Summary.class)
	private String lastName;

	@JsonView(BaseJsonView.Summary.class)
	private String email;

	/**
	 * @return the loginId
	 */
	public String getLoginId() {
		return loginId;
	}

	/**
	 * @param loginId
	 *            the loginId to set
	 */
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	/**
	 * @return the nickname
	 */
	public String getNickname() {
		return nickname;
	}

	/**
	 * @param nickname
	 *            the nickname to set
	 */
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return firstName;
	}

	/**
	 * @param firstName
	 *            the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	/**
	 * @return the lastName
	 */
	public String getLastName() {
		return lastName;
	}

	/**
	 * @param lastName
	 *            the lastName to set
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email
	 *            the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

}
