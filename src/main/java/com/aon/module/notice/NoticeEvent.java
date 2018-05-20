package com.aon.module.notice;

import com.aon.lib.event.Event;

@SuppressWarnings("serial")
public class NoticeEvent {

	public static class Create extends Event{

		public Create(Object source) {
			super(source);
		}
	}
	
	public static class Delete extends Event{

		public Delete(Object source) {
			super(source);
		}
	}
}
