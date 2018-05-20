package com.aon.lib.event;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.ApplicationEventPublisherAware;
import org.springframework.stereotype.Component;

@Component
public class EventPublisher implements  ApplicationEventPublisherAware{
	private  ApplicationEventPublisher publisher;
    
    public void broadcast(Event event) {
        this.publisher.publishEvent(event); 
    }

	@Override
	public void setApplicationEventPublisher(ApplicationEventPublisher applicationEventPublisher) {
		this.publisher = applicationEventPublisher;
		
	}
}
