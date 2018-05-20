package com.aon.module.contest;

import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import com.aon.module.contest.ContestEvent.AdditionalAnswer;
import com.aon.module.contest.ContestEvent.AdditionalQuestion;
import com.aon.module.contest.ContestEvent.Choose;
import com.aon.module.contest.ContestEvent.CompleteChoose;
import com.aon.module.contest.ContestEvent.Create;
import com.aon.module.contest.ContestEvent.Delete;
import com.aon.module.contest.ContestEvent.Expire;
import com.aon.module.contest.ContestEvent.PointByChoosed;
import com.aon.module.contest.ContestEvent.RegistedAnswer;

/**
 * @author ranian
 * 정보거래 listener class
 */
@Component
public class ContestLogListener implements IContestListener{


	@Override
	@EventListener
	public void create(Create e) {
		System.out.println("create log");
	}		

	@Override
	@EventListener
	public void delete(Delete e) {
		System.out.println("delete log");
	}	
	
	@Override
	@EventListener
	public void expire(Expire e) {
		System.out.println("expire log");
	}	
	
	@Override
	@EventListener
	public void registedAnswer(RegistedAnswer e) {
		System.out.println("registedAnswer log");
	}
	
	@Override
	@EventListener
	public void completeChoose(CompleteChoose e) {
		System.out.println("completeChoose log");
	}
	
	@Override
	@EventListener
	public void additionalQuestion(AdditionalQuestion e) {
		System.out.println("additionalQuestion log");
	}
	
	@Override
	@EventListener
	public void additionalAnswer(AdditionalAnswer e) {
		System.out.println("additionalAnswer log");
	}
	
	@Override
	@EventListener
	public void choose(Choose e) {
		System.out.println("choose log");
	}
	
	@Override
	@EventListener
	public void pointByChoosed(PointByChoosed e) {
		System.out.println("pointByChoosed log");
	}
}
