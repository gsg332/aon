package com.aon.module.cyberaccount.deposit;

import java.util.Date;

import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class Deposit extends BaseObject {

	private static final long serialVersionUID = -7917364885911695917L;

	/**
	 * 페이팔 결제대기
	 */
	public static final int PAY_WAIT_STATUS = 1000;
	/**
	 * 페이팔 결제성공
	 */
	public static final int PAY_SUCCESS_STATUS = 2000;
	/**
	 * 페이팔 결제실패
	 */
	public static final int PAY_FAIL_STATUS = 9999;

	/**
	 * 요청포인트
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long requestPoint;
	/**
	 * 결제성명
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String requestAccountName;
	/**
	 * 결제예정일
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Date requestDate;
	/**
	 * 처리상태코드
	 */
	@JsonView(BaseJsonView.Summary.class)
	private int status;
	/**
	 * 결제상태
	 */
	@JsonView(BaseJsonView.Summary.class)
	private int paymentStatus;
	/**
	 * 결제고유번호
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String paymentId;
	/**
	 * 결제이메일
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String payerEmail;
	/**
	 * 결제일시
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String paymentDate;
	/**
	 * 결제수수료
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Float paymentFee;
	/**
	 * 승인포인트에 대한 금액 1$ : 100point
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Float amount;
	/**
	 * 승인포인트
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long confirmPoint;
	/**
	 * 승인결제성명
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String confirmAccountName;
	/**
	 * 승인결제일
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Date confirmDate;
	/**
	 * 관리자노트
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String adminComment;
	/**
	 * 등록일시
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Date insertDate;
	/**
	 * 수정일시
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Date updateDate;
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
	 * @return the requestAccountName
	 */
	public String getRequestAccountName() {
		return requestAccountName;
	}

	/**
	 * @param requestAccountName
	 *            the requestAccountName to set
	 */
	public void setRequestAccountName(String requestAccountName) {
		this.requestAccountName = requestAccountName;
	}

	/**
	 * @return the requestDate
	 */
	public Date getRequestDate() {
		return requestDate;
	}

	/**
	 * @param requestDate
	 *            the requestDate to set
	 */
	public void setRequestDate(Date requestDate) {
		this.requestDate = requestDate;
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
	 * @return the paymentStatus
	 */
	public int getPaymentStatus() {
		return paymentStatus;
	}

	/**
	 * @param paymentStatus
	 *            the paymentStatus to set
	 */
	public void setPaymentStatus(int paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	/**
	 * @return the paymentId
	 */
	public String getPaymentId() {
		return paymentId;
	}

	/**
	 * @param paymentId
	 *            the paymentId to set
	 */
	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}

	/**
	 * @return the payerEmail
	 */
	public String getPayerEmail() {
		return payerEmail;
	}

	/**
	 * @param payerEmail
	 *            the payerEmail to set
	 */
	public void setPayerEmail(String payerEmail) {
		this.payerEmail = payerEmail;
	}

	/**
	 * @return the paymentDate
	 */
	public String getPaymentDate() {
		return paymentDate;
	}

	/**
	 * @param paymentDate
	 *            the paymentDate to set
	 */
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	/**
	 * @return the paymentFee
	 */
	public Float getPaymentFee() {
		return paymentFee;
	}

	/**
	 * @param paymentFee
	 *            the paymentFee to set
	 */
	public void setPaymentFee(Float paymentFee) {
		this.paymentFee = paymentFee;
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
