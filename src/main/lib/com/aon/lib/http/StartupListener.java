package com.aon.lib.http;

import org.springframework.context.event.EventListener;

public interface StartupListener {

	@EventListener
	public void start(StartEvent e) throws Exception;
}
