package com.aon.module.contest.report;

import java.util.Date;

import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.aon.sys.usr.User;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class Report extends BaseObject {

	private static final long serialVersionUID = -4056152853070637642L;

	@JsonView(BaseJsonView.Summary.class)
	private Long qaId;

	@JsonView(BaseJsonView.Summary.class)
	private User reportUser;

	@JsonView(BaseJsonView.Summary.class)
	private String content;

	@JsonView(BaseJsonView.Summary.class)
	private Date insertDate;

	@JsonView(BaseJsonView.Summary.class)
	private Date confirmDate;

	@JsonView(BaseJsonView.Summary.class)
	private Boolean confirm;

	@JsonView(BaseJsonView.Summary.class)
	private User adminUser;

	@JsonView(BaseJsonView.Summary.class)
	private String adminComment;

	public Long getQaId() {
		return qaId;
	}

	public void setQaId(Long qaId) {
		this.qaId = qaId;
	}

	public User getReportUser() {
		return reportUser;
	}

	public void setReportUser(User reportUser) {
		this.reportUser = reportUser;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getInsertDate() {
		return insertDate;
	}

	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}

	public Date getConfirmDate() {
		return confirmDate;
	}

	public void setConfirmDate(Date confirmDate) {
		this.confirmDate = confirmDate;
	}

	public Boolean getConfirm() {
		return confirm;
	}

	public void setConfirm(Boolean confirm) {
		this.confirm = confirm;
	}

	public User getAdminUser() {
		return adminUser;
	}

	public void setAdminUser(User adminUser) {
		this.adminUser = adminUser;
	}

	public String getAdminComment() {
		return adminComment;
	}

	public void setAdminComment(String adminComment) {
		this.adminComment = adminComment;
	}

}