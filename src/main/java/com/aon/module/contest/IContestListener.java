package com.aon.module.contest;

import org.springframework.context.event.EventListener;

public interface  IContestListener {

	@EventListener
	public void create(ContestEvent.Create e) throws Exception;
	
	@EventListener
	public void delete(ContestEvent.Delete e) throws Exception;
	
	@EventListener
	public void expire(ContestEvent.Expire e) throws Exception;
	
	@EventListener
	public void registedAnswer(ContestEvent.RegistedAnswer e) throws Exception;
	
	@EventListener
	public void completeChoose(ContestEvent.CompleteChoose e) throws Exception;
	
	@EventListener
	public void additionalQuestion(ContestEvent.AdditionalQuestion e) throws Exception;
	
	@EventListener
	public void additionalAnswer(ContestEvent.AdditionalAnswer e) throws Exception;
	
	@EventListener
	public void choose(ContestEvent.Choose e) throws Exception;
	
	@EventListener
	public void pointByChoosed(ContestEvent.PointByChoosed e) throws Exception;
	
}
