package com.aon.sys.certify.sms;

import java.util.Date;

import com.aon.doc.BaseJsonView;
import com.aon.doc.BaseObject;
import com.fasterxml.jackson.annotation.JsonView;
import com.querydsl.core.annotations.QueryEntity;

@QueryEntity
public class SmsCertify extends BaseObject {
	
	private static final long serialVersionUID = 1001196817461066715L;
	
	/**
	 * TODO : config
	 * 
	 * 인증번호 생성 자릿수
	 */
	public static final int CERTIFY_NUMBER_LENGTH = 6;
	
	/**
	 * TODO : config
	 * 
	 * 인증번호 유효시간
	 */
	public static final int CERTIFY_EXPIRED_MINUTE = 3;
	
	/**
	 * 인증대기.
	 */
	public static final int WAITED = 0;
	
	/**
	 * 인증성공
	 */
	public static final int SUCCESS = 2000;
	
	private String cellPhoneCountryCode;
	private String cellPhoneNumber;
	private String certifyNumber;
	@JsonView(BaseJsonView.Summary.class)
	private int resultCode;
	private Date insertDate;
	private Long memberId;

	/**
	 * @return the cellPhoneCountryCode
	 */
	public String getCellPhoneCountryCode() {
		return cellPhoneCountryCode;
	}

	/**
	 * @param cellPhoneCountryCode
	 *            the cellPhoneCountryCode to set
	 */
	public void setCellPhoneCountryCode(String cellPhoneCountryCode) {
		this.cellPhoneCountryCode = cellPhoneCountryCode;
	}

	/**
	 * @return the cellPhoneNumber
	 */
	public String getCellPhoneNumber() {
		return cellPhoneNumber;
	}

	/**
	 * @param cellPhoneNumber
	 *            the cellPhoneNumber to set
	 */
	public void setCellPhoneNumber(String cellPhoneNumber) {
		this.cellPhoneNumber = cellPhoneNumber;
	}

	/**
	 * @return the certifyNumber
	 */
	public String getCertifyNumber() {
		return certifyNumber;
	}

	/**
	 * @param certifyNumber
	 *            the certifyNumber to set
	 */
	public void setCertifyNumber(String certifyNumber) {
		this.certifyNumber = certifyNumber;
	}

	/**
	 * @return the resultCode
	 */
	public int getResultCode() {
		return resultCode;
	}

	/**
	 * @param resultCode
	 *            the resultCode to set
	 */
	public void setResultCode(int resultCode) {
		this.resultCode = resultCode;
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
}
