package com.aon.module.doc;

import org.springframework.context.event.EventListener;

public interface  IDocItemListener {

	@EventListener
	public void create(DocItemEvent.Create e) throws Exception;
	
	@EventListener
	public void delete(DocItemEvent.Delete e) throws Exception;
	
}
