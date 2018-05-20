package com.aon.lib.jpa;

/**
 * TODO : TransactionSynchronizationAdapter 의 메소드를 상속구현하지 못하게 할것...
 * @author kskim
 *
 */
public interface  TxListener  {
	

	public abstract void commit();

	public abstract void rollback();

}
