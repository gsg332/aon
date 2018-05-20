package com.aon.sys.category;

public class CategoryException extends Exception {

	private static final long serialVersionUID = 1510092830583797245L;

	/**
	 * 분류 삭제 오류
	 */
	@SuppressWarnings("serial")
	public static class DenyRemoveException extends CategoryException {
		
	}
}
