package com.aon.sys.certify.sms;

/**
 * 문자인증 과정에서 발생하는 Exception
 */
public class SmsCertifyException extends Exception {

	private static final long serialVersionUID = 7782327906911090329L;

	/**
	 * 인증번호 유효시간 만료
	 */
	@SuppressWarnings("serial")
	public static class InvalidTimeException extends SmsCertifyException {
	}

	/**
	 * 인증번호 오류
	 */
	@SuppressWarnings("serial")
	public static class InvalidNumberException extends SmsCertifyException {
	}
	
	/**
	 * 필수 parameter 오류
	 */
	@SuppressWarnings("serial")
	public static class InvalidParameterException extends SmsCertifyException {
	}

}
