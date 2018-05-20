package com.aon.lib.http;

import javax.persistence.EntityManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import com.aon.lib.event.EventPublisher;
import com.aon.lib.jpa.ClassMetaData;
import com.aon.lib.jpa.EntityManagerService;

@Component 
public class Startup implements ApplicationListener<ContextRefreshedEvent> {

	@Autowired
	private EntityManager em ;
	
    @Autowired
	private EventPublisher ep;

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		try {
			ClassMetaData.init(em);
			EntityManagerService.init(em);
			ep.broadcast(new StartEvent(this));
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(-1);
			
		}
	}
	
}
