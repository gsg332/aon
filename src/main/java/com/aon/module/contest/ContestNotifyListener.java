package com.aon.module.contest;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.aon.sys.conf.ConfigService;
import com.aon.sys.msg.MessageService;
import com.aon.sys.usr.User;

/**
 * @author ranian
 * 정보거래 알림 listener class
 */
@Component
public class ContestNotifyListener implements IContestListener{
	
	@Autowired
	private IContestRepository repository;

	@EventListener
	public void create(Create e) throws Exception {

	}

	@EventListener
	public void delete(Delete e) throws Exception {
		
	}
	
	/**
	 * 기간만료 스케줄job 실행 시, 만료된 질문글 작성자에게 알림을 보낸다.
	 */
	@EventListener
	public void expire(Expire e) throws Exception {
		Contest contest = (Contest)e.getSource();
		User receiver = contest.getRegisterUser();
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("id", contest.getId());
		m.put("title", contest.getTitle());
//		m.put("sender", new ScheduleUser());
		
		String content = ConfigService.merge(ContestMessageConfig.EXPIRED, m);
		MessageService.send(content, receiver);
		
	}
	
	/**
	 * 질문글에 답변 등록 시, 질문글 작성자에게 알림을 보낸다.
	 */
	@EventListener
	public void registedAnswer(RegistedAnswer e) throws Exception {
		Contest answer = (Contest)e.getSource();
		Contest contest = repository.findOne(answer.getGroupId());
		User receiver = contest.getRegisterUser();
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("id", contest.getId());
		m.put("title", contest.getTitle());
		m.put("sender", answer.getRegisterUser().getDisplayName());
		
		String content = ConfigService.merge(ContestMessageConfig.REGISTED_ANSWER, m);
		MessageService.send(content, receiver);
	}
	
	/**
	 * 질문 작성자가 채택완료 시, 포인트 차감과 관련된 알림을 보낸다.
	 */
	@EventListener
	public void completeChoose(CompleteChoose e) throws Exception {
		Contest contest = (Contest)e.getSource();
		User receiver = contest.getRegisterUser();
		Map<String, Object> m = new HashMap<String, Object>();
		
		String content = ConfigService.merge(ContestMessageConfig.COMPLETE_CHOOSE, m);
		MessageService.send(content, receiver);
	}
	
	/**
	 * 질문 작성자가 답변에 대한 추가질문 작성 시, 답변자에게 알림을 보내다.
	 */
	@EventListener
	public void additionalQuestion(AdditionalQuestion e) throws Exception {
		Contest additionalQuestion = (Contest)e.getSource();
		Contest contest = repository.findOne(additionalQuestion.getGroupId());
		User receiver = repository.findOne(additionalQuestion.getAnswerGroupId()).getRegisterUser();
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("id", contest.getId());
		m.put("title", contest.getTitle());
		m.put("sender", additionalQuestion.getRegisterUser().getDisplayName());
		
		String content = ConfigService.merge(ContestMessageConfig.ADDITIONAL_QUESTION, m);
		MessageService.send(content, receiver);
	}
	
	/**
	 * 답변자가 추가답변 작성 시, 질문자에게 알림을 보내다.
	 */
	@EventListener
	public void additionalAnswer(AdditionalAnswer e) throws Exception {
		Contest additionalAnswer = (Contest)e.getSource();
		Contest contest = repository.findOne(additionalAnswer.getGroupId());
		User receiver = contest.getRegisterUser();
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("id", contest.getId());
		m.put("answerId", additionalAnswer.getId());
		m.put("title", contest.getTitle());
		m.put("sender", additionalAnswer.getRegisterUser().getDisplayName());
		
		String content = ConfigService.merge(ContestMessageConfig.ADDITIONAL_ANSWER, m);
		MessageService.send(content, receiver);
	}
	
	/**
	 * 질문 작성자가 채택 시, 알림을 보낸다.
	 */
	@EventListener
	public void choose(Choose e) throws Exception {
		Contest answer = (Contest)e.getSource();
		Contest contest = repository.findOne(answer.getGroupId());
		User receiver = answer.getRegisterUser();
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("id", contest.getId());
		m.put("title", contest.getTitle());
		m.put("sender", contest.getRegisterUser().getDisplayName());
		
		String content = ConfigService.merge(ContestMessageConfig.CHOOSE, m);
		MessageService.send(content, receiver);
	}

	/**
	 * 답변 채택 완료시, 답변자에게 포인트 지급 알림을 보낸다.
	 */
	@EventListener
	public void pointByChoosed(PointByChoosed e) throws Exception {
		Contest answer = (Contest)e.getSource();
		User receiver = answer.getRegisterUser();
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("sender", repository.findOne(answer.getGroupId()).getRegisterUser().getDisplayName());
		
		String content = ConfigService.merge(ContestMessageConfig.POINT_CHOOSED, m);
		MessageService.send(content, receiver);
	}
}
