package com.aon.sys.member;

import org.springframework.context.event.EventListener;

public interface  IMemberListener {

	@EventListener
	public void create(MemberEvent.Create e) throws Exception;
	
	@EventListener
	public void delete(MemberEvent.Delete e) throws Exception;
	
	@EventListener
	public void update(MemberEvent.Update e) throws Exception;
	
	@EventListener
	public void sendMail(MemberEvent.SendMail e) throws Exception;
	
	
}
