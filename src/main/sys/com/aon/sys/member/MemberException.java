package com.aon.sys.member;

/**
 * 가상계좌 Exception
 *
 */
public class MemberException extends Exception {

	private static final long serialVersionUID = 4528919750027923786L;

	/**
	 * 이전 패스워드 입력 오류
	 */
	@SuppressWarnings("serial")
	public static class BeforePasswordException extends MemberException {
	}
	
	@SuppressWarnings("serial")
	public static class MemberDropScheduleException extends MemberException {
	}
	
}
