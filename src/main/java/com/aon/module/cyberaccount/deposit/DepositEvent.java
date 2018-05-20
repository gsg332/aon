package com.aon.module.cyberaccount.deposit;

import com.aon.lib.event.Event;

@SuppressWarnings("serial")
public class DepositEvent {
	
	/**
	 * 충전신청 승인 event
	 */
	public static class Confirm extends Event {
		public Confirm(Object source) {
			super(source);
		}
	}
	
}
