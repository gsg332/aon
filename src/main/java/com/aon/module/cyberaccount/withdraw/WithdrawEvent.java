package com.aon.module.cyberaccount.withdraw;

import com.aon.lib.event.Event;

@SuppressWarnings("serial")
public class WithdrawEvent {

	/**
	 * 출금신청 승인 event
	 */
	public static class Confirm extends Event {
		public Confirm(Object source) {
			super(source);
		}
	}

}
