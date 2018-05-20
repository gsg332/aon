package com.aon.module.cyberaccount;

import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class CyberAccount extends BaseObject {

	private static final long serialVersionUID = -3185642077474686110L;

	/**
	 * 가상계좌번호 3자리 - 국가코드(ISO 3166-1 NUMERIC)\r\n8자리 - reverse(년yyyy)+reverse(월mm)+reverse(일dd)\r\n6자리 - 회원일련번호 뒷
	 * 6자리(zerofill)
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String cyberAccNumber;

	/**
	 * 입금합계
	 */
	@JsonView(BaseJsonView.Summary.class)
	private long depositSum;

	/**
	 * 출금합계
	 */
	@JsonView(BaseJsonView.Summary.class)
	private long withdrawSum;

	/**
	 * 채택합계
	 */
	@JsonView(BaseJsonView.Summary.class)
	private long chooseSum;

	/**
	 * 회원일련번호
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long memberId;

	// @JsonView(BaseJsonView.Summary.class)
	// private List<Point> points;

	/**
	 * @return the cyberAccNumber
	 */
	public String getCyberAccNumber() {
		return cyberAccNumber;
	}

	/**
	 * @param cyberAccNumber
	 *            the cyberAccNumber to set
	 */
	public void setCyberAccNumber(String cyberAccNumber) {
		this.cyberAccNumber = cyberAccNumber;
	}

	/**
	 * @return the depositSum
	 */
	public Long getDepositSum() {
		return depositSum;
	}

	/**
	 * @param depositSum
	 *            the depositSum to set
	 */
	public void setDepositSum(Long depositSum) {
		this.depositSum = depositSum;
	}

	/**
	 * @return the withdrawSum
	 */
	public Long getWithdrawSum() {
		return withdrawSum;
	}

	/**
	 * @param withdrawSum
	 *            the withdrawSum to set
	 */
	public void setWithdrawSum(Long withdrawSum) {
		this.withdrawSum = withdrawSum;
	}

	/**
	 * @return the chooseSum
	 */
	public Long getChooseSum() {
		return chooseSum;
	}

	/**
	 * @param chooseSum
	 *            the chooseSum to set
	 */
	public void setChooseSum(Long chooseSum) {
		this.chooseSum = chooseSum;
	}

	/**
	 * 잔액
	 * 
	 * @return the balance
	 */
	@JsonView(BaseJsonView.Summary.class)
	public Long getBalance() {
		return depositSum + withdrawSum;
	}

	/**
	 * @return the memberId
	 */
	public Long getMemberId() {
		return memberId;
	}

	/**
	 * @param memberId
	 *            the memberId to set
	 */
	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}

	/**
	 * @return the points
	 */
	// public List<Point> getPoints() {
	// return points;
	// }

	/**
	 * @param points
	 *            the points to set
	 */
	// public void setPoints(List<Point> points) {
	// this.points = points;
	// }
}
