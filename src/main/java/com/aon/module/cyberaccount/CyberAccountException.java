package com.aon.module.cyberaccount;

/**
 * 가상계좌 Exception
 *
 */
public class CyberAccountException extends Exception {

	private static final long serialVersionUID = -9016077733494237076L;

	/**
	 * TODO :  공통 Exception 처리... 
	 * 
	 * 필수 parameter 오류
	 */
	@SuppressWarnings("serial")
	public static class InvalidParameterException extends CyberAccountException {
	}
	
	/**
	 * 잔액 부족 오류
	 */
	@SuppressWarnings("serial")
	public static class NotEnoughException extends CyberAccountException {
	}
}
