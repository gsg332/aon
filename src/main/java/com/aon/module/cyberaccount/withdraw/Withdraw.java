package com.aon.module.cyberaccount.withdraw;

import java.util.Date;

import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class Withdraw extends BaseObject {

	private static final long serialVersionUID = 2152881772309105283L;

	/**
	 * 출금요청포인트
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long requestPoint;
	/**
	 * 처리상태코드
	 */
	@JsonView(BaseJsonView.Summary.class)
	private int status;
	/**
	 * 페이팔계정(이메일)
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String paypalAccount;
	/**
	 * 승인포인트
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long confirmPoint;
	/**
	 * 승인금액
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Float amount;
	/**
	 * 수수료
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Float fee;
	/**
	 * 승인은행코드
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String confirmBankCode;
	/**
	 * 승인계좌번호
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String confirmAccountNumber;
	/**
	 * 승인계좌명
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String confirmAccountName;
	/**
	 * 승인일
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Date confirmDate;
	/**
	 * 관리자노트
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String adminComment;
	/**
	 * 입력일시
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Date insertDate;
	/**
	 * 수정일시
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Date updateDate;
	/**
	 * 인증일련번호
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long certifyId;
	/**
	 * 은행계좌일련번호
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long bankAccId;
	/**
	 * 관리자일련번호
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long adminId;
	/**
	 * 가상계좌일련번호
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long cyberAccId;

	/**
	 * @return the requestPoint
	 */
	public Long getRequestPoint() {
		return requestPoint;
	}

	/**
	 * @param requestPoint
	 *            the requestPoint to set
	 */
	public void setRequestPoint(Long requestPoint) {
		this.requestPoint = requestPoint;
	}

	/**
	 * @return the status
	 */
	public int getStatus() {
		return status;
	}

	/**
	 * @param status
	 *            the status to set
	 */
	public void setStatus(int status) {
		this.status = status;
	}

	/**
	 * @return the paypalAccount
	 */
	public String getPaypalAccount() {
		return paypalAccount;
	}

	/**
	 * @param paypalAccount
	 *            the paypalAccount to set
	 */
	public void setPaypalAccount(String paypalAccount) {
		this.paypalAccount = paypalAccount;
	}

	/**
	 * @return the confirmPoint
	 */
	public Long getConfirmPoint() {
		return confirmPoint;
	}

	/**
	 * @param confirmPoint
	 *            the confirmPoint to set
	 */
	public void setConfirmPoint(Long confirmPoint) {
		this.confirmPoint = confirmPoint;
	}

	/**
	 * @return the amount
	 */
	public Float getAmount() {
		return amount;
	}

	/**
	 * @param amount
	 *            the amount to set
	 */
	public void setAmount(Float amount) {
		this.amount = amount;
	}

	/**
	 * @return the fee
	 */
	public Float getFee() {
		return fee;
	}

	/**
	 * @param fee
	 *            the fee to set
	 */
	public void setFee(Float fee) {
		this.fee = fee;
	}

	/**
	 * @return the confirmBankCode
	 */
	public String getConfirmBankCode() {
		return confirmBankCode;
	}

	/**
	 * @param confirmBankCode
	 *            the confirmBankCode to set
	 */
	public void setConfirmBankCode(String confirmBankCode) {
		this.confirmBankCode = confirmBankCode;
	}

	/**
	 * @return the confirmAccountNumber
	 */
	public String getConfirmAccountNumber() {
		return confirmAccountNumber;
	}

	/**
	 * @param confirmAccountNumber
	 *            the confirmAccountNumber to set
	 */
	public void setConfirmAccountNumber(String confirmAccountNumber) {
		this.confirmAccountNumber = confirmAccountNumber;
	}

	/**
	 * @return the confirmAccountName
	 */
	public String getConfirmAccountName() {
		return confirmAccountName;
	}

	/**
	 * @param confirmAccountName
	 *            the confirmAccountName to set
	 */
	public void setConfirmAccountName(String confirmAccountName) {
		this.confirmAccountName = confirmAccountName;
	}

	/**
	 * @return the confirmDate
	 */
	public Date getConfirmDate() {
		return confirmDate;
	}

	/**
	 * @param confirmDate
	 *            the confirmDate to set
	 */
	public void setConfirmDate(Date confirmDate) {
		this.confirmDate = confirmDate;
	}

	/**
	 * @return the adminComment
	 */
	public String getAdminComment() {
		return adminComment;
	}

	/**
	 * @param adminComment
	 *            the adminComment to set
	 */
	public void setAdminComment(String adminComment) {
		this.adminComment = adminComment;
	}

	/**
	 * @return the insertDate
	 */
	public Date getInsertDate() {
		return insertDate;
	}

	/**
	 * @param insertDate
	 *            the insertDate to set
	 */
	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}

	/**
	 * @return the updateDate
	 */
	public Date getUpdateDate() {
		return updateDate;
	}

	/**
	 * @param updateDate
	 *            the updateDate to set
	 */
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	/**
	 * @return the certifyId
	 */
	public Long getCertifyId() {
		return certifyId;
	}

	/**
	 * @param certifyId
	 *            the certifyId to set
	 */
	public void setCertifyId(Long certifyId) {
		this.certifyId = certifyId;
	}

	/**
	 * @return the bankAccId
	 */
	public Long getBankAccId() {
		return bankAccId;
	}

	/**
	 * @param bankAccId
	 *            the bankAccId to set
	 */
	public void setBankAccId(Long bankAccId) {
		this.bankAccId = bankAccId;
	}

	/**
	 * @return the adminId
	 */
	public Long getAdminId() {
		return adminId;
	}

	/**
	 * @param adminId
	 *            the adminId to set
	 */
	public void setAdminId(Long adminId) {
		this.adminId = adminId;
	}

	/**
	 * @return the cyberAccId
	 */
	public Long getCyberAccId() {
		return cyberAccId;
	}

	/**
	 * @param cyberAccId
	 *            the cyberAccId to set
	 */
	public void setCyberAccId(Long cyberAccId) {
		this.cyberAccId = cyberAccId;
	}

}
