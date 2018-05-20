package com.aon.sys.member.confirm;

import com.aon.doc.BaseDoc;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class Confirm extends BaseDoc {

	private static final long serialVersionUID = 2691390018654607320L;

	private String loginId;
	private String confirmCode;

	public String getConfirmCode() {
		return confirmCode;
	}

	public void setConfirmCode(String confirmCode) {
		this.confirmCode = confirmCode;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
}