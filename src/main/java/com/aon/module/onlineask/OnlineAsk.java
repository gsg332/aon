package com.aon.module.onlineask;

import com.aon.doc.BaseDoc;
import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class OnlineAsk extends BaseDoc {

	private static final long serialVersionUID = 4578562905211826913L;

	protected static final int STATUS_WAIT = 1000;
	protected static final int STATUS_COMPLETE = 2000;

	/**
	 * 사용자 이름
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String userName;

	/**
	 * 로그인 아이디
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String loginid;

	/**
	 * 이메일
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String email;

	/**
	 * 코멘트
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String adminComment;

	/**
	 * 관리자 id
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long adminId;

	/**
	 * 관리자 이름 화면에 표시만 처리 한다.
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String adminNickname;

	/**
	 * 상태값 Json에 표시하기 위한 재 선언
	 */
	@JsonView(BaseJsonView.Detail.class)
	private int status;
	
	public int getStatus(){
		return this.status;
	}

	public void setStatus(int status){
		this.status = status;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getLoginid() {
		return loginid;
	}

	public void setLoginid(String loginid) {
		this.loginid = loginid;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAdminComment() {
		return adminComment;
	}

	public void setAdminComment(String adminComment) {
		this.adminComment = adminComment;
	}

	public Long getAdminId() {
		return adminId;
	}

	public void setAdminId(Long adminId) {
		this.adminId = adminId;
	}

	public String getAdminNickname() {
		return adminNickname;
	}

	public void setAdminNickname(String adminNickname) {
		this.adminNickname = adminNickname;
	}
}
