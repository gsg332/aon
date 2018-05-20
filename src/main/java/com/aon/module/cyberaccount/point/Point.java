package com.aon.module.cyberaccount.point;

import java.util.Date;

import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class Point extends BaseObject {

	private static final long serialVersionUID = -3052040845552461557L;

	/**
	 * 포상 : 답변 채택 시 답변자가 받는 포인트
	 */
	public static final int CHOSE_TYPE = 1000;

	/**
	 * 질문취소 : 질문 취소 시 등록자가 돌려 받는 포인트
	 */
	public static final int CANCLEED_TYPE = 1010;

	/**
	 * 입금결제 : 포인트 결제 시 신청자가 받는 포인트
	 */
	public static final int DEPOSITED_TYPE = 1020;
	
	/**
	 * 회수 : 답변 채택완료 후, 질문자가 회수할 남은 포인트
	 */
	public static final int CHOOSED_PAYBACK_TYPE = 1030;

	/**
	 * 관리자 입금 : 관리자가 부여하는 포인트
	 */
	public static final int ADMIN_DEPOSITED_TYPE = 1090;

	/**
	 * 지급 : 질문 등록 시 등록자에게 차감 되는 포인트
	 */
	public static final int REGISTERED_TYPE = -1000;

	/**
	 * 출금신청 : 출금신청 시 신청자에게 차감되는 포인트
	 */
	public static final int WITHDREW_TYPE = -1020;

	/**
	 * 관리자 출금 : 관리자가 차감하는 포인트
	 */
	public static final int ADMIN_WITHDREW_TYPE = -1090;

	/**
	 * 포인트 유형코드
	 */
	@JsonView(BaseJsonView.Summary.class)
	private int type;
	/**
	 * 포인트 유형코드 Text
	 */
	@JsonView(BaseJsonView.Summary.class)
	private String typeMessage;
	/**
	 * 포인트 발생출처 일련번호
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long sourceId;
	/**
	 * 포인트
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long point;
	/**
	 * 잔액
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long balance;
	/**
	 * 입력일시
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Date insertDate;
	/**
	 * 가상계좌일련번호
	 */
	@JsonView(BaseJsonView.Summary.class)
	private Long cyberAccId;

	/**
	 * @return the type
	 */
	public int getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(int type) {
		this.type = type;
	}	

	/**
	 * @return the sourceId
	 */
	public Long getSourceId() {
		return sourceId;
	}

	/**
	 * @param sourceId
	 *            the sourceId to set
	 */
	public void setSourceId(Long sourceId) {
		this.sourceId = sourceId;
	}

	/**
	 * @return the point
	 */
	public Long getPoint() {
		return point;
	}

	/**
	 * @param point
	 *            the point to set
	 */
	public void setPoint(Long point) {
		this.point = point;
	}

	/**
	 * @return the balance
	 */
	public Long getBalance() {
		return balance;
	}

	/**
	 * @param balance
	 *            the balance to set
	 */
	public void setBalance(Long balance) {
		this.balance = balance;
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
