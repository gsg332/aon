package com.aon.module.paypal;

/**
 * 페이팔 결제에 필요한 설정.
 *
 */
public class PaypalSpring {

	/**
	 * 결제요청 및 결제정보 확인에 사용하는 URL
	 */
	private static String paymentUrl;
	/**
	 * 판매자의 페이팔 계정
	 */
	private static String businessEmail;
	/**
	 * 판매자 정보를 등록하면 페이팔에서 발급하는 토큰 값
	 */
	private static String businessToken;

	/**
	 * @return the paymentUrl
	 */
	public static String getPaymentUrl() {
		return paymentUrl;
	}

	/**
	 * @param paymentUrl
	 *            the paymentUrl to set
	 */
	public void setPaymentUrl(String paymentUrl) {
		PaypalSpring.paymentUrl = paymentUrl;
	}

	/**
	 * @return the businessEmail
	 */
	public static String getBusinessEmail() {
		return businessEmail;
	}

	/**
	 * @param businessEmail
	 *            the businessEmail to set
	 */
	public void setBusinessEmail(String businessEmail) {
		PaypalSpring.businessEmail = businessEmail;
	}

	/**
	 * @return the businessToken
	 */
	public static String getBusinessToken() {
		return businessToken;
	}

	/**
	 * @param businessToken
	 *            the businessToken to set
	 */
	public void setBusinessToken(String businessToken) {
		PaypalSpring.businessToken = businessToken;
	}
}
