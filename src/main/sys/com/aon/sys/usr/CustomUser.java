package com.aon.sys.usr;

import java.io.Serializable;
import java.util.Date;

import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;

/**
 * Session용 사용자 정보 객체
 *
 */
public class CustomUser implements Serializable {

	private static final long serialVersionUID = -448628875867356629L;

	@JsonView(BaseJsonView.Summary.class)
	private Long memberId;

	@JsonView(BaseJsonView.Summary.class)
	private Long id;
	private String loginId;
	private String type;
	private String firstName;
	private String lastName;
	private String nickname;
	private String email;
	private String cellPhoneNumber;
	private Date insertDate;

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCellPhoneNumber() {
		return cellPhoneNumber;
	}

	public void setCellPhoneNumber(String cellPhoneNumber) {
		this.cellPhoneNumber = cellPhoneNumber;
	}

	public String getFullName() {
		return lastName + " " + firstName;
	}

	public String getDisplayName() {
		return nickname;
	}

	public Date getInsertDate() {
		return insertDate;
	}

	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}

}
