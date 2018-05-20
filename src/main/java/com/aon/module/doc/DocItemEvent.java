package com.aon.module.doc;

import com.aon.lib.event.Event;

@SuppressWarnings("serial")
public class DocItemEvent {

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
