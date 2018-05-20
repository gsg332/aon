package com.aon.lib.jpa;

import javax.transaction.Status;

import org.springframework.transaction.support.TransactionSynchronizationAdapter;

final class TxAdapter extends TransactionSynchronizationAdapter{
	
	private TxListener listener;
	public TxAdapter(TxListener listener){
		this.listener = listener;
	}

	public void afterCompletion(int status) {

		switch (status) {
		case Status.STATUS_ACTIVE : 
		case Status.STATUS_COMMITTED:
		case Status.STATUS_COMMITTING:
			listener.commit();
			break;
		case Status.STATUS_MARKED_ROLLBACK:
		case Status.STATUS_ROLLEDBACK :
		case Status.STATUS_ROLLING_BACK:
			listener.rollback();
		}
	}
}
