package com.aon.sys.member;

import com.aon.lib.event.Event;

@SuppressWarnings("serial")
public class MemberEvent {

	public static class Create extends Event {

		public Create(Object source) throws Exception {
			super(source);
		}
	}

	public static class Delete extends Event {

		public Delete(Object source) throws Exception {
			super(source);

		}
	}

	public static class Update extends Event{

		public Update(Object source) throws Exception {
			super(source);

		}
	}
	
	public static class SendMail extends Event {

		public SendMail(Object source) throws Exception {
			super(source);

		}
	}
	
}
