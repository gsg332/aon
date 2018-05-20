package com.aon.sys.category;

import com.aon.lib.event.Event;

@SuppressWarnings("serial")
public class CategoryEvent {

	public static class Create extends Event {

		public Create(Object source) {
			super(source);
		}
	}

	public static class Delete extends Event {

		public Delete(Object source) {
			super(source);
		}
	}
	
	public static class Update extends Event {

		public Update(Object source) {
			super(source);
		}
	}
	
	public static class Move extends Event {
		
		public Move(Object source) {
			super(source);
		}
	}
}
