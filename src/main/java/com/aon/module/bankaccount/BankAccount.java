package com.aon.module.bankaccount;

import com.aon.doc.BaseDoc;
import com.aon.doc.BaseJsonView;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class BankAccount extends BaseDoc {

	private static final long serialVersionUID = -6288159411913145467L;

	@JsonView(BaseJsonView.Summary.class)
	private String bankCode;

	@JsonView(BaseJsonView.Summary.class)
	private String accountNumber;

	@JsonView(BaseJsonView.Summary.class)
	private String accountName;

	@JsonView(BaseJsonView.Summary.class)
	private Long memberId;

	public Long getMemberId() {
		return memberId;
	}

	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
}
