package com.aon.lib.cache;

/**
 * cache의 변경사항을 통보받는다.
 */
public interface ICacheListener
{
	public void entrySet(Object key, Object value);

	/**
	 * CASH 를 DB로 부터 재로딩 할때 사용한다.
	 * @param key : 재 로딩할 CASH 정보를 받아온다
	 */
	public void refresh(String key);

}
