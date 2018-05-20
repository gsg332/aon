package com.aon.lib.jpa;

import org.springframework.transaction.support.TransactionSynchronizationManager;

public class TxService {

	public static void addTxListener(TxListener listener){
		TransactionSynchronizationManager.registerSynchronization(new TxAdapter(listener));
	}
}
