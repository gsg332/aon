package com.aon.lib.event;

import org.springframework.context.ApplicationEvent;

@SuppressWarnings("serial")
public abstract class Event extends ApplicationEvent {

	public Event(Object source) {
		super(source);
	}

	
}
